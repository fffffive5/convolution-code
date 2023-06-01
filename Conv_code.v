module Conv_code(
	clk,
	Q,
	encode,
	encode_noise,
	data_out,
	);
	input clk;		//20MHZ
	wire rst_n;
	output encode;
	output encode_noise;
	output Q;
	output data_out;

	wire code;		//after noise
	wire code_pre;	//before noise 
	
	reg noise;
	reg [10:0] 	count_5K;
	reg [9:0] 	count_10K;
	reg [3:0]  	count_noise;
	reg 			clk_5K=1'b0;
	reg 			clk_10K=1'b1;
	reg [1:0] 	data_buffer;
	reg [1:0]	data_dein;
	
	
	assign rst_n=1'b1;
	assign encode=code_pre;
	assign encode_noise=code;
	assign code=code_pre+noise; 	//add noise 
	
	always @(posedge clk or negedge rst_n)
		if (rst_n==1'b0)
			count_5K<=11'b0;
		else if (count_5K>=11'd1999)
			count_5K<=11'b0;
		else
			count_5K<=count_5K+1'b1;
	
	always @(posedge clk or negedge rst_n)
		if (rst_n==1'b0)
			count_10K<=10'b0;
		else if (count_10K>=10'd999)
			count_10K<=10'b0;
		else
			count_10K<=count_10K+1'b1;
			
			
	always @(posedge clk or negedge rst_n) 
		if (rst_n==1'b0)
			clk_5K<=1'b0;
		else if (count_5K==11'd1999)
			clk_5K<=~clk_5K;
		
	always @(posedge clk or negedge rst_n) 
		if (rst_n==1'b0)
			clk_10K<=1'b0;
		else if (count_10K==11'd999)
			clk_10K<=~clk_10K;
			
	
	always @(posedge clk_10K or negedge rst_n) 
		if (rst_n==1'b0)
			count_noise<=4'b0;
		else if (count_noise>=4'd10)
			count_noise<=4'b0;
		else
			count_noise<=count_noise+1'b1;
	
	always @(*)
	begin
		if (count_noise==4'd10)
			noise<=1'b1;
		else 
			noise<=1'b0;
	end
	
	encode encode_1(
		.clk			(clk_5K),			//clk=5KHZ
		.clk_code	(clk_10K),		//clk_code=10KHZ
		.Q				(Q),
		.code			(code_pre)
		);	
		
		

	
	m_sequence m_seq1
		(	.clk	(clk_5K),
			.rst_n(rst_n),
			.m_seq(Q)
		);
	
	
	always @(posedge clk_10K or negedge rst_n)
		if (rst_n==1'b0)
			data_buffer<=2'b0;
		else 
			data_buffer<={data_buffer[0],code};
	
	always @(negedge clk_5K or negedge rst_n)
		if (rst_n==1'b0)
			data_dein<=2'b0;
		else 
			data_dein<=data_buffer;
			
			
	decode	decode_1(
	.clk			(clk_5K),				//5KHZ
	.rst_n		(rst_n),
	.data_in		(data_dein),
	.data_out	(data_out)	
	);
	
	
	
endmodule