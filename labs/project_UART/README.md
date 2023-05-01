# Universal Asynchronous Receiver and Transmitter  

## Team members
* Begán Mojmír (205 895) - Git-Hub repository, transmitter
* Koiš Christopher (240 635) - Receiver, documentation
* Shapoval Yaroslav (233 258) - Receiver, baud component

## Description and explanation

Our project handles the reception and transmission of any data stream using two communication wires. The data stream must contain a 
**start bit, 8 data bits, stop bit** and, if desired, a **parity bit**. <br>

The communication can also be made using one Nexys A7-50T board **and** a PC via the PuTTY client. <br> 
At first, we wanted to use a keyboard as an input method for the transmitter, but we settled on using a static method with an option of utilising the PuTTY console as an alternative. <br>

<!-- <p align="center">
  <img src="images/nexys-a7-top-600.png" />
</p> -->
<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/images/nexys-a7-top-600.png" />
</p>

## Hardware description

<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/images/schema_nedo.png" />
</p>

### Baud Clock
The baud rate is variable in a standard range: **4800** to **115200** bps, this is set by three switches (*SW[15]* to *SW[13]*) and is visible on the display.<br>

### Mode Switch
Our implementation uses a manual Transmitter/Receiver/Transceiver mode toggle (*SW[11]*, *SW[10]*). In the transmitter mode, the board is continuously sending set data. Our implementation is able to transmit and receive simulatneously, therefore a transceiver mode is also available.<br>

### Transmitter
The data is set using *SW[7]* to *SW[0]*, **LSB** is on *SW[0]*. The sent data is delimited by a stop bit. If the parity is set (*SW[9]*), the user can choose if the parity should be even or odd (*SW[8]*). This is visible on the display.<br>

The Pmod port JA is used for transmission, pin **1** is for the signal, pin **6** is GND.<br>

### Receiver
Once the baud rate, start bit, data bits and parity bit are set, the communication is ready to begin.<br>
In the receiver mode, the receiver is waiting for a start bit and then reads the incoming data, calculates parity and shows whether the read signal is faulty on the RGB LED *LD17*.<br>

The Pmod port JB is used for reception, the pinout is the same as in Transmitter.<br>

## Software description

### Transmitter

The [top_transmitter](morse_transmitter/morse_transmitter.srcs/sources_1/new/top.vhd) has four input and three output ports. It includes two entities. [Bin_7seg](morse_transmitter/morse_transmitter.srcs/sources_1/new/bin_7seg.vhd), which converts the input binary code to individual segment to be set on the display. The segment can be blanked by pressing a button (BTNC). The second entity [(bin_morse)](morse_transmitter/morse_transmitter.srcs/sources_1/new/bin_morse.vhd) of top design is the main converter from binary format of letter to morse code. It contains the [prescaler](morse_transmitter/morse_transmitter.srcs/sources_1/new/clock_enable.vhd), which divide the main clock by g_max = 10 000 000. That means, the morse converter is controlled by clock with period of 100 ms.

### Receiver

The software of receiving FPGA board is very similar to the transmitter. The [top design](morse_receiver/morse_receiver.srcs/top_receiver.vhd) source also contains two entities. First one, called [morse_bin](morse_receiver/morse_receiver.srcs/morse_bin.vhd), parse the input morse code to bin representation of a letter. The conversion is done by decision of counter value, which is incremented during high pulse of input signal. If the value is 5 the input signal represents dot if it's 15 the signal represents dash. A low pulse is also followed by another counter, which when it reaches 200 ms, the reception of letter is considered as finished. All counters in this entity are feed by [prescaler](morse_receiver/morse_receiver.srcs/clock_enable.vhd) of constant g_max = 2 000 000, which coresponds to 20 ms. <br> The second part of top design is the same binary to 7 segemnt [converter](Z:/PC-II-SummerSemester/BPC-DE1-project/morse_receiver/morse_receiver.srcs/bin_7seg.vhd) as in the transmitter.

### Block diagrams of software 

Dva obrázky diagramov.

### Waveforms from simulation

#### Transmitter
![img](images/Transmitter_testbench_2.png)
#### Receiver
![img](images/Receiver_testbench_2.png)

<p>

## Instructions
Usage of the transmitter is as follows:
1. By using position switches on the Nexys 4 Artix 7 FPGA development board, user can select a desired letter to be sent.
2. BTND button serves as a send button. By pressing it, the transmitter sends the morse code to the receiver by an IR LED.
   The progress can be observed on an LED connected parallel to the sending output.
   
Receiver doesn't require any intervention by the user. It's always waiting for an incoming transmission  and displays it on a 7 segment display.

[Working demonstration video](https://youtu.be/yEXXWRQE4EQ)

## References

* [Nexys A7 Reference Manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)
* [Rohde&Schwarz: Understanding UART article](https://www.rohde-schwarz.com/cz/products/test-and-measurement/essentials-test-equipment/digital-oscilloscopes/understanding-uart_254524.html#:~:text=UART%20stands%20for%20universal%20asynchronous,and%20receive%20in%20both%20directions)
* [PROTOCOLS: UART - I2C - SPI - Serial communications #001](https://www.youtube.com/watch?v=IyGwvGzrqp8&ab_channel=Electronoobs)
* [Nexys A7-50T GPIO Demo](https://github.com/Digilent/Nexys-A7-50T-GPIO)
* [UART code example 1](https://www.fpgarelated.com/thread/12580/uart-communication-for-nexys-a7-100t)
* [UART code example 2](https://www.pantechsolutions.net/vhdl-code-for-uart-serial-communication#:~:text=UART%20Stands%20for%20Universal%20Asynchronous,sequential%20data%20with%20control%20bits)
* [UART code example 3](https://www.analog.com/en/analog-dialogue/articles/uart-a-hardware-communication-protocol.html#:~:text=The%20transmitting%20UART%20is%20connected,parallel%20for%20the%20receiving%20device)
