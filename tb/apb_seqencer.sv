`ifndef APB_SEQUENCER_SV
`define APB_SEQUENCER_SV
`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_seqr extends uvm_sequencer#(apb_txn);
    `uvm_component_utils(apb_seqr)
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

 endclass

 
`endif
