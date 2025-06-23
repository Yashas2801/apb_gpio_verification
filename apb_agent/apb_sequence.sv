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
      PWDATA == 32'hffff_ffff;  //NOTE: last 16 bits are configured as posedge trigger
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

//NOTE:int2 is ptrig =0 , no external clk

class apb_seq_input_int2 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_int2)
  extern function new(string name = "apb_seq_input_int2");
  extern task body;
endclass

function apb_seq_input_int2::new(string name = "apb_seq_input_int2");
  super.new(name);
endfunction

task apb_seq_input_int2::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_int2", UVM_LOW)
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
      PWDATA == 32'h0000_0000;  //NOTE: Negetive trigger
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

//NOTE: eclk with nec = 0;
class apb_seq_input_ext1 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_ext1)
  extern function new(string name = "apb_seq_input_ext1");
  extern task body;
endclass

function apb_seq_input_ext1::new(string name = "apb_seq_input_ext1");
  super.new(name);
endfunction

task apb_seq_input_ext1::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_ext1", UVM_LOW)
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
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'h0000_0000;  //NOTE: Disabling interrupt
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_ECLK;
      PWDATA == 32'hffff_ffff;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_NEC;
      PWDATA == 32'h0000_0000;  //NOTE: posedge eclk sample
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

  end
endtask

//NOTE: eclk with nec = 1;
class apb_seq_input_ext2 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_ext2)
  extern function new(string name = "apb_seq_input_ext2");
  extern task body;
endclass

function apb_seq_input_ext2::new(string name = "apb_seq_input_ext2");
  super.new(name);
endfunction

task apb_seq_input_ext2::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_ext2", UVM_LOW)
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
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'h0000_0000;  //NOTE: Disabling interrupt
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_ECLK;
      PWDATA == 32'hffff_ffff;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_NEC;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: negedge eclk sample
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

  end
endtask

class apb_seq_input extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input)
  extern function new(string name = "apb_seq_input");
  extern task body;
endclass

function apb_seq_input::new(string name = "apb_seq_input");
  super.new(name);
endfunction

task apb_seq_input::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input", UVM_LOW)
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
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'h0000_0000;  //NOTE: Disabling interrupt
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_ECLK;
      PWDATA == 32'h0000_0000;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

  end
endtask

//NOTE: bidirectional
class apb_seq_bidir extends apb_sequence_base;
  `uvm_object_utils(apb_seq_bidir)
  extern function new(string name = "apb_seq_bidir");
  extern task body;
endclass

function apb_seq_bidir::new(string name = "apb_seq_bidir");
  super.new(name);
endfunction

task apb_seq_bidir::body;
  `uvm_info(get_type_name, "In the body of apb_seq_bidir", UVM_LOW)
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
      PWDATA == 32'hABCD_0000;  //NOTE: last 16 bits act as op
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTS;
      PWDATA == 32'h0000_0000;  //NOTE: Clearing sus interrupts if any
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)



    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'h0000_00ff;  //NOTE: Enabling interrupts for first byte
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_PTRIG;
      PWDATA == 32'h0000_00ff;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWDATA == 2'b01;  //NOTE: enabling interrupt from ctrl
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
      PADDR == `GPIO_RGPIO_IN;
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

class ints_reset_seq extends apb_sequence_base;
  `uvm_object_utils(ints_reset_seq)

  extern function new(string name = "ints_reset_seq");
  extern task body;

endclass

function ints_reset_seq::new(string name = "ints_reset_seq");
  super.new(name);
endfunction

task ints_reset_seq::body;
  `uvm_info(get_type_name, "in the body of ints_reset_seq", UVM_LOW)
  req = apb_xtn::type_id::create("req");
  begin
    start_item(req);
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_INTS;
      PWDATA == 32'h0000_0000;
      PWRITE == 1'b1;
    });
    finish_item(req);
  end
endtask

class ctrl_reset_seq extends apb_sequence_base;
  `uvm_object_utils(ctrl_reset_seq)

  extern function new(string name = "ctrl_reset_seq");
  extern task body;

endclass

function ctrl_reset_seq::new(string name = "ctrl_reset_seq");
  super.new(name);
endfunction

