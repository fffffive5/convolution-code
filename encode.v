module encode(
		clk,
		clk_code,
		Q,
		code
		);	
		input clk;
		input clk_code;
		input Q;
		output reg code;
		
		reg count=1'b0;
		reg d1,d2;
		wire c1,c2;
		
		always@(posedge clk)
		begin
			d2<=d1;
			d1<=Q;
		end
		
		
		assign c1=Q^d2;
		assign c2=Q^d1^d2;
		
		always @(posedge clk_code)
		begin
			count<=count+1'b1;
		end
		
		always @(negedge clk_code)
		if (count==1'b1)
			code<=c1;
		else 
			code<=c2;
		
		
		
		
endmodule