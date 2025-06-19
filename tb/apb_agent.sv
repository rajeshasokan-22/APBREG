`ifndef APB_AGENT_SV
`define APB_AGENT_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_agent extends uvm_agent;
    apb_driver    drv;
    apb_monitor   mon;
    apb_seqr seqr;

    `uvm_component_utils(apb_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = apb_driver::type_id::create("drv", this);
        mon = apb_monitor::type_id::create("mon", this);
        seqr = apb_seqr::type_id::create("seqr", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass

`endif

