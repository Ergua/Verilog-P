`include "config.v"

module ForwardUnit (
	input	CLK,
	//input	RESET,
	/* The bits of the instruction*/
    //input [31:0] Instruction,
    input [4:0] ID_EX_RT,
    input [4:0] ID_EX_RS,
    input [4:0] EX_MEM_RD,
    input [4:0] MEM_WB_RD,
    //output of forward 
    output reg [1:0] forwardA,
    output reg [1:0] forwardB,

    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite
	);

    localparam NO_HAZARD   = 2'b00;
    localparam EX_HAZARD   = 2'b10;
    localparam MEM_HAZARD  = 2'b01;

    always @(posedge CLK) begin
            if ((|EX_MEM_RD & EX_MEM_RegWrite) & (EX_MEM_RD == ID_EX_RS)) begin
                forwardA <= EX_HAZARD;
            end else if ((|MEM_WB_RD & MEM_WB_RegWrite) & (MEM_WB_RD == ID_EX_RS)) begin
                forwardA <= MEM_HAZARD;
            end else begin
                forwardA <= NO_HAZARD;
            end

            if ((|EX_MEM_RD & EX_MEM_RegWrite) & (EX_MEM_RD == ID_EX_RT)) begin
                forwardB <= EX_HAZARD;
            end else if ((|MEM_WB_RD & MEM_WB_RegWrite) & (MEM_WB_RD == ID_EX_RT)) begin
                forwardB <= MEM_HAZARD;
            end else begin
                forwardB <= NO_HAZARD;
            end

    end
endmodule
