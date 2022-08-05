
Synchronous FIFO

The First In First Out (FIFO) is a data arrangement structure in which the data that enters first is the one that is removed first.
Procedure to implement FIFO:
1) Create a normal memory in Verilog.
2) When the data and push signal(This is also called as write enable) is given, write to the memory starting from first address.
3) When pop signal(or read enable) is given, read from the memory from the first address.
4) When FIFO becomes empty, assert empty and if it becomes full, assert full signal.
5) We require a write pointer as well as a read pointer to control a FIFO because we keep incrementing the address while writing, whereas for read, we have to start from the first address.

Empty and Full Condition:
We have rdptr and wrptr. When both the pointers are equal, the FIFO could either be empty or full.
--If the last operation was write and the pointers become equal, then the FIFO is full.
--If the last operation was read and the pointers become equal, then the FIFO is empty.

Synchronous FIFO implemented in Xilinx Vivado
<img width="498" alt="Synchronous_FIFO" src="https://user-images.githubusercontent.com/65390753/183115791-fd97df20-bd62-4331-bcdc-8d144a58b355.PNG">


