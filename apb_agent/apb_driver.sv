class apb_driver extends uvm_driver #(apb_xtn);
  `uvm_component_utils(apb_driver);
  virtual interface_apb vif;
  apb_agent_config a_cfg;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task drive_task(apb_xtn xtn);
  extern task run_phase(uvm_phase phase);
endclass

function apb_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void apb_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build_phase of apb_driver", UVM_LOW)
  if (!uvm_config_db#(apb_agent_config)::get(this, "", "apb_agent_config", a_cfg)) begin
    `uvm_fatal(get_type_name, "failed to get apb_agt_config in apb_driver")
  end
endfunction

function void apb_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In the connect_phase of apb_driver", UVM_LOW);
  vif = a_cfg.vif;
endfunction

task apb_driver::drive_task(apb_xtn xtn);
  `uvm_info(get_type_name, "drive task enabled", UVM_LOW)
  `uvm_info("APB_DRV_XTN", $sformatf("printing from apb_driver \n , %s", xtn.sprint), UVM_LOW)
  //NOTE: making reset high before starting driving
  @(vif.drv_cb);
  vif.drv_cb.PSEL   <= 1'b1;
  vif.drv_cb.PADDR  <= xtn.PADDR;
  vif.drv_cb.PWRITE <= xtn.PWRITE;
  if (vif.drv_cb.PWRITE) vif.drv_cb.PWDATA <= xtn.PWDATA;
  @(vif.drv_cb);
  vif.drv_cb.PENABLE <= 1'b1;

  while (!vif.drv_cb.PREADY) @(vif.drv_cb);

  vif.drv_cb.PENABLE <= 1'b0;

endtask

task apb_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name, "In the run phase of apb_driver", UVM_LOW)

  @(vif.drv_cb);
  vif.drv_cb.PRESETn <= 1'b0;
  vif.drv_cb.PSEL <= 1'b0;
  vif.drv_cb.PADDR <= 'b0;
  vif.drv_cb.PWRITE <= 'b0;
  vif.drv_cb.PENABLE <= 1'b0;
  vif.drv_cb.PWDATA <= 'b0;
  @(vif.drv_cb);
  vif.drv_cb.PRESETn <= 1'b1;

  forever begin
    seq_item_port.get_next_item(req);
    drive_task(req);
    seq_item_port.item_done;
  end
endtask


