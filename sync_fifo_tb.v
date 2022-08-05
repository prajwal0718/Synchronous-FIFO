`timescale 1ns / 1ps

module sync_tb;
reg [7:0] data_in;
reg clk , rst , rd_en , wr_en;
wire empty , full;
wire [3:0]fifo_count;
wire [7:0] data_out;

 //Module Instatiation
 sync_fifo DUT(data_in ,clk , rst , rd_en, wr_en, empty , full , fifo_count , data_out);

 always #5 clk = ~clk;
  
  task reset();
  begin
  clk = 1'b1;
  rst = 1'b1;
  rd_en = 1'b0;
  wr_en = 1'b0;
  data_in = 8'd0;
  #30; rst = 1'b0;
  end
  endtask
 
  task read_fifo();
  begin
  rd_en = 1'b1;
  #10;
  rd_en = 1'b0;
  end
  endtask
    
  task write_fifo([7:0]din_tb);
  begin
  wr_en = 1'b1;
  data_in = din_tb;
  #10 wr_en = 1'b0;
  end
  endtask
  
  // Main code
  initial
  begin
  reset();
  #10;
  repeat(2)
  begin
  write_fifo(8'h11);
  #10;
  write_fifo(8'h22);
  #10;
  write_fifo(8'h33);
  #10;
  write_fifo(8'h44);
  #10;
  end
  #10;
  repeat(2)
  begin
  read_fifo();
  #10;
  end
  #10;
  $finish;
  end
       


endmodule


