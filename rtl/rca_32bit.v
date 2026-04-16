`timescale 1ns / 1ps

module rca_32bit (
    input  wire        clk,
    input  wire        reset,
    
    // --- DFT Ports ---
    input  wire        scan_en,
    input  wire        scan_in,
    input  wire        test_mode,
    output wire        scan_out,
    // -----------------

    input  wire [31:0] a_in,
    input  wire [31:0] b_in,
    input  wire        cin_in,
    output reg  [31:0] sum_out,
    output reg         cout_out
);

    // Internal registers to hold inputs
    reg  [31:0] a_reg, b_reg;
    reg         cin_reg;
    
    // Wires to capture combinational output from the RCA
    wire [31:0] sum_w;
    wire        cout_w;

    // Internal carry chain
    wire [32:0] carry;
    assign carry[0] = cin_reg;
    assign cout_w   = carry[32];

    // Instantiate 32 Full Adders
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : FA_LOOP
            full_adder fa_inst (
                .a    (a_reg[i]),
                .b    (b_reg[i]),
                .cin  (carry[i]),
                .sum  (sum_w[i]),
                .cout (carry[i+1])
            );
        end
    endgenerate

    // Sequential Logic: Clocking data in and out
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_reg    <= 32'd0;
            b_reg    <= 32'd0;
            cin_reg  <= 1'b0;
            sum_out  <= 32'd0;
            cout_out <= 1'b0;
        end else begin
            a_reg    <= a_in;
            b_reg    <= b_in;
            cin_reg  <= cin_in;
            sum_out  <= sum_w;
            cout_out <= cout_w;
        end
    end

    // Tie off scan_out for RTL simulation; Genus overrides this during DFT
    assign scan_out = 1'b0;

endmodule

