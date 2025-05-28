class virtual_seqs_base extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(virtual_seqs_base)

  env_config e_cfg;
  virtual_sequencer vseqrh;

  apb_sequencer apb_seqrh;
  aux_sequencer aux_seqrh;
  io_sequencer io_seqrh;

  apb_seq_output apb_out_seqh;
  io_seq_output io_out_seqh;

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
    apb_out_seqh.start(apb_seqrh);
    io_out_seqh.start(io_seqrh);
  end
endtask
