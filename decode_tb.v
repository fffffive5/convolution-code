`timescale 1ns/1ps
module decode_tb();

	reg clk;
	reg rst_n;
	reg [1:0]data_in;
	wire data_out;


	decode	decode_1(
	.clk			(clk),
	.rst_n		(rst_n),
	.data_in		(data_in),
	.data_out	(data_out)	
	);
	
	initial clk=0;
	always #10 clk=~clk;
	
	initial
	begin
		rst_n=0;
		data_in=00;
		#201;
		rst_n=1;
		#200;
		data_in=2'b11;
		#20
		data_in=2'b10;
		#20
		data_in=2'b01;
		#20
		data_in=2'b10;
		#20
		data_in=2'b11;
		#20
		data_in=2'b00;
		#20
		data_in=2'b00;
		#20
		data_in=2'b00;
	end
	
	
endmodule