# LEA-FPGA
An attempt to make the LEA 128-bit cipher on an FPGA.

# About me:
My name is Alaa, a computer engineer that is interested in math, computer hardware, FPGA's, and some IoT development. 
I am always eager to learn more about FPGA development, if you have a project that you would like me to participate in, please hit me up.

# This Project
As the name implies, this is an attempt to create the LEA-128-bit cipher on an FPGA.Please not that I have no previous experience in cryptography. I simply followed the algotithm in order to come up with this design. 

The final product should have 2 input ports that recieve the 128-bit input key and raw data. It will also have an output terminal that produces the encrypted data.

Today 20-Jun-2019, the project simpy includes the key generator module. This module so far only include combinational logic because I tried my best to avoid using memories. The project has not been tested on a proper FPGA yet.  

## KeyGen
KeyGen or the key generator is respinsible of producing 24 192-bit round keys based on the input 128-bit key. Initially, the key bits are wired in groups of 32 bits (A, B, C, D) each of which gets circular shifted 8 bits to the left.

The block diagram could be found below.

![keyGen](https://github.com/LadonAl/LEA-FPGA/blob/master/LEA-FPGA-KeyGenerator.png?raw=true)

The shifted 32-bit groups are then fed into processing blocks. Each of these blocks prodecue a vector of 32-bit parts that are letar fed into a rewiring block that groups the vector elements into 24 different 192-bit outputs (round keys)

## Processing Blocks
As mentioned, the processing blocks are resposible of generating vectors of 32-bit data. This process is iterative and the iterations are independant.

A set of 4 parameters (the delta array in the upcoming graph) is provided to each of those unit. The parameters are equal for all of them, but the processing is slightly different. For A in this case, a parameter is first chosen based on the first 2 bits of the iteration count (equivalent to i mod 4). Then, the parameter is circular shifted i times (i is the iteration count). The result is added to the 32-bit part mentioned in the previous section (A in this case) and any carries will be dropped (the output is limited to have 32-bits, which is equivalent to mod 2^32). The sums of every iteration are shifted circularly by one and are outputted.

The block diagram could be found below:

![processA](https://github.com/LadonAl/LEA-FPGA/blob/master/LEA-FPGA-ProcessA.png?raw=true)



