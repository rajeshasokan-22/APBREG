`ifndef APB_IF_SV
`define APB_IF_SV

interface apb_if (
    input logic PCLK,
    input logic PRESETn
);
    logic PSEL;
    logic PENABLE;
    logic PWRITE;
    logic [7:0] PADDR;
    logic [15:0] PWDATA;
    logic [15:0] PRDATA;
    logic PREADY;
    logic PSLVERR;
endinterface

`endif

