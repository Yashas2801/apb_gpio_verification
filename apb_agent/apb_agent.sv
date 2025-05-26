class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  apb_agent_config a_cfg;

  apb_driver       drvh;
  apb_sequencer    seqrh;
  apb_monitor      monh;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "In build_phase of apb_agent", UVM_LOW);

    if (!uvm_config_db#(apb_agent_config)::get(this, "", "apb_agent_config", a_cfg)) begin
      `uvm_fatal(get_type_name(), "Failed to get apb_agent_config");
    end

    monh = apb_monitor::type_id::create("monh", this);

    if (a_cfg.is_active == UVM_ACTIVE) begin
      drvh  = apb_driver::type_id::create("drvh", this);
      seqrh = apb_sequencer::type_id::create("seqrh", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "In connect_phase of apb_agent", UVM_LOW);
    drvh.seq_item_port.connect(seqrh.seq_item_export);
  endfunction

endclass
