//Prajwal D Nayak.
module sync_fifo(
 clk,
 rstn,
 pop,
 push,
 empty,
 full,
 din,
 dout
    );

parameter PTR_WIDTH = 3;
parameter DATA_WIDTH = 8;
parameter DEPTH = 8;

input clk;
input rstn;
input pop;
input push;
 input [DATA_WIDTH-1:0]din;    //writing to the memory we need din.

 output [DATA_WIDTH-1:0]dout;    //To read from the memory we need dout.
output empty;
output full;
// all are reg data type as they are defined inside always block.
 reg [DATA_WIDTH-1:0]fifo[DEPTH-1:0];     //Creating the memory(RAM) to store the data.
reg [PTR_WIDTH-1:0]rdptr, next_rdptr;
 reg [PTR_WIDTH-1:0]wrptr, next_wrptr;    // Declaring read pointer and the write pointers.
reg [DATA_WIDTH-1:0]dout, next_dout;
reg empty, next_empty;
reg full, next_full;

 assign fullchk = push && !(|(wrptr^(rdptr-1'b1)));  //'fullchk' to check if the last operation was write and the FIFO became full
assign emptychk = pop && !(|(rdptr^(wrptr-1'b1)));

always @ (posedge clk) //Sequential block
begin
  if(!rstn)
  begin
    dout    <= 8'd0;
    empty   <= 1'b1;
    full    <= 1'b0;
    rdptr   <= 1'b0;
    wrptr   <= 1'b0;
  end
  else
  begin
    dout    <= next_dout;
    empty   <= next_empty;
    full    <= next_full; 
    rdptr   <= next_rdptr;
    wrptr   <= next_wrptr;
  end
end

always @ (*) //Combinational Block
begin
  next_dout    = dout;
  next_empty   = emptychk ? 1'b1 : push ? 1'b0 : empty;
  next_full    = fullchk ? 1'b1 : pop ? 1'b0 : full;
  next_rdptr   = rdptr;
  next_wrptr   = wrptr;
 
  if(push)  //write
  begin
   fifo[wrptr] = din;   // In write data is written into memory 
  next_wrptr  = wrptr+1;  // after writing data into memory the write pointer gets incremented.
  end
 else if(pop)  //read 
  begin
   next_dout    = fifo[rdptr];    // data is read from the memory using read pointer
  next_rdptr   = rdptr+1;    // after data is read from memory the pointer also gets incremented
  end
  else
  begin
  next_dout  = dout;    // bY DEFAULT no change it must remain same, this is given in else condition.
  next_rdptr = rdptr;
  next_wrptr = wrptr;
  end 
end
endmodule
