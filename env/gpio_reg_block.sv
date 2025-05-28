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

  uvm_reg_map GPIO_REG_MAP;
  extern function new(string name = "gpio_reg_block");
  extern function void build();
endclass

function gpio_reg_block::new(string name = "gpio_reg_block");
  super.new(name, UVM_NO_COVERAGE);
endfunction

function void gpio_reg_block::build();
  
  GPIO_REG_MAP = create_map("GPIO_REG_MAP",'h0,4,UVM_LITTLE_ENDIAN,1);
  default_map = GPIO_REG_MAP;

  RGPIO_IN = reg_RGPIO_IN::type_id::create("RGPIO_IN");
  RGPIO_IN.configure(this, null, "");
  RGPIO_IN.build();
  RGPIO_IN.add_hdl_path_slice("rgpio_in",0,32);

  RGPIO_OUT = reg_RGPIO_OUT::type_id::create("RGPIO_OUT");
  RGPIO_OUT.configure(this, null, "");
  RGPIO_OUT.build();
  RGPIO_OUT.add_hdl_path_slice("rgpio_out",0,32);

  RGPIO_OE = reg_RGPIO_OE::type_id::create("RGPIO_OE");
  RGPIO_OE.configure(this, null, "");
  RGPIO_OE.build();
  RGPIO_OE.add_hdl_path_slice("rgpio_oe",0,32);

  RGPIO_INTE = reg_RGPIO_INTE::type_id::create("RGPIO_INTE");
  RGPIO_INTE.configure(this, null, "");
  RGPIO_INTE.build();
  RGPIO_INTE.add_hdl_path_slice("rgpio_inte",0,32);

  RGPIO_PTRIG = reg_RGPIO_PTRIG::type_id::create("RGPIO_PTRIG");
  RGPIO_PTRIG.configure(this, null, "");
  RGPIO_PTRIG.build();
  RGPIO_PTRIG.add_hdl_path_slice("rgpio_ptrig",0,32);

  RGPIO_AUX = reg_RGPIO_AUX::type_id::create("RGPIO_AUX");
  RGPIO_AUX.configure(this, null, "");
  RGPIO_AUX.build();
  RGPIO_AUX.add_hdl_path_slice("rgpio_aux",0,32);

  RGPIO_CTRL = reg_RGPIO_CTRL::type_id::create("RGPIO_CTRL");
  RGPIO_CTRL.configure(this, null, "");
  RGPIO_CTRL.build();
  RGPIO_CTRL.add_hdl_path_slice("rgpio_ctrl",0,2);

  RGPIO_INTS = reg_RGPIO_INTS::type_id::create("RGPIO_INTS");
  RGPIO_INTS.configure(this, null, "");
  RGPIO_INTS.build();
  RGPIO_INTS.add_hdl_path_slice("rgpio_ints",0,32);

  RGPIO_ECLK = reg_RGPIO_ECLK::type_id::create("RGPIO_ECLK");
  RGPIO_ECLK.configure(this, null, "");
  RGPIO_ECLK.build();
  RGPIO_ECLK.add_hdl_path_slice("rgpio_eclk",0,32);

  RGPIO_NEC = reg_RGPIO_NEC::type_id::create("RGPIO_NEC");
  RGPIO_NEC.configure(this, null, "");
  RGPIO_NEC.build();
  RGPIO_NEC.add_hdl_path_slice("rgpio_nec",0,32);
	
  default_map.add_reg(RGPIO_IN, `GPIO_RGPIO_IN, "RO");
  default_map.add_reg(RGPIO_INTE, `GPIO_RGPIO_INTE, "RW");
  default_map.add_reg(RGPIO_OUT, `GPIO_RGPIO_OUT, "RW");
  default_map.add_reg(RGPIO_OE, `GPIO_RGPIO_OE, "RW");
  default_map.add_reg(RGPIO_NEC, `GPIO_RGPIO_NEC, "RW");
  default_map.add_reg(RGPIO_ECLK, `GPIO_RGPIO_ECLK, "RW");
  default_map.add_reg(RGPIO_INTS, `GPIO_RGPIO_INTS, "RW");
  default_map.add_reg(RGPIO_CTRL, `GPIO_RGPIO_CTRL, "RW");
  default_map.add_reg(RGPIO_AUX, `GPIO_RGPIO_AUX, "RW");
  default_map.add_reg(RGPIO_PTRIG, `GPIO_RGPIO_PTRIG, "RW");

add_hdl_path("top.i1.reg_instance","register");
  lock_model();
endfunction
