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
endfunction

function void io_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In the connect_phase of io_driver", UVM_LOW);
  vif = a_cfg.vif;
endfunction

task io_driver::drive_task(io_xtn xtn);
  `uvm_info(get_type_name, "drive task enabled", UVM_LOW)
  `uvm_info("AUX_DRV_XTN", $sformatf("printing from io_driver \n , %s", xtn.sprint), UVM_LOW)
endtask

task io_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  #10;  //WARN:dummy delay, remove this
  `uvm_info(get_type_name, "In the run phase of io_driver", UVM_LOW)
endtask
