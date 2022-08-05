//Prajwal D Nayak.
`timescale 1ns / 1ps

module sync_fifo(data_in ,clk , rst , rd_en, wr_en, empty , full , fifo_count , data_out);
input[7:0] data_in;
input clk , rst , rd_en , wr_en;
output empty , full;
output reg [3:0]fifo_count;
output reg [7:0] data_out;

//input [WIDTH-1:0].
// Fifo_count has one additional bit actually $clog2(DEPTH) = 3 but here we need one extra bit for reperesenting the Wrap bit for FULL condition
reg [7:0] fifo_ram[0:7];  // creation of Memory
reg [2:0] rd_ptr , wr_ptr; // Pounters width of 3 bit.

//Creating empty and Full condition
assign empty = (fifo_count == 0);
assign full = (fifo_count == 8); //To represent 8 we need 4 bit so count taken as 4 bit 

//Write and Read Blocks
always@(posedge clk) begin:write
    if(wr_en && !full)
        fifo_ram[wr_ptr] <= data_in;  // if wr_en HIGH and Buffer not full we can write data in buffer
   else if(wr_en && rd_en)
        fifo_ram[wr_ptr] <=data_in;    //If both read and write enable are HIGH also we can write data  
end
 
always@(posedge clk) begin:read
    if(rd_en && !empty)
        data_out <= fifo_ram[rd_ptr];  // if wr_en HIGH and Buffer not full we can write data in buffer
   else if(wr_en && rd_en)
        data_out <= fifo_ram[rd_ptr];   //If both read and write enable are HIGH also we can write data  
end
 
 
 // Pointer Block 
 //After writing to each location it must also got to nect location by incrementing the pointer
 
 always@(posedge clk) begin:pointer
    if(rst) 
       begin
        wr_ptr <=0;
        rd_ptr<=0;
       end
    else
    begin
       wr_ptr<= ((wr_en &&!full)||(wr_en && rd_en))? wr_ptr+1 : wr_ptr;  //use conditional operator
       //write enable and not full or both enable then increment the write pointer else remain in same position
       
       rd_ptr<= ((rd_en &&!empty)||(wr_en && rd_en))? rd_ptr+1 : rd_ptr;
    end
 end
 
 
 //Fifo Counter OPeration
 always@(posedge clk) begin:count
    if(rst) fifo_count<=0;
    else begin
        case({wr_en , rd_en})
            2'b00 : fifo_count <= fifo_count;
            2'b01 : fifo_count <= (fifo_count==0) ? 0 : fifo_count-1;
            // After read operation data comes out of the Buffer thus count of data is reduced by one after read operation in FIFO
            2'b10 : fifo_count <= (fifo_count==8) ? 8 : fifo_count +1;
            //After any data written inside the Buffer the count will be increase by one thus the fifo_count increases
            2'b11 : fifo_count <= fifo_count;
            default: fifo_count <=fifo_count;
        endcase
      end
    end
 
endmodule
