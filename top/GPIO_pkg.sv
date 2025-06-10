`timescale 1ns / 10ps

package GPIO_pkg;
  import uvm_pkg::*;


  `include "gpio_defines.sv"
  `include "uvm_macros.svh"

  `include "ral.sv"
  `include "gpio_reg_block.sv"

  `include "apb_xtn.sv"
  `include "io_xtn.sv"
  `include "aux_xtn.sv"

  `include "apb_agent_config.sv"
  `include "io_agent_config.sv"
  `include "aux_agent_config.sv"

  `include "env_config.sv"

  `include "apb_sequence.sv"
  `include "aux_sequence.sv"
  `include "io_sequence.sv"

  //NOTE: Object classes done

  `include "apb_driver.sv"
  `include "apb_monitor.sv"
  `include "apb_sequencer.sv"
  `include "apb_agent.sv"

  `include "aux_driver.sv"
  `include "aux_monitor.sv"
  `include "aux_sequencer.sv"
  `include "aux_agent.sv"

  `include "io_driver.sv"
  `include "io_monitor.sv"
  `include "io_sequencer.sv"
  `include "io_agent.sv"

  `include "virtual_sequencer.sv"
  `include "virtual_sequence.sv"
  `include "scoreboard.sv"

  `include "env.sv"
  `include "test.sv"

endpackage
