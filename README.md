# LEA-FPGA
An attempt to make the LEA 128-bit cipher on an FPGA.

# About me:
My name is Alaa, a computer engineer that is interested in math, computer hardware, FPGA's, and some IoT development. 
I am always eager to learn more about FPGA development, if you have a project that you would like me to participate in, please hit me up.

# Acknowledgments:
This project is a collaboration between myself and [@Mumtaz667](https://github.com/Mumtaz667).

# This Project
As the name implies, this is an attempt to create the LEA-128-bit cipher on an FPGA.Please not that I have no previous experience in cryptography. I simply followed the algotithm in order to come up with this design. 

The final product should have 2 input ports that recieve the 128-bit input key and raw data. It will also have an output terminal that produces the encrypted data.

# Update History

#### 20-Jun-2019: 
The project simpy includes the key generator module. This module so far only include combinational logic because I tried my best to avoid using memories. The project has not been tested on a proper FPGA yet. 

#### 24-Jun-2019: 
The project now includes the encryption rounds processor. It also supports decryption.


# Symbols Used

#### <<i With 'C' on top:
Circular shift of i bits to the left 

#### something[n]:
Accessing the n'th index in an array or the n'th bit of a variable (vector in Verilog)

#### something[n:m]:
Accessing a slice of an array that starts from n and ends at m (inclusive of both). 

For example if i = 7 = 0b111 => i[1:0] = 0b11 = 3

#### 𝛿, 𝛿[n]:
An array of parameters defined such as:

δ[0] = 0xc3efe9db, δ[1] = 0x44626b02,

δ[2] = 0x79e27c8a, δ[3] = 0x78df30ec,

δ[4] = 0x715ea49e, δ[5] = 0xc785da0a,

δ[6] = 0xe04ef22a, δ[7] = 0xe5c40957.

#### ^:
Bit-wise XOR

# Project Explanation
The system takes a 128-bit input text and key and produces a 128-bit ciphertext based on them. It is also able to decrypt cypher text based on the the Encrypt-1/Decrypt input flag. 

As shown below, the design consists of 2 main parts:
* key generator
* round processor

![topModule](https://github.com/LadonAl/LEA-FPGA/blob/master/LEA-FPGA-top.png?raw=true)


## Key Generator
KeyGen or the key generator is respinsible of producing 24 192-bit round keys based on the input 128-bit key. Initially, the key bits are wired in groups of 32 bits (A, B, C, D) each of which gets circular shifted 8 bits to the left.

The block diagram could be found below.

![keyGen](https://github.com/LadonAl/LEA-FPGA/blob/master/LEA-FPGA-KeyGenerator.png?raw=true)

The shifted 32-bit groups are then fed into processing blocks. Each of these blocks prodecue a vector of 32-bit parts that are letar fed into a rewiring block that groups the vector elements into 24 different 192-bit outputs (round keys)

### Processing Blocks
As mentioned, the processing blocks are resposible of generating vectors of 32-bit data. This process is iterative and the iterations are independant.

A set of 4 parameters (the delta array in the upcoming graph) is provided to each of those unit. The parameters are equal for all of them, but the processing is slightly different. For A in this case, a parameter is first chosen based on the first 2 bits of the iteration count (equivalent to i mod 4). Then, the parameter is circular shifted i times (i is the iteration count). The result is added to the 32-bit part mentioned in the previous section (A in this case) and any carries will be dropped (the output is limited to have 32-bits, which is equivalent to mod 2^32). The sums of every iteration are shifted circularly by one and are outputted.

The block diagram could be found below:

![processA](https://github.com/LadonAl/LEA-FPGA/blob/master/LEA-FPGA-ProcessA.png?raw=true)


## Rounds
This module connects multiple roundU's (round units). Each round unit includes a single encryption round. 

This module also includes decryption units and takes an encryption/decryption flag that does not appear in the diagram below. Decryption is simply encryption where the first encryption unit recieves the last round key rather than the opposite. And produces the output based on the opposite arithmetic expression used for encryption.

![rounds](https://github.com/LadonAl/LEA-FPGA/blob/master/LEA-FPGA-Rounds.png?raw=true)


### RoundU's
This module takes its input from either a similar roundU module, or externally. It breaks it up into 4 32-bit blocks (A, B, C, D) and XOR's those blocks with the assigned 192-bit round key and adds the results based on the following:

* sum0 = (A ^ RK[0]) + (B ^ RK[1])
* sum1 = (B ^ RK[2]) + (C ^ RK[3])
* sum2 = (C ^ RK[4]) + (D ^ RK[5])

The output of this unit X is defined such as X = {sum0, sum1, sum2, A}

![roundU](https://github.com/LadonAl/LEA-FPGA/blob/master/LEA-FPGA-RoundU.png?raw=true)

# References:
Hong D., Lee JK., Kim DC., Kwon D., Ryu K.H., Lee DG. (2014) LEA: A 128-Bit Block Cipher for Fast Encryption on Common Processors. In: Kim Y., Lee H., Perrig A. (eds) Information Security Applications. WISA 2013. Lecture Notes in Computer Science, vol 8267. Springer, Cham



