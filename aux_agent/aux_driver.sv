class aux_driver extends uvm_driver #(aux_xtn);
  `uvm_component_utils(aux_driver);

  virtual interface_aux vif;
  aux_agent_config a_cfg;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task drive_task(aux_xtn xtn);
  extern task run_phase(uvm_phase phase);
endclass

function aux_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void aux_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build_phase of aux_driver", UVM_LOW)
  if (!uvm_config_db#(aux_agent_config)::get(this, "", "aux_agent_config", a_cfg)) begin
    `uvm_fatal(get_type_name, "failed to get aux_agt_config in aux_driver")
  end
endfunction

function void aux_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In the connect_phase of aux_driver", UVM_LOW);
  vif = a_cfg.vif;
endfunction

task aux_driver::drive_task(aux_xtn xtn);
  `uvm_info(get_type_name, "drive task enabled", UVM_LOW)
  `uvm_info("AUX_DRV_XTN", $sformatf("printing from aux_driver \n , %s", xtn.sprint), UVM_LOW)
  @(vif.drv_cb);
  vif.drv_cb.aux_in <= xtn.aux_in;
endtask

task aux_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name, "In the run phase of aux_driver", UVM_LOW)
  forever begin
    seq_item_port.get_next_item(req);
    drive_task(req);
    seq_item_port.item_done;
  end
endtask
