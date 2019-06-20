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

![alt text](https://raw.githubusercontent.com/LadonAl/LEA-FPGA/master/LEA-FPGA-KeyGenerator.png?token=AFVCXHIUV3MIH7H76BH4ETC5BN63S)

The shifted 32-bit groups are then fed into processing blocks. Each of these blocks prodecue a vector of 32-bit parts that are letar fed into a rewiring block that groups the vector elements into 24 different 192-bit outputs (round keys)

## Processing Blocks
As mentioned, the processing blocks are resposible of generating vectors of 32-bit data.
This module follows the following formula: 
![img](http://www.sciweavers.org/tex2img.php?eq=%5C%7B%5BA%20%2B%20%28%5Cdelta%20%5Bi%5C%20mod%5C%204%5D%5C%20%3C%3C%5EC%20i%29%5D%5C%20mod%5C%202%5E%7B32%7D%5C%7D%5C%20%3C%3C%5Ec%201&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)

