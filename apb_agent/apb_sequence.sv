`include "gpio_defines.sv"
class apb_sequence_base extends uvm_sequence #(apb_xtn);
  `uvm_object_utils(apb_sequence_base)

  env_config e_cfg;

  extern function new(string name = "apb_sequence_base");
  extern task body;
endclass

function apb_sequence_base::new(string name = "apb_sequence_base");
  super.new(name);
endfunction

task apb_sequence_base::body();
  `uvm_info(get_type_name, "In the body of apb_seq_base", UVM_LOW)
  if (!uvm_config_db#(env_config)::get(null, get_full_name, "env_config", e_cfg))
    `uvm_fatal(get_type_name, "failed to get env_config in apb_seqs")
endtask

class apb_seq_output extends apb_sequence_base;
  `uvm_object_utils(apb_seq_output)
  extern function new(string name = "apb_seq_output");
  extern task body;
endclass

function apb_seq_output::new(string name = "apb_seq_output");
  super.new(name);
endfunction

task apb_seq_output::body;
  `uvm_info(get_type_name, "In the body of apb_seq_output", UVM_LOW)
  super.body();
  begin
    req = apb_xtn::type_id::create("req");
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_OE;
      PWDATA == e_cfg.rgpio_oe;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OE as all_outputs", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////

    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_OUT;
      PWDATA == 32'hABCD_CAFE;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    //NOTE: Clearing INTE as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'h0000_0000;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)
  end
endtask


class apb_seq_output_aux extends apb_sequence_base;
  `uvm_object_utils(apb_seq_output_aux)
  extern function new(string name = "apb_seq_output_aux");
  extern task body;
endclass

function apb_seq_output_aux::new(string name = "apb_seq_output_aux");
  super.new(name);
endfunction

task apb_seq_output_aux::body;
  `uvm_info(get_type_name, "In the body of apb_seq_output_aux", UVM_LOW)
  super.body();
  begin
    req = apb_xtn::type_id::create("req");
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_OE;
      PWDATA == e_cfg.rgpio_oe;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OE as all_outputs", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////

    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_AUX;
      PWDATA == 32'hffff_ffff;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    //NOTE: Clearing INTE as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'h0000_0000;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)
  end
endtask

//NOTE:int1 is ptrig =1 , no external clk

class apb_seq_input_int1 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_int1)
  extern function new(string name = "apb_seq_input_int1");
  extern task body;
endclass

function apb_seq_input_int1::new(string name = "apb_seq_input_int1");
  super.new(name);
endfunction

task apb_seq_input_int1::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_int1", UVM_LOW)
  super.body();
  begin
    req = apb_xtn::type_id::create("req");
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_OE;
      PWDATA == e_cfg.rgpio_oe;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OE as all_outputs", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////

    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_PTRIG;
      PWDATA == 32'hffff_ffff;//NOTE: last 16 bits are configured as posedge trigger 
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    //NOTE: Clearing INTS as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTS;
      PWDATA == 32'h0000_0000;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)
 

    ////////////////////////////////////////////////////////////////////////
    //NOTE: Enabling interrupts as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'hffff_ffff;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    //NOTE: Enabling interrupts from ctrl as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWDATA == 2'b01;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

 end
endtask

class apb_read extends apb_sequence_base;
  `uvm_object_utils(apb_read)
  extern function new(string name = "apb_read");
  extern task body;
endclass

function apb_read::new(string name = "apb_read");
  super.new(name);
endfunction

task apb_read::body;
  `uvm_info(get_type_name, "In the body of apb_read", UVM_LOW)
  super.body();
  begin
    req = apb_xtn::type_id::create("req");
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_OE;
      PWRITE == 1'b0;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OE as all_outputs", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////

    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_PTRIG;
      PWRITE == 1'b0;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    //NOTE: Clearing INTS as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTS;
      PWRITE == 1'b0;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)
 
    ////////////////////////////////////////////////////////////////////////
    //NOTE: clearing interrupts in ints
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTS;
      PWDATA == 32'h0000_0000;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    //NOTE: Enabling interrupts as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTE;
      PWRITE == 1'b0;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    //NOTE: Enabling interrupts from ctrl as per the spec
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWRITE == 1'b0;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

 end
endtask
