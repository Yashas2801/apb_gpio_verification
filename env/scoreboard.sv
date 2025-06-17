class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(apb_xtn) apb_fifo;
  uvm_tlm_analysis_fifo #(aux_xtn) aux_fifo;
  uvm_tlm_analysis_fifo #(io_xtn) io_fifo;

  apb_xtn apb_h;
  io_xtn io_h;
  aux_xtn aux_h;

  //Local reg handels
  reg [31:0] rgpio_in;
  reg [31:0] rgpio_out;
  reg [31:0] rgpio_aux;
  reg [31:0] rgpio_eclk;
  reg [31:0] rgpio_ptrig;
  reg [31:0] rgpio_nec;
  reg [31:0] rgpio_ints;
  reg [31:0] rgpio_inte;
  reg [1:0] rgpio_ctrl;
  reg [31:0] rgpio_oe;

  gpio_reg_block reg_block_h;
  uvm_reg_data_t data1, data2, data3, data4, data5, data6, data7, data8, data9, data10;
  uvm_status_e status;

  env_config e_cfg;

  int out_seq_pass;
  int out_seq_error;
  int in_seq_pass;
  int in_seq_error;
  int aux_seq_pass;
  int aux_seq_error;
  int ext_seq_pass;
  int ext_seq_fail;

  ///////////////////ref_model_signals////////////////////////////////////
  logic [31:0] extc_in;
  logic [31:0] in_mux;
  logic [31:0] rgpio_ints_e;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  //  extern task compare(apb_xtn apb_h, io_xtn io_h, aux_xtn aux_h);
  extern function void check_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task sample_reg;
  extern task sample_signals;
endclass

task scoreboard::sample_signals;
  logic [31:0] io_dir = io_h.io_dir;
  logic [31:0] in_pad_i;
  `uvm_info(get_type_name, $sformatf("io_dir = %0h", io_dir), UVM_LOW)
  for (int i = 0; i < 32; i++) begin
    if (io_dir[i]) in_pad_i[i] = io_h.io_pad[i];
  end
  extc_in = (~rgpio_nec & in_pad_i) | (rgpio_nec & in_pad_i);
  in_mux = (rgpio_eclk & extc_in) | (~rgpio_eclk & in_pad_i);
  rgpio_ints_e = (rgpio_ints_e | (((in_mux ^ rgpio_in) & ~(in_mux ^ rgpio_ptrig)) & rgpio_inte));
  `uvm_info(get_type_name, $sformatf(
                               "extc_in = %0h, in_mux = %0h, ints_e = %0h, prtig = %h,inte = %h",
                               extc_in, in_mux, rgpio_ints_e, rgpio_ptrig, rgpio_inte), UVM_LOW)

endtask

function scoreboard::new(string name, uvm_component parent);
  super.new(name, parent);
  apb_fifo = new("apb_fifo", this);
  aux_fifo = new("aux_fifo", this);
  io_fifo  = new("io_fifo", this);
endfunction

