class gpio_test_base extends uvm_test;
  `uvm_component_utils(gpio_test_base)

  gpio_env envh;
  env_config e_cfg;

  apb_agent_config apb_cfg;
  aux_agent_config aux_cfg;
  io_agent_config io_cfg;

  bit has_virtual_sequencer = 1;
  bit has_scoreboard = 1;
  bit has_ral_model = 1;

  virtual_seqs_base vseqs_base;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void gpio_config;
endclass

function gpio_test_base::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void gpio_test_base::gpio_config;
  apb_cfg = apb_agent_config::type_id::create("apb_cfg");
  aux_cfg = aux_agent_config::type_id::create("aux_cfg");
  io_cfg  = io_agent_config::type_id::create("io_cfg");

  //NOTE: getting vif from top and setting it.
  if (!uvm_config_db#(virtual interface_apb)::get(this, "", "vif_apb", apb_cfg.vif))
    `uvm_fatal(get_type_name, "failed to get vif_apb in test from top")
  if (!uvm_config_db#(virtual interface_aux)::get(this, "", "vif_aux", aux_cfg.vif))
    `uvm_fatal(get_type_name, "failed to get vif_aux in test from top")
  if (!uvm_config_db#(virtual interface_io)::get(this, "", "vif_io", io_cfg.vif))
    `uvm_fatal(get_type_name, "failed to get vif_io in test from top")

  //NOTE: making all agents as active
  apb_cfg.is_active = UVM_ACTIVE;
  aux_cfg.is_active = UVM_ACTIVE;
  io_cfg.is_active = UVM_ACTIVE;

  e_cfg.apb_cfg = apb_cfg;
  e_cfg.aux_cfg = aux_cfg;
  e_cfg.io_cfg = io_cfg;

endfunction

function void gpio_test_base::build_phase(uvm_phase phase);
  super.build_phase(phase);

  `uvm_info(get_type_name, "In the build_phase of base test", UVM_LOW)

  e_cfg = env_config::type_id::create("e_cfg");

  gpio_config;

  e_cfg.has_virtual_sequencer = has_virtual_sequencer;
  e_cfg.has_scoreboard = has_scoreboard;
  e_cfg.has_ral_model = has_ral_model;

  uvm_config_db#(env_config)::set(this, "*", "env_config", e_cfg);

  envh = gpio_env::type_id::create("envh", this);
endfunction

function void gpio_test_base::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  `uvm_info(get_type_name, "In the end_of_elaboration_phase of test", UVM_LOW)
  uvm_top.print_topology;
endfunction

task gpio_test_base::run_phase(uvm_phase phase);
  super.run_phase(phase);
  vseqs_base = virtual_seqs_base::type_id::create("vseqs_base");
  phase.raise_objection(this);
  vseqs_base.start(envh.vseqrh);
  phase.drop_objection(this);
endtask
