class aux_agent extends uvm_agent;
  `uvm_component_utils(aux_agent)

  aux_agent_config a_cfg;

  aux_driver drvh;
  aux_monitor monh;
  aux_sequencer seqrh;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

function aux_agent::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void aux_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "in the build phase of aux agent", UVM_LOW)

  if (!uvm_config_db#(aux_agent_config)::get(this, "", "aux_agent_config", a_cfg)) begin
    `uvm_fatal(get_type_name, "faild to get agent_config in aux_agent")
  end
  monh = aux_monitor::type_id::create("monh", this);

  if (a_cfg.is_active == UVM_ACTIVE) begin
    drvh  = aux_driver::type_id::create("drvh", this);
    seqrh = aux_sequencer::type_id::create("seqrh", this);
  end

endfunction

function void aux_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "in the connect phase of aux_agent", UVM_LOW)
  drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction
