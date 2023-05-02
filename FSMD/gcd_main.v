
module gcd_main(
	input CLK,
	input go_i,
	input reset,
	input [31:0] xi,
	input [31:0] yi,
	output [31:0] obebo
);

wire x_gt_y;
wire x_lt_y;
wire ld_x;
wire ld_y;
wire ld_obeb;
wire sel_x;
wire sel_y;
wire sel_sub;


gcd_control cont0(
	.CLK(CLK),
	.reset(reset),
	.go_i(go_i),
	.x_gt_y(x_gt_y), 
	.x_lt_y(x_lt_y),
	.ld_x(ld_x),
	.ld_y(ld_y),
	.ld_obeb(ld_obeb),
	.sel_x(sel_x),
	.sel_y(sel_y),
	.sel_sub(sel_sub)	
);



gcd_datapath datapath0(
	.CLK(CLK),
	.xi(xi),
	.yi(yi),
	.sel_x(sel_x),
	.sel_y(sel_y),
	.sel_sub(sel_sub),
	.ld_x(ld_x),
	.ld_y(ld_y),
	.ld_obeb(ld_obeb),
	.reset(reset),
	.x_gt_y(x_gt_y),
	.x_lt_y(x_lt_y),
	.gcd_res(obebo)	
);




endmodule
