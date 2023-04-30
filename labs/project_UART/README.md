# Universal Asynchronous Receiver and Transmitter  

## Team members
* Began Mojmír
* Koiš Christopher 
* Shapoval Yaroslav

## Description and explanation

Our project handles the reception and transmission of any data stream using two communication wires. The data stream needs to contain a 
**start bit, 8 data bits** and, if desired, a **parity bit**. <br>
The communication can also be made using one Nexys A7-50T board and a PC via the PuTTY client. <br> 

<!-- <p align="center">
  <img src="images/nexys-a7-top-600.png" />
</p> -->
<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/images/nexys-a7-top-600.png" />
</p>

The baud rate is variable in a standard range: **4800** to **115200** bps, this is set by three switches and is visible on the display.<br>
Our implementation uses a manual transmitter/receiver mode toggle. In the transmitter mode, the board is either continuously sending set data, which is toggled by the **S.b.** switch, or just once. ***Odkaz na konkretne tlacidlo*** <br>

Once the baud rate, start bit, data bits and parity bit are set, the communication is ready to begin. <br>
In the receiver mode, the receiver is waiting for a start bit and then reads the incoming data, calculates parity and shows whether the read signal is faulty. ***(and which bit was incorrect)*** <br>

The boards are connected via the Pmod ports JA on the **transmitter** and JB on the **receiver** side, using pin 1 and pin 6 (GND). <br>

At first, we wanted to use a keyboard as an input method for the transmitter, but we settled on using a static method with an option of utilising the PuTTY console as an alternative. <br>

## Software description

<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/images/schema_nedo.png" />
</p>

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

1. Referencie na datasheet NEXIS anpríklad
2. nejaký VHDL cheat-sheet
3. a pod.

## Transmitter Circuit

![img1](images/Transmitter_block.png)
![img2](images/Transmitter_schematic.png)

## Receiver Circuit

![img1](images/Receiver_block.png)
![img2](images/Receiver_schematic.png)