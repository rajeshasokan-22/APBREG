`ifndef APB_SEQUENCE_SV
`define APB_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_simple_seq extends uvm_sequence #(apb_txn);
    `uvm_object_utils(apb_simple_seq)

    function new(string name = "apb_simple_seq");
        super.new(name);
    endfunction

    task body();
           // apb_txn txn;

           // txn = apb_txn::type_id::create("txn");
           // txn.write = 1;
           // txn.addr = 8'h0C;
           // txn.data = 16'haa55;
           // $display("before");
           // start_item(txn);
           // $display("start");
           // finish_item(txn);
           
    endtask
endclass

`endif
