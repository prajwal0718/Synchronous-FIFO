# Verilog-and-systemverilog
Verilog and systemverilog projects

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
So we use another variable 'fullchk' to check if the last operation was write and the FIFO became full. Then this can be used to assert full signal.
Similarly if 'emptychk' is there, then we can say that the FIFO is empty.

Verilog Code Logic:
1) Use variables rdptr to traverse read location and wrptr to traverse write locations in memory.
2) During push signal, write to the memory and increment wrptr.
3) During pop, read from the memory and decrement rdptr.
4) Empty is asserted when pointers are equal and there is emptychk. Deasserted when a push occurs.
5) Full occurs when there is fullchk. Deasserted when a pop occurs.

