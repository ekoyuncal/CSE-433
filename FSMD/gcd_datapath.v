module gcd_datapath(
	input CLK,
	input [31:0] xi,
	input [31:0] yi,
	input sel_x,
	input sel_y,
	input sel_sub,
	input ld_x,
	input ld_y,
	input ld_obeb,
	input reset,
	output x_gt_y,
	output x_lt_y,
	output [31:0] gcd_res	
);

//Declare Registers
reg [31:0] x; 
reg [31:0] y;
reg [31:0] obeb;

//Declare wires
wire [31:0] w_x;
wire [31:0] w_y;
wire [31:0] w_obeb;
wire [31:0] w_subR;
wire [31:0] w_subA;
wire [31:0] w_subB;


//Define Registers
always@(posedge CLK)
	begin
	if(reset)
		begin
		x 		<= 32'd0;
		y 		<= 32'd0;
		obeb 	<= 32'd0;
		end
	else
		begin
		if(ld_x)
			x 		<= w_x;
		if(ld_y)
			y 		<= w_y;
		if(ld_obeb)
			obeb 	<= w_obeb;
		end
	end

//MUXes Dataflow Model
assign w_x 			= sel_x ? w_subR : xi;
assign w_y 			= sel_y ? w_subR : yi;
assign w_subA 		= sel_sub ? y : x;
assign w_subB 		= sel_sub ? x : y;
assign w_obeb 		= x;
assign gcd_res 	= obeb;
assign w_subR		= w_subA - w_subB;
assign x_lt_y		= (x < y);
assign x_gt_y		= (x > y);
	

endmodule



//Behavioral Model
/*always@(*)
	begin
	
	if(sel_sub)
		begin
		w_subA = y;
		w_subB = x;
		end		
	else
		begin
		w_subA = x;
		w_subB = y;
		end
		
	w_subR = w_subA - w_subB;	
	
	if(sel_x)
		w_x = w_subR;
	else
		w_x = xi;
	
	if(sel_y)
		w_y = w_subR;
	else
		w_y = yi;		
	
	
	w_obeb = x;
	end*/
	
	
