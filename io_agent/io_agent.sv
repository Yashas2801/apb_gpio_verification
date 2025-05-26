class io_agent extends uvm_agent;
  `uvm_component_utils(io_agent);

  io_agnet_config a_cfg;

  io_driver drvh;
  io_monitor monh;
  io_sequencer seqrh;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

function io_agent::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void io_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "in the build phase of io agent", UVM_LOW)

  if (!uvm_config_db#(io_agent_config)::get(this, "", "io_agent_config", a_cfg)) begin
    `uvm_fatal(get_type_name, "faild to get agent_config in io_agent")
  end

  monh = io_monitor::type_id::create("monh", this);

  if (a_cfg.is_active == UVM_ACTIVE) begin
    drvh  = io_driver::type_id::create("drvh", this);
    seqrh = io_sequencer::type_id::create("seqrh", this);
  end

endfunction

function void io_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "in the connect phase of io_agent", UVM_LOW)
endfunction
