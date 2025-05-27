`include "gpio_defines.sv"
class gpio_reg_block extends uvm_reg_block;
  `uvm_object_utils(gpio_reg_block)

  rand reg_RGPIO_IN    RGPIO_IN;
  rand reg_RGPIO_OUT   RGPIO_OUT;
  rand reg_RGPIO_OE    RGPIO_OE;
  rand reg_RGPIO_INTE  RGPIO_INTE;
  rand reg_RGPIO_PTRIG RGPIO_PTRIG;
  rand reg_RGPIO_AUX   RGPIO_AUX;
  rand reg_RGPIO_CTRL  RGPIO_CTRL;
  rand reg_RGPIO_INTS  RGPIO_INTS;
  rand reg_RGPIO_ECLK  RGPIO_ECLK;
  rand reg_RGPIO_NEC   RGPIO_NEC;

  extern function new(string name = "gpio_reg_block");
  extern function void build();
endclass

function gpio_reg_block::new(string name = "gpio_reg_block");
  super.new(name, UVM_NO_COVERAGE);
endfunction

function void gpio_reg_block::build();
  default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);

  RGPIO_IN = reg_RGPIO_IN::type_id::create("RGPIO_IN");
  RGPIO_IN.configure(this, null, "");
  RGPIO_IN.build();
  default_map.add_reg(RGPIO_IN, `GPIO_RGPIO_IN, "RO");

  RGPIO_OUT = reg_RGPIO_OUT::type_id::create("RGPIO_OUT");
  RGPIO_OUT.configure(this, null, "");
  RGPIO_OUT.build();
  default_map.add_reg(RGPIO_OUT, `GPIO_RGPIO_OUT, "RW");

  RGPIO_OE = reg_RGPIO_OE::type_id::create("RGPIO_OE");
  RGPIO_OE.configure(this, null, "");
  RGPIO_OE.build();
  default_map.add_reg(RGPIO_OE, `GPIO_RGPIO_OE, "RW");

  RGPIO_INTE = reg_RGPIO_INTE::type_id::create("RGPIO_INTE");
  RGPIO_INTE.configure(this, null, "");
  RGPIO_INTE.build();
  default_map.add_reg(RGPIO_INTE, `GPIO_RGPIO_INTE, "RW");

  RGPIO_PTRIG = reg_RGPIO_PTRIG::type_id::create("RGPIO_PTRIG");
  RGPIO_PTRIG.configure(this, null, "");
  RGPIO_PTRIG.build();
  default_map.add_reg(RGPIO_PTRIG, `GPIO_RGPIO_PTRIG, "RW");

  RGPIO_AUX = reg_RGPIO_AUX::type_id::create("RGPIO_AUX");
  RGPIO_AUX.configure(this, null, "");
  RGPIO_AUX.build();
  default_map.add_reg(RGPIO_AUX, `GPIO_RGPIO_AUX, "RW");

  RGPIO_CTRL = reg_RGPIO_CTRL::type_id::create("RGPIO_CTRL");
  RGPIO_CTRL.configure(this, null, "");
  RGPIO_CTRL.build();
  default_map.add_reg(RGPIO_CTRL, `GPIO_RGPIO_CTRL, "RW");

  RGPIO_INTS = reg_RGPIO_INTS::type_id::create("RGPIO_INTS");
  RGPIO_INTS.configure(this, null, "");
  RGPIO_INTS.build();
  default_map.add_reg(RGPIO_INTS, `GPIO_RGPIO_INTS, "RW");

  RGPIO_ECLK = reg_RGPIO_ECLK::type_id::create("RGPIO_ECLK");
  RGPIO_ECLK.configure(this, null, "");
  RGPIO_ECLK.build();
  default_map.add_reg(RGPIO_ECLK, `GPIO_RGPIO_ECLK, "RW");

  RGPIO_NEC = reg_RGPIO_NEC::type_id::create("RGPIO_NEC");
  RGPIO_NEC.configure(this, null, "");
  RGPIO_NEC.build();
  default_map.add_reg(RGPIO_NEC, `GPIO_RGPIO_NEC, "RW");

  lock_model();
endfunction
