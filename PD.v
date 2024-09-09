module PD (
    input clk,
    input reset,
    input enable,
    input wire[3:0] din,
    output reg pattern1,
    output reg pattern2
	);
    
    reg[3:0] state_pattern= 4'b0000;  //starting at idle
    parameter Idle=4'b0000, s0=4'b0001, s05=4'b0011, s053=4'b0010, s0531=4'b0110,
    						  s06=4'b0111, s061 = 4'b1111, s0619 = 4'b1110;
    
    always@(*)
        begin
            case(state_pattern)
                s0531:
                    begin
                        pattern1 <= 1;
                    end
                s0619:
                    begin 
                        pattern2 <= 1;
                    end
                default:
                    begin
                        pattern1 <= 0;
                        pattern2 <= 0;
                    end
            endcase
        end
    
    always @(posedge clk or posedge reset) 
        begin
            if(reset) begin
                state_pattern<=Idle;
            end
            else begin
                if(enable) begin
                    case(state_pattern)
                        Idle:
                            if(din == 4'b0000)
                           		state_pattern <= s0;
                        	else
                            	state_pattern <= Idle;
                        s0:
                            if(din == 4'b0101)
                                state_pattern <= s05;
                            else if(din == 4'b0110)
                                state_pattern <= s06;
                        	else if(din == 4'b0000)
                                state_pattern <= s0;
                            else
                                state_pattern <= Idle;
                        s05:
                            if(din == 4'b0011)
                                state_pattern <= s053;
                        	else if(din == 4'b0000)
                                state_pattern <= s0;
                            else
                                state_pattern <= Idle;
                        s053:
                            if(din == 4'b0001) 
                                state_pattern <= s0531;
                        	else if(din == 4'b0000)
                                state_pattern <= s0;
                            else
                                state_pattern <= Idle;
                        s0531:					//maybe issue here!!!!!!!!!!!!!
                            if(din == 4'b0000)
                                state_pattern <= s0;
                            else
                               state_pattern <= Idle; 
                        s06:
                            if(din == 4'b0001)
                                state_pattern <= s061;
                        	else if(din == 4'b0000)
                                state_pattern <= s0;
                        	else
                                state_pattern <= Idle;
                        s061:
                            if(din == 4'b1001)
                                state_pattern <= s0619;
                        	else if(din == 4'b0000)
                                state_pattern <= s0;
                            else
                                state_pattern <= Idle;
                        s0619:					//maybe issue here!!!!!!!!!!!!!
                            if(din == 4'b0000)
                                state_pattern <= s0;
                            else
                               state_pattern <= Idle;
                    endcase
             	end
            end
        end
	
endmodule
