module divtb();
   reg 	      clk, reset, start;
   reg  [7:0] x, y;
   wire [7:0] r, q;
   wire       ready;

   
   div dut(.y(y), .x(x), .r(r), .q(q), .start(start), .ready(ready), .clk(clk), .reset(reset));

   always
     begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
     end
   
   initial
     begin
	
	$dumpfile("trace.vcd");
	$dumpvars(0, divtb);

	reset = 1'b1;
	repeat (3) @(posedge clk);
	
	y     = 8'd23;
	x     = 8'd45;
	reset   = 1'b0;
	start = 1'b1;
	@(posedge clk);

	start = 1'b0;
	
	repeat (50) 
	  begin
	     $display("q %d r %d rdy %d", q, r, ready);
	     @(posedge clk);
	  end
	
	y     = 8'd2;
	x     = 8'd7;
	start = 1'b1;
	@(posedge clk);

	start = 1'b0;
	
	repeat (50) 
	  begin
	     $display("q %d r %d rdy %d", q, r, ready);
	     @(posedge clk);
	  end
	
	$finish;
     end
   
endmodule
