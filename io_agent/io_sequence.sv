class io_sequence_base extends uvm_sequence #(io_xtn);
  `uvm_object_utils(io_sequence_base)

  env_config e_cfg;

  extern function new(string name = "io_sequence_base");
  extern task body;
endclass

function io_sequence_base::new(string name = "io_sequence_base");
  super.new(name);
endfunction

task io_sequence_base::body();
  `uvm_info(get_type_name, "In the body of io_seq_base", UVM_LOW)
  if (!uvm_config_db#(env_config)::get(null, get_full_name, "env_config", e_cfg))
    `uvm_fatal(get_type_name, "failed to get env_config in io_seqs")
endtask

class io_seq_output extends io_sequence_base;
  `uvm_object_utils(io_seq_output)

  extern function new(string name = "io_seq_output");
  extern task body;
endclass

function io_seq_output::new(string name = "io_seq_output");
  super.new(name);
endfunction

task io_seq_output::body;
  super.body;
  begin
    req = io_xtn::type_id::create("req");
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    //NOTE: io_pad is not valid since io_interface drives 'hz because of
    //io_dir
    assert (req.randomize() with {
      io_pad == 32'h0000_0000;
      io_dir == e_cfg.rgpio_oe;
    });
    `uvm_info(get_type_name, "driving 'hz since every pin is acting as output", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)
  end
endtask

class io_seq_input_int1 extends io_sequence_base;
  `uvm_object_utils(io_seq_input_int1)

  extern function new(string name = "io_seq_input_int1");
  extern task body;
endclass

function io_seq_input_int1::new(string name = "io_seq_input_int1");
  super.new(name);
endfunction

task io_seq_input_int1::body;
  super.body;
  begin
    req = io_xtn::type_id::create("req");
    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    //NOTE: io_pad is not valid since io_interface drives 'hz because of
    //io_dir
    assert (req.randomize() with {
      io_pad == 32'h0000_0000;
      io_dir == e_cfg.rgpio_oe;
    });
    `uvm_info(get_type_name, "driving 'hz since every pin is acting as output", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)

/////////////////////////////////////////////////////////////////////////////

    start_item(req);
    `uvm_info(get_type_name, "start_item unblocked", UVM_LOW)
    assert (req.randomize() with {
      io_pad == 32'hffff_ffff;
      io_dir == e_cfg.rgpio_oe;
    });
    `uvm_info(get_type_name, "driving 'hz since every pin is acting as output", UVM_LOW)
    `uvm_info(get_type_name, $sformatf("printing from sequence \n %s", req.sprint()), UVM_HIGH)
    finish_item(req);
    `uvm_info(get_type_name, "finish_item unblocked", UVM_LOW)
  end
endtask
