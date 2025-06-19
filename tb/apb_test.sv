`ifndef APB_TEST_SV
`define APB_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_test extends uvm_test;
    apb_env env;
    uvm_status_e status;
    bit [15:0] rdata;

    `uvm_component_utils(apb_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        env = apb_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        apb_simple_seq seq;
        phase.raise_objection(this);
        wait(tb_top.rst_n == 1);
        #10us; 
        $display("Before write method");
        env.regmodel.config_m.write(status,16'h0707);
        //env.regmodel.config_m.poke(status,16'h0202);
        #10us;
        env.regmodel.config_m.read(status,rdata);
    
        `uvm_info("debug",$sformatf("mirror_value = %h, read value = %h",env.regmodel.config_m.get_mirrored_value(), rdata),12);
        $display("After write method");
       // seq = apb_simple_seq::type_id::create("seq");
       // seq.start(env.agent.seqr);
        #100us;

        phase.drop_objection(this);
    endtask
endclass

`endif

