class io_driver extends uvm_driver #(io_xtn);

  `uvm_component_utils(io_driver);

  virtual interface_io vif;
  io_agent_config a_cfg;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task drive_task(io_xtn xtn);
  extern task run_phase(uvm_phase phase);
endclass

function io_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void io_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build_phase of io_driver", UVM_LOW)
  if (!uvm_config_db#(io_agent_config)::get(this, "", "io_agent_config", a_cfg)) begin
    `uvm_fatal(get_type_name, "failed to get io_agt_config in io_driver")
  end
endfunction

function void io_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In the connect_phase of io_driver", UVM_LOW);
  vif = a_cfg.vif;
  if (vif == null) `uvm_fatal(get_type_name, "vif_error")
endfunction

task io_driver::drive_task(io_xtn xtn);
  `uvm_info(get_type_name, "drive task enabled", UVM_LOW)
  `uvm_info("IO_XTN", $sformatf("printing from io_driver \n , %s", xtn.sprint), UVM_LOW)
  @(vif.drv_cb);
  vif.drv_cb.test_var <= 2'b11;
  vif.drv_cb.io_out <= xtn.io_pad;
  vif.drv_cb.io_en <= ~xtn.io_dir;
endtask


task io_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name, "In the run phase of io_driver", UVM_LOW)
  forever begin
    //vif.drv_cb.test_var <= 2'b10;
    seq_item_port.get_next_item(req);
    drive_task(req);
    seq_item_port.item_done;
  end
endtask
