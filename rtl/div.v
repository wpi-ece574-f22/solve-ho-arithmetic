module div(input  wire [7:0] y,
	   input wire [7:0]  x,
	   output wire [7:0] r,
	   output wire [7:0] q,
	   input wire 	     start,
	   output wire 	     ready,
	   input wire 	     clk,
	   input wire 	     reset);

   reg [2:0] 		      state, statenext;
   reg [7:0] 		      rem, remnext;
   reg [7:0] 		      qot, qotnext;
   reg [7:0] 		      r1, r1next;
   reg [3:0] 		      cnt, cntnext;
   
   localparam s0 = 0, s1 = 1, s2 = 2, s3 = 3;
   localparam s4 = 4, s5 = 5, s6 = 6, s7 = 7;

   assign q = qot;
   assign r = rem;
   assign ready = (state == s0);
   
   always @(posedge clk)
     if (reset)
       begin
	  state <= s0;
	  rem   <= 8'b0;
	  qot   <= 8'b0;
	  r1    <= 8'b0;
	  cnt   <= 4'b0;
       end
     else
       begin
	  state <= statenext;
	  rem   <= remnext;
	  qot   <= qotnext;	  
	  r1    <= r1next;
	  cnt   <= cntnext;
       end
   
   always @(*)
     begin
	
	r1next    = r1;
	remnext   = rem;
	qotnext   = qot;
	cntnext   = cnt;
	statenext = state;
	
	case (state)

	  s0:
	    if (start)
	      begin
		 remnext   = y;
		 qotnext   = 8'b0;
		 cntnext   = 4'd8;
		 statenext = s1;
	      end
	  
	  s1:
	    begin
	       r1next = rem * 2 - x;
	       statenext = s2;
	    end
	  
	  s2:
	    begin
	       remnext   = (r1[7]) ? r1 + x : r1;
	       qotnext   = (r1[7]) ? qot << 1 : (qot << 1) + 1;
	       cntnext   = cnt - 1;
	       statenext = s3;
	    end

	  s3:
	    begin
	       if (cnt > 0)
		 statenext = s1;
	       else
		 statenext = s0;
	    end
	
	endcase	
     end
   
endmodule
