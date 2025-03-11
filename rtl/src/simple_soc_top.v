module simple_soc_top (input clk,input tt,output ss);
reg ss;
always@(posedge clk) ss<=tt;
endmodule
