`timescale 1ns/1ps
module Conv_code_tb();
	
	reg clk;
	reg rst_n;
	wire data_out;
	wire Q;

	Conv_code _Conv_code1(
	.clk		(clk),
	.rst_n	(rst_n),
	.Q			(Q),
	.data_out(data_out)
	);
	
	
	initial clk=0;
	always #10 clk=~clk;
	initial
	begin
		rst_n=0;
		#2001;
		rst_n=1;
	end
	
endmodule