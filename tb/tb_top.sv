`include "uvm_macros.svh"
import uvm_pkg::*;
`include "../rtl/apbreg.v"
`include "../tb/apb_txn.sv"
`include "../tb/apb_if.sv"
`include "../tb/regmodel.sv"
`include "../tb/apb_adapter.sv"
`include "../tb/apb_driver.sv"
`include "../tb/apb_monitor.sv"
`include "../tb/apb_seqencer.sv"
`include "../tb/apb_agent.sv"
`include "../tb/apb_env.sv"
`include "../tb/apb_sequence.sv"
`include "../tb/apb_test.sv"
`include "../tb/dut_wrapper.sv"


module tb_top;
    logic clk;
    logic rst_n;

    apb_if apb(clk, rst_n);

    apb_register_block dut (
        .PCLK(clk),
        .PRESETn(rst_n),
        .PSEL(apb.PSEL),
        .PENABLE(apb.PENABLE),
        .PWRITE(apb.PWRITE),
        .PADDR(apb.PADDR),
        .PWDATA(apb.PWDATA),
        .PRDATA(apb.PRDATA),
        .PREADY(apb.PREADY),
        .PSLVERR(apb.PSLVERR)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        #50 rst_n = 1;
    end


    initial begin
        uvm_config_db#(virtual apb_if)::set(null, "*", "vif", apb);
        run_test("apb_test");
    end
endmodule

