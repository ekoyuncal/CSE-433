
module gcd_control(
	input CLK,
	input reset,
	input go_i,
	input x_gt_y,
	input x_lt_y,
	output reg ld_x,
	output reg ld_y,
	output reg ld_obeb,
	output reg sel_x,
	output reg sel_y,
	output reg sel_sub
);

reg [1:0] state;
reg [1:0] next_state;


localparam 	IDLE 	= 2'b00,
				WHILE = 2'b01,
				XGTY	= 2'b10,
				XLTY	= 2'b11;


//State Registers
always@(posedge CLK)
	begin
	if(reset)
		state <= IDLE;
	else
		state <= next_state;
	
	end


//Combinational Circuit for Next State
always@(*)
	begin
	
	case(state)
		IDLE:	
				begin
				if(go_i)
					next_state = WHILE;
				else
					next_state = IDLE;				
				end
		
		WHILE:
				begin
				if(x_gt_y)
					next_state = XGTY;
				else if(x_lt_y)
					next_state = XLTY;
				else
					next_state = IDLE;
				end
		XGTY:
				begin
				next_state = WHILE;
				end
		XLTY:
				begin
				next_state = WHILE;
				end
	
	endcase
	
	end
	


//Combinational Circuit for Outputs
always@(*)
	begin
	ld_x 		= 1'b0;
	ld_y 		= 1'b0;
	ld_obeb 	= 1'b0;
	sel_x 	= 1'b0;
	sel_y 	= 1'b0;
	sel_sub 	= 1'b0;
	case(state)
		IDLE:	
				begin
				ld_x 		= 1'b1;
				ld_y 		= 1'b1;
				end
		
		WHILE:
				begin
				ld_obeb 	= 1'b1;
				end
		XGTY:
				begin
				sel_x 	= 1'b1;
				ld_x 		= 1'b1;
				end
		XLTY:
				begin
				sel_sub 	= 1'b1;
				sel_y 	= 1'b1;
				ld_y		= 1'b1;				
				end
	
	endcase
	end
	


endmodule


