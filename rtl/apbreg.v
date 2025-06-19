module apb_register_block (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire        PSEL,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [7:0]  PADDR,
    input  wire [15:0] PWDATA,
    output reg  [15:0] PRDATA,
    output wire        PREADY,
    output wire        PSLVERR
);

    // Always ready, no error
    assign PREADY  = 1'b1;
    assign PSLVERR = 1'b0;

    // Internal 16-bit registers
    reg [15:0] ctrl_reg;      // RW
    reg [15:0] status_reg;    // RO (constant)
    reg [7:0]  cmd_reg;       // WO (8-bit)
    reg [15:0] config_reg;    // RW

    // Address Map (32-bit aligned, byte addressed)
    localparam ADDR_CTRL   = 8'h00;
    localparam ADDR_STATUS = 8'h04;
    localparam ADDR_CMD    = 8'h08;
    localparam ADDR_CONFIG = 8'h0C;

    // Reset logic
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            ctrl_reg   <= 16'h0000;
            config_reg <= 16'h00A5;
            cmd_reg    <= 8'h00;
        end else if (PSEL && PENABLE && PWRITE) begin
            case (PADDR)
                ADDR_CTRL:   ctrl_reg   <= PWDATA;
                ADDR_CMD:    cmd_reg    <= PWDATA[7:0];  // 8-bit write-only
                ADDR_CONFIG: config_reg <= PWDATA;
                default: ; // Do nothing
            endcase
        end
    end

    // Read logic
    always @(*) begin
        PRDATA = 16'h0000;
        if (PSEL && !PWRITE) begin
            case (PADDR)
                ADDR_CTRL:   PRDATA = ctrl_reg;
                ADDR_STATUS: PRDATA = 16'b0000_0000_0000_0010; // {error, ready}
                ADDR_CONFIG: PRDATA = config_reg;
                default:     PRDATA = 16'hDEAD;
            endcase
        end
    end

endmodule


