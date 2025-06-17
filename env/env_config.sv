class env_config extends uvm_object;
  `uvm_object_utils(env_config)

  bit [31:0] rgpio_oe;

  bit has_virtual_sequencer;
  bit has_scoreboard;
  bit has_ral_model;

  apb_agent_config apb_cfg;
  io_agent_config io_cfg;
  aux_agent_config aux_cfg;

  gpio_reg_block reg_block_h;

  function new(string name = "env_config");
    super.new(name);
  endfunction

  bit is_out;
  bit is_out_aux;
  bit is_in_int1;
  bit is_in_int2;
  bit is_in_ext1;
  bit is_in_ext2;
  bit is_bidir;
  bit is_in;
  bit is_in_ext1_int1;
  bit is_in_ext2_int1;
  bit is_in_ext1_int2;
  bit is_in_ext2_int2;
  bit is_in_int_clr;


endclass
