class virtual_seqs_base extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(virtual_seqs_base)

  env_config e_cfg;
  virtual_sequencer vseqrh;

  apb_sequencer apb_seqrh;
  aux_sequencer aux_seqrh;
  io_sequencer io_seqrh;

  apb_seq_output apb_out_seqh;
  io_seq_output io_out_seqh;

  apb_seq_output_aux apb_out_aux_seqh;
  //io_seq_output io_out_seqh; //NOTE: resused the previous io handle
  aux_seq_output aux_out_seqh; 

  apb_seq_input_int1 apb_in_int1_seqh;
  io_seq_input_int1 io_in_int1_seqh;
  apb_read apb_readh;

  extern function new(string name = "virtual_seqs_base");
  extern task body;
endclass

function virtual_seqs_base::new(string name = "virtual_seqs_base");
  super.new(name);
endfunction

task virtual_seqs_base::body;
  if (!uvm_config_db#(env_config)::get(null, get_full_name(), "env_config", e_cfg))
    `uvm_fatal(get_type_name, "failed to get e_cfg in v_seqs")

  assert ($cast(vseqrh, m_sequencer))
  else `uvm_error(get_type_name, "error while asserting m_seqr")

  apb_seqrh = vseqrh.apb_seqrh;
  io_seqrh  = vseqrh.io_seqrh;
  aux_seqrh = vseqrh.aux_seqrh;
endtask

class gpio_output_vseq extends virtual_seqs_base;
  `uvm_object_utils(gpio_output_vseq)
  extern function new(string name = "gpio_output_vseq");
  extern task body;
endclass

function gpio_output_vseq::new(string name = "gpio_output_vseq");
  super.new(name);
endfunction

task gpio_output_vseq::body;
  super.body;
  `uvm_info(get_type_name, "In the body of gpio_as_output", UVM_LOW)
  apb_out_seqh = apb_seq_output::type_id::create("apb_out_seqh");
  io_out_seqh  = io_seq_output::type_id::create("io_out_seqh");
  begin
    //NOTE: dont start io_seq first, before starting any seq
    //TODO: Find the reason why is it happening
    io_out_seqh.start(io_seqrh);
    apb_out_seqh.start(apb_seqrh);
  end
endtask

class gpio_output_aux_vseq extends virtual_seqs_base;
	`uvm_object_utils(gpio_output_aux_vseq)
 	extern function new(string name = "gpio_output_aux_vseq");
	extern task body;
endclass

function gpio_output_aux_vseq::new(string name = "gpio_output_aux_vseq");
	super.new(name);
endfunction

task gpio_output_aux_vseq::body;
	super.body;
	apb_out_aux_seqh = apb_seq_output_aux::type_id::create("apb_out_aux_seqh");
        io_out_seqh  = io_seq_output::type_id::create("io_out_seqh");
	aux_out_seqh = aux_seq_output::type_id::create("aux_out_seqh");
	begin
		io_out_seqh.start(io_seqrh);
		aux_out_seqh.start(aux_seqrh);
		apb_out_aux_seqh.start(apb_seqrh);
	end
endtask

class gpio_input_int1_vseq extends virtual_seqs_base;
	`uvm_object_utils(gpio_input_int1_vseq)
 	extern function new(string name = "gpio_input_int1_vseq");
	extern task body;
endclass

function gpio_input_int1_vseq::new(string name = "gpio_input_int1_vseq");
	super.new(name);
endfunction

task gpio_input_int1_vseq::body;
	super.body;
        	io_out_seqh  = io_seq_output::type_id::create("io_out_seqh");
   		apb_in_int1_seqh = apb_seq_input_int1::type_id::create("apb_in_int1_seqh");	
		io_in_int1_seqh = io_seq_input_int1::type_id::create("io_in_int1_seqh");
		apb_readh = apb_read::type_id::create("apb_readh");
	begin
		io_out_seqh.start(io_seqrh);
		apb_in_int1_seqh.start(apb_seqrh);
		io_in_int1_seqh.start(io_seqrh);
		apb_readh.start(apb_seqrh);
	end
endtask
