`ifndef APB_MONITOR_SV
`define APB_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_monitor extends uvm_monitor;
    virtual apb_if vif;
    uvm_analysis_port #(apb_txn) mon_ap;

    apb_txn txn;
    `uvm_component_utils(apb_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_ap = new("mon_ap", this);
    endfunction

    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif);
    endfunction

    task run_phase(uvm_phase phase);
       // forever begin
       //    // wait (vif.PSEL && vif.PENABLE);
       //    // txn = apb_txn::type_id::create("txn");

       //    // txn.addr = vif.PADDR;
       //    // txn.write = vif.PWRITE;
       //    // txn.data = vif.PWDATA;
       //    // txn.rdata = vif.PRDATA;

       //    // mon_ap.write(txn);
       //    // @(posedge vif.PCLK);
       // end
    endtask
endclass

`endif