task ctrl_reset_seq::body;
  `uvm_info(get_type_name, "in the body of ctrl_reset_seq", UVM_LOW)
  req = apb_xtn::type_id::create("req");
  begin
    start_item(req);
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWDATA == 2'b10;  //NOTE: Disable ctrl[inte]
      PWRITE == 1'b1;
    });
    finish_item(req);
  end
endtask

//NOTE: eclk with nec = 0 and ptrig= 1
//posedge eclk and posedge rgpio_in
class apb_seq_input_ext1_int1 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_ext1_int1)
  extern function new(string name = "apb_seq_input_ext1_int1");
  extern task body;
endclass

function apb_seq_input_ext1_int1::new(string name = "apb_seq_input_ext1_int1");
  super.new(name);
endfunction

task apb_seq_input_ext1_int1::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_ext1_int1", UVM_LOW)
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
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: Enabling all the interrupts
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_ECLK;
      PWDATA == 32'hFFFF_FFFF;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_NEC;
      PWDATA == 32'h0000_0000;  //NOTE: posedge eclk sample
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_PTRIG;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: posedge trigger
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWDATA == 2'b01;  //NOTE: Enabling interrupt from ctrl
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

  end
endtask


//NOTE: eclk with nec = 1 and ptrig= 1
//posedge eclk and posedge rgpio_in
class apb_seq_input_ext2_int1 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_ext2_int1)
  extern function new(string name = "apb_seq_input_ext2_int1");
  extern task body;
endclass

function apb_seq_input_ext2_int1::new(string name = "apb_seq_input_ext2_int1");
  super.new(name);
endfunction

task apb_seq_input_ext2_int1::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_ext2_int1", UVM_LOW)
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
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: Enabling all the interrupts
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_ECLK;
      PWDATA == 32'hFFFF_FFFF;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_NEC;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: negedge eclk sample
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_PTRIG;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: posedge trigger
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWDATA == 2'b01;  //NOTE: Enabling interrupt from ctrl
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

  end
endtask


//NOTE: eclk with nec = 1 and ptrig= 0
//posedge eclk and negedge rgpio_in
class apb_seq_input_ext1_int2 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_ext1_int2)
  extern function new(string name = "apb_seq_input_ext1_int2");
  extern task body;
endclass

function apb_seq_input_ext1_int2::new(string name = "apb_seq_input_ext1_int2");
  super.new(name);
endfunction

task apb_seq_input_ext1_int2::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_ext1_int2", UVM_LOW)
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
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: Enabling all the interrupts
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_ECLK;
      PWDATA == 32'hFFFF_FFFF;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_NEC;
      PWDATA == 32'h0000_0000;  //NOTE: posedge eclk sample
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_PTRIG;
      PWDATA == 32'h0000_0000;  //NOTE: negedge trigger
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWDATA == 2'b01;  //NOTE: Enabling interrupt from ctrl
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

  end
endtask


//NOTE: eclk with nec = 0 and ptrig= 0
//posedge eclk and negedge rgpio_in
class apb_seq_input_ext2_int2 extends apb_sequence_base;
  `uvm_object_utils(apb_seq_input_ext2_int2)
  extern function new(string name = "apb_seq_input_ext2_int2");
  extern task body;
endclass

function apb_seq_input_ext2_int2::new(string name = "apb_seq_input_ext2_int2");
  super.new(name);
endfunction

task apb_seq_input_ext2_int2::body;
  `uvm_info(get_type_name, "In the body of apb_seq_input_ext2_int2", UVM_LOW)
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
      PADDR == `GPIO_RGPIO_INTE;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: Enabling all the interrupts
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_ECLK;
      PWDATA == 32'hFFFF_FFFF;
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)


    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_NEC;
      PWDATA == 32'hFFFF_FFFF;  //NOTE: negedge eclk sample
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_PTRIG;
      PWDATA == 32'h0000_0000;  //NOTE: negedge trigger
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

    ////////////////////////////////////////////////////////////////////////
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      PADDR == `GPIO_RGPIO_CTRL;
      PWDATA == 2'b01;  //NOTE: Enabling interrupt from ctrl
      PWRITE == 1'b1;
    });
    `uvm_info(get_type_name, "configuring RGPIO_OUT to reflect in io_pad", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

  end
endtask


