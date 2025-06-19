`ifndef APB_TXN_SV
`define APB_TXN_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_txn extends uvm_sequence_item;
    rand bit        write;
    rand bit [7:0]  addr;
    rand bit [31:0] data;
    bit [31:0]      rdata;

    `uvm_object_utils(apb_txn)
    function new(string name = "apb_txn");
        super.new(name);
    endfunction
endclass

`endif