function void scoreboard::build_phase(uvm_phase phase);
  if (!uvm_config_db#(env_config)::get(this, "", "env_config", e_cfg))
    `uvm_error(get_type_name, "Failed to get config is sb")
  reg_block_h = e_cfg.reg_block_h;
endfunction

task scoreboard::sample_reg;
  this.reg_block_h.RGPIO_IN.read(status, data1, .path(UVM_BACKDOOR),
                                 .map(reg_block_h.GPIO_REG_MAP));
  rgpio_in = data1[31:0];
  this.reg_block_h.RGPIO_OUT.read(status, data2, .path(UVM_BACKDOOR),
                                  .map(reg_block_h.GPIO_REG_MAP));
  rgpio_out = data2[31:0];
  this.reg_block_h.RGPIO_OE.read(status, data3, .path(UVM_BACKDOOR),
                                 .map(reg_block_h.GPIO_REG_MAP));
  rgpio_oe = data3[31:0];
  this.reg_block_h.RGPIO_INTE.read(status, data4, .path(UVM_BACKDOOR),
                                   .map(reg_block_h.GPIO_REG_MAP));
  rgpio_inte = data4[31:0];
  this.reg_block_h.RGPIO_PTRIG.read(status, data5, .path(UVM_BACKDOOR),
                                    .map(reg_block_h.GPIO_REG_MAP));
  rgpio_ptrig = data5[31:0];
  this.reg_block_h.RGPIO_AUX.read(status, data6, .path(UVM_BACKDOOR),
                                  .map(reg_block_h.GPIO_REG_MAP));
  rgpio_aux = data6[31:0];
  this.reg_block_h.RGPIO_CTRL.read(status, data7, .path(UVM_BACKDOOR),
                                   .map(reg_block_h.GPIO_REG_MAP));
  rgpio_ctrl = data7[1:0];
  this.reg_block_h.RGPIO_INTS.read(status, data8, .path(UVM_BACKDOOR),
                                   .map(reg_block_h.GPIO_REG_MAP));
  rgpio_ints = data8[31:0];
  this.reg_block_h.RGPIO_ECLK.read(status, data9, .path(UVM_BACKDOOR),
                                   .map(reg_block_h.GPIO_REG_MAP));
  rgpio_eclk = data9[31:0];
  this.reg_block_h.RGPIO_NEC.read(status, data10, .path(UVM_BACKDOOR),
                                  .map(reg_block_h.GPIO_REG_MAP));
  rgpio_nec = data10[31:0];

  rgpio_ints_e = rgpio_ints;
  `uvm_info(get_type_name, $sformatf("Ints sampled = %0h", rgpio_ints), UVM_LOW)
  sample_signals;
endtask

task scoreboard::run_phase(uvm_phase phase);
  forever begin
    fork
      apb_fifo.get(apb_h);
      io_fifo.get(io_h);
      aux_fifo.get(aux_h);
    join
    sample_reg;
  end
endtask

function void scoreboard::check_phase(uvm_phase phase);
  /////////////////////////////////GPIO as ouput//////////////////////////////////////////
  if (e_cfg.is_out) begin
    `uvm_info("RGPIO_OUT_SAMPLED", $sformatf("rgpio_out = %0h", rgpio_out), UVM_LOW)
    `uvm_info(get_type_name, "Final Check for gpio as output", UVM_LOW)
    for (int i = 0; i < 32; i++) begin
      if (io_h.io_pad[i] == rgpio_out[i]) begin
        out_seq_pass++;
      end else begin
        out_seq_error++;
      end
    end
    if (out_seq_pass > 0) begin
      `uvm_info(get_type_name, "gpio as output is verified", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("out_seq_pass = %0d", out_seq_pass), UVM_LOW)
    end else begin
      `uvm_info(get_type_name, "gpio as output is wrong", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("out_seq_error = %0d", out_seq_error), UVM_LOW)
    end
  end
  /////////////////////////////////GPIO as ouput_aux//////////////////////////////////////////
  if (e_cfg.is_out_aux) begin
    `uvm_info("RGPIO_AUX_SAMPLED", $sformatf("rgpio_aux = %0h", rgpio_aux), UVM_LOW)
    `uvm_info(get_type_name, "Final Check for gpio as output_aux", UVM_LOW)
    for (int i = 0; i < 32; i++) begin
      if (io_h.io_pad[i] == aux_h.aux_in[i]) begin
        aux_seq_pass++;
      end else begin
        aux_seq_error++;
      end
    end
    if (aux_seq_pass > 0) begin
      `uvm_info(get_type_name, "gpio as output_aux is verified", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("aux_seq_pass = %0d", aux_seq_pass), UVM_LOW)
    end else begin
      `uvm_info(get_type_name, "gpio as output_aux is failed", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("aux_seq_error = %0d", aux_seq_error), UVM_LOW)
    end
  end

  /////////////////////////////////GPIO as input//////////////////////////////////////////
  if (e_cfg.is_in) begin
    `uvm_info("as_input", $sformatf("rgpio_oe = %0h", rgpio_oe), UVM_LOW)
    `uvm_info("as_input", $sformatf("rgpio_eclk = %0h", rgpio_eclk), UVM_LOW)
    `uvm_info("as_input", $sformatf("rgpio_inte = %0h", rgpio_inte), UVM_LOW)
    `uvm_info(get_type_name, "Final Check for gpio as input", UVM_LOW)
    for (int i = 0; i < 32; i++) begin
      if (rgpio_in[i] == io_h.io_pad[i]) begin
        in_seq_pass++;
      end else begin
        in_seq_error++;
      end
    end
    if (in_seq_pass > 0) begin
      `uvm_info(get_type_name, "gpio as input is verified", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("in_seq_pass = %0d", in_seq_pass), UVM_LOW)
    end else begin
      `uvm_info(get_type_name, "gpio as input is failed", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("in_seq_error = %0d", in_seq_error), UVM_LOW)
    end
  end

  /////////////////////////////////GPIO as input_interrupt//////////////////////////////////////////
  if (e_cfg.is_in_int1 | e_cfg.is_in_int2 | e_cfg.is_in_ext1_int1 | e_cfg.is_in_ext2_int1|
    e_cfg.is_in_ext1_int2 | e_cfg.is_in_ext2_int2) begin
    `uvm_info("as_input_int1", $sformatf("rgpio_oe = %0h", rgpio_oe), UVM_LOW)
    `uvm_info("as_input_int1", $sformatf("rgpio_eclk = %0h", rgpio_eclk), UVM_LOW)
    `uvm_info("as_input_int1", $sformatf("rgpio_inte = %0h", rgpio_inte), UVM_LOW)
    `uvm_info(get_type_name, $sformatf("rgpio_ctrl= %0b", rgpio_ctrl), UVM_LOW)
    `uvm_info(get_type_name, "Final Check for gpio as input_interrupt", UVM_LOW)
    if ((|rgpio_inte) && rgpio_ctrl[0] == 1) begin
      if (|rgpio_eclk) begin
        for (int i = 0; i < 32; i++) begin
          if (rgpio_eclk[i]) begin
            `uvm_info("rgpio_eclk", $sformatf("rgpio_eclk[%0d] is set", i), UVM_LOW)
            if (rgpio_nec[i]) begin
              `uvm_info("rgpio_nec", $sformatf("rgpio_nec[%0d] is set", i), UVM_LOW)
            end
            if (rgpio_ptrig[i]) begin
              `uvm_info("rgpio_ptrig", $sformatf("rgpio_nec[%0d] is set", i), UVM_LOW)
            end
          end
        end
      end
      `uvm_info(get_type_name,
                "one or more pins are configured as interrupt and ctrl[inte] is set", UVM_LOW)
      if (rgpio_ints_e == rgpio_ints) begin
        `uvm_info(get_type_name, "Ints matched", UVM_LOW)
        if (apb_h.IRQ) begin
          `uvm_info("interrupt verified", "IRQ generated and interrupt verified", UVM_LOW)
          if (e_cfg.is_in_int1)
            `uvm_info("In_int1_verified", "Interrupt verified @ ptrig == 1", UVM_LOW)
          if (e_cfg.is_in_int2)
            `uvm_info("In_int2_verified", "Interrupt verified @ ptrig == 0", UVM_LOW)
        end else begin
          `uvm_info(get_type_name, "IRQ not generated, Interrupt not working", UVM_LOW)
        end
      end else begin
        `uvm_info(get_type_name, "Ints not matched ", UVM_LOW)
      end
    end else begin
      `uvm_info(
          "Interrupt Not configured",
          "eather pins are not configured as interrupt or interrupt is disabled from rgpio_ctrl",
          UVM_LOW)
    end
  end
  /////////////////////////////////GPIO_as_external_clk////////////////////////////////////

  if (e_cfg.is_in_ext1 | e_cfg.is_in_ext2) begin
    for (int i = 0; i < 32; i++) begin
      if (rgpio_eclk[i]) begin
        `uvm_info("rgpio_eclk", $sformatf("rgpio_eclk[%0d] is set", i), UVM_LOW)
        if (rgpio_in[i] == io_h.io_pad[i]) begin
          ext_seq_pass++;
          // `uvm_info(get_type_name, "Data match with rgpio_in and io_pad", UVM_LOW)
        end else begin
          ext_seq_fail++;
          //`uvm_info(get_type_name, "Data not sampled properly", UVM_LOW)
        end
      end else `uvm_info("rgpio_eclk", $sformatf("rgpio_eclk[%0d] is not set", i), UVM_LOW)
    end

    if (ext_seq_pass > 0) begin
      `uvm_info(get_type_name, "external _clk sampling is verified", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("ext_seq_pass = %0d", ext_seq_pass), UVM_LOW)
      if (e_cfg.is_in_ext1) begin
        `uvm_info("input_ext1", "input_external_clk_posedge pass", UVM_LOW)
      end
      if (e_cfg.is_in_ext2) begin
        `uvm_info("input_ext2", "input_external_clk_negedge pass", UVM_LOW)
      end
    end else begin
      `uvm_info(get_type_name, "external _clk sampling is not verified", UVM_LOW)
      `uvm_info(get_type_name, $sformatf("ext_seq_fail = %0d", ext_seq_fail), UVM_LOW)
    end

  end
endfunction
