
module decode(
	clk		,
	rst_n		,
	data_in	,
	data_out	
	
	);
	
	input clk;
	input rst_n;
	input [1:0] data_in;	//c1,c2
	output reg data_out;
	
	
	wire [1:0] dis_00,dis_01,dis_10,dis_11;
	wire [31:0] add_1,add_2,add_3,add_4,add_5,add_6,add_7,add_8;
	reg [9:0]	path_s0,path_s1,path_s2,path_s3;  //0 is first 9 is output
	reg [31:0]	dis_s0,dis_s1,dis_s2,dis_s3;
	reg [19:0]count_clear;
	assign dis_00=data_in[1]+data_in[0];
	assign dis_01=data_in[1]+(data_in[0]^1'b1);
	assign dis_10=(data_in[1]^1'b1)+data_in[0];
	assign dis_11=(data_in[1]^1'b1)+(data_in^1'b1);
	
	
	always @(posedge clk or negedge rst_n)
		if (rst_n==1'b0)
			count_clear<=20'b0;
		else if (count_clear>=20'd50000)
			count_clear<=20'b0;
		else
			count_clear<=count_clear+1'b1;
	
	
	//s0
	assign add_1=dis_00+dis_s0;
	assign add_2=dis_11+dis_s2;
	
	always @(posedge clk or negedge rst_n)
	begin
		if (rst_n==1'b0) 
			begin
				path_s0=10'b0;
				dis_s0=32'b0;
			end
		else if (count_clear==20'd50000)
			begin
				path_s0=10'b0;
				dis_s0=32'b0;
			end
		else if (add_1<=add_2)
			begin
				path_s0<={path_s0[8:0],1'b0};
				dis_s0<=add_1;
			end
		else 
			begin
				path_s0<={path_s2[8:0],1'b0};
				dis_s0<=add_2;
			end
	end
	
	//s1
	assign add_3=dis_11+dis_s0;
	assign add_4=dis_00+dis_s2;
	
	always @(posedge clk or negedge rst_n)
	begin
		if (rst_n==1'b0) 
			begin
				path_s1=10'b0;
				dis_s1=32'b0;
			end
		else if (count_clear==20'd50000)
			begin
				path_s1=10'b0;
				dis_s1=32'b0;
			end
		else if (add_3<=add_4)
			begin
				path_s1<={path_s0[8:0],1'b1};
				dis_s1<=add_3;
			end
		else 
			begin
				path_s1<={path_s2[8:0],1'b1};
				dis_s1<=add_4;
			end
	end
	
		//s2
	assign add_5=dis_01+dis_s1;
	assign add_6=dis_10+dis_s3;
	
	always @(posedge clk or negedge rst_n)
	begin
		if (rst_n==1'b0)
			begin
				path_s2=10'b0;
				dis_s2=32'b0;
			end
		else if (count_clear==20'd50000)
			begin
				path_s2=10'b0;
				dis_s2=32'b0;
			end
		else if (add_5<=add_6)
			begin
				path_s2<={path_s1[8:0],1'b0};
				dis_s2<=add_5;
			end
		else 
			begin
				path_s2<={path_s3[8:0],1'b0};
				dis_s2<=add_6;
			end
	end
	
		//s3
	assign add_7=dis_10+dis_s1;
	assign add_8=dis_01+dis_s3;
	
	always @(posedge clk or negedge rst_n)
	begin
		if (rst_n==1'b0)
			begin
				path_s3=10'b0;
				dis_s3=32'b0;
			end
		else if (count_clear==20'd50000)
			begin
				path_s3=10'b0;
				dis_s3=32'b0;
			end
		else if (add_7<add_8)
			begin
				path_s3<={path_s1[8:0],1'b1};
				dis_s3<=add_7;
			end
		else 
			begin
				path_s3<={path_s3[8:0],1'b1};
				dis_s3<=add_8;
			end
	end
	
	//output
	always @(*)
	begin
		if ((dis_s0<=dis_s1)&&(dis_s0<=dis_s2)&&(dis_s0<=dis_s3))
			data_out<=path_s0[9];
		else if ((dis_s1<=dis_s0)&&(dis_s1<=dis_s2)&&(dis_s1<=dis_s3))
			data_out<=path_s1[9];
		else if ((dis_s2<=dis_s0)&&(dis_s2<=dis_s1)&&(dis_s2<=dis_s3))
			data_out<=path_s2[9];
		else  data_out<=path_s3[9];
	end
endmodule
	
	
	
	