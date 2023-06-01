`timescale 1ns/1ps
module encode_tb();

	reg clk,clk_code;
	wire Q;
	reg rst_n;
	wire code;


encode encode_1(
		.clk			(clk),
		.clk_code	(clk_code),
		.Q				(Q),
		.code			(code)
		);	
		
		
M_series M_series_1
    (
            .clk		(clk),
            .rst_n	(rst_n),
            .Q			(Q)
    );
		
	initial
		begin
			clk=0;
			clk_code=0;
		end
		
	always #10 clk_code=~clk_code;
	
	always @(posedge clk_code)
		clk<=~clk;
	
	initial
	begin
		rst_n=0;
		#201;
		rst_n=1;
	end
	//1 0 0  output 	1 1
	//0 1 0  			0 1
	//0 0 1 				1 1
	
endmodule