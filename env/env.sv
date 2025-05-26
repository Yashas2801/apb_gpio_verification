class gpio_env extends uvm_env;
  `uvm_component_utils(gpio_env)

  env_config e_cfg;

  apb_agent apb_agth;
  io_agent io_agth;
  aux_agent aux_agth;

  virtual_sequencer vseqrh;

  scoreboard sb;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass

function gpio_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void gpio_env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db#(env_config)::get(this, "", "env_confgi", e_cfg)) begin
    `uvm_fatal(get_type_name, "Faild to get env_config in env")
  end

  `uvm_info(get_type_name, "In the build_phase of env", UVM_LOW)

  apb_agth = apb_agent::type_id::create("apb_agth", this);
  io_agth  = io_agent::type_id::create("io_agth", this);
  aux_agth = aux_agent::type_id::create("aux_agth", this);

  if (e_cfg.has_virtual_sequencer) begin
    vseqrh = virtual_sequencer::type_id::create("vseqrh", this);
  end

  sb = scoreboard::type_id::create("sb", this);
endfunction

function void gpio_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In the connect phase of env", UVM_LOW);
  vseqrh.apb_seqrh = apb_agth.seqrh;
  vseqrh.aux_seqrh = aux_agth.seqrh;
  vseqrh.io_seqrh  = io_agth.seqrh;
endfunction
