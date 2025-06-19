`ifndef APB_DRIVER_SV
`define APB_DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_driver extends uvm_driver #(apb_txn);
    virtual apb_if vif;

    `uvm_component_utils(apb_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            apb_txn txn;
            seq_item_port.get_next_item(txn);

            vif.PSEL <= 1;
            vif.PADDR <= txn.addr;
            vif.PWRITE <= txn.write;
            vif.PWDATA <= txn.data;

            vif.PENABLE <= 0;
            @(posedge vif.PCLK);
            $display("after drive");
            vif.PENABLE <= 1;
            @(posedge vif.PCLK);

            if (!txn.write) begin
                txn.rdata = vif.PRDATA;
            end

            vif.PSEL <= 0;
            vif.PENABLE <= 0;

            seq_item_port.item_done(txn);
        end
    endtask
endclass

`endif

