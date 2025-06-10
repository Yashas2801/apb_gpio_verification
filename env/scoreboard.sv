class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo #(apb_xtn) apb_fifo;
	uvm_tlm_analysis_fifo #(aux_xtn) aux_fifo;
	uvm_tlm_analysis_fifo #(io_xtn) io_fifo;
	
	apb_xtn apb_h;
	io_xtn io_h;
	aux_xtn aux_h;

	//Local reg handels
	reg [31:0]rgpio_in;
	reg [31:0]rgpio_out;
	reg [31:0]rgpio_aux;
	reg [31:0]rgpio_eclk;
	reg [31:0]rgpio_ptrig;
	reg [31:0]rgpio_nec;
	reg [31:0]rgpio_ints;
	reg [31:0]rgpio_inte;
	reg [1:0]rgpio_ctrl;
	reg [31:0]rgpio_oe;
	
	gpio_reg_block reg_block_h;
	uvm_reg_data_t data1,data2,data3,data4,data5,data6,data7,data8,data9,data10;
	uvm_status_e status;

	env_config e_cfg;

	int out_seq_pass;
	int in_seq_pass;
	int out_seq_error;
	int in_seq_error;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
//  extern task compare(apb_xtn apb_h, io_xtn io_h, aux_xtn aux_h);
  extern function void check_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task sample_reg;
endclass

function scoreboard::new(string name, uvm_component parent);
  super.new(name, parent);
  apb_fifo = new("apb_fifo",this);
  aux_fifo = new("aux_fifo",this);
  io_fifo = new("io_fifo",this);
endfunction

function void scoreboard::build_phase(uvm_phase phase);
	if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
		`uvm_error(get_type_name,"Failed to get config is sb")
	reg_block_h = e_cfg.reg_block_h;
endfunction

task scoreboard::sample_reg;
	this.reg_block_h.RGPIO_IN.read(status,data1,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data1;
	this.reg_block_h.RGPIO_OUT.read(status,data2,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_out = data2;
	this.reg_block_h.RGPIO_OE.read(status,data3,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data3;
	this.reg_block_h.RGPIO_INTE.read(status,data4,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data4;
	this.reg_block_h.RGPIO_PTRIG.read(status,data5,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data5;
	this.reg_block_h.RGPIO_AUX.read(status,data6,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data6;
	this.reg_block_h.RGPIO_CTRL.read(status,data7,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data7;
	this.reg_block_h.RGPIO_INTS.read(status,data8,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data8;
	this.reg_block_h.RGPIO_ECLK.read(status,data9,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data9;
	this.reg_block_h.RGPIO_NEC.read(status,data10,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
	rgpio_in = data10;

endtask

task scoreboard::run_phase(uvm_phase phase);
fork
 forever begin
    apb_fifo.get(apb_h); 
    io_fifo.get(io_h); 
    aux_fifo.get(aux_h); 
  //`uvm_info("APB_IO_XTN", $sformatf("printing from sb \n , %s", io_h.sprint), UVM_LOW)
 end
join
	sample_reg; 
	`uvm_info("RGPIO_OUT_SAMPLED",$sformatf("rgpio_out = %0h",rgpio_out),UVM_LOW)
endtask

function void scoreboard::check_phase(uvm_phase phase);
	`uvm_info("RGPIO_OUT_SAMPLED",$sformatf("rgpio_out = %0h",rgpio_out),UVM_LOW)
	`uvm_info(get_type_name,$sformatf("e_cfg.is_out= %0b",e_cfg.is_out),UVM_LOW)
	if(1)begin
	`uvm_info(get_type_name,"Final Check for gpio as output",UVM_LOW)
		for(int i = 0;i<32;i++)begin
			if(io_h.io_pad[i] == rgpio_out[i])begin
				out_seq_pass++;	
			end
			else begin
				out_seq_error++;
			end
		end	
	end
	if(out_seq_pass > 0)begin
	`uvm_info(get_type_name,"gpio as output is verified",UVM_LOW)
	`uvm_info(get_type_name, $sformatf("out_seq_pass = %0d",out_seq_pass),UVM_LOW)
	end
	else
	`uvm_info(get_type_name,"gpio as output is wrong",UVM_LOW)
	`uvm_info(get_type_name, $sformatf("out_seq_error = %0d",out_seq_error),UVM_LOW)

endfunction
