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

## Hardware description
<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/images/nexys-a7-top-600.png" />
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
In the receiver mode, the receiver is waiting for a start bit and then reads the incoming data, calculates parity and shows whether the read signal is faulty on the RGB LED *LD17*. The incoming data is displayed on the LED row *LED[15]* to *LED[0]*<br>

The Pmod port JB is used for reception, the pinout is the same as in Transmitter.<br>

## Software description
<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/images/schema_nedo.png" />
</p>

### Baud Clock

The [*clk_baud*](https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/UART/UART.srcs/sources_1/new/clk_baud.vhd) module houses two processes, one is used for selecting a desired baud rate, the other one is a modified version of *p_clk_enable* from [*clock_enable*](https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/UART/UART.srcs/sources_1/new/clock_enable.vhd).<br> 
5 outputs labeled *data0* to *data4* are used for displaying the selected baud rate on the display. *clk_baud* output is used as a downscaled clock for the modules [*transmitter*](https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/UART/UART.srcs/sources_1/new/transmitter.vhd) and [*receiver*](https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/UART/UART.srcs/sources_1/new/receiver.vhd).

### Transmitter

The [*transmitter*](https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/UART/UART.srcs/sources_1/new/transmitter.vhd) module packages and transmits the set data in the *P_Transmitting* process. It makes use of the *data_busy* flag, so that it transmits only when the process is not busy. The loaded data is packaged into the *frame* variable and is then pushed onto the *Tx_out* variable bit by bit. This is then followed up by a parity bit and a stop bit.

### Receiver

The [*receiver*](https://github.com/MojmirBegan/digital-electronics-1/blob/main/labs/x1-project_UART/UART/UART.srcs/sources_1/new/receiver.vhd) module reads the incoming data from *Rx_data*. The *inside* process is very similar to the *P_Transmitting* process from the *transmitter* module. While the *data_busy* flag is set, it stores the read data into the *frame* variable bit by bit.<br>
The parity is calculated in the *P_parity* process and the value in *frame* is pushed onto the LED bus in the *P_led* process. 

### Waveforms from simulation

#### Baud Clock
<p align="center">
  <img src="https://github.com/GraniteGobbler/digital-electronics-1/blob/main/labs/project_UART/images/tb_clk_baud.png" />
</p>

#### Transmitter
<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/tree/main/labs/x1-project_UART/images/tb_transmitter.png" />
</p>

#### Receiver
<p align="center">
  <img src="https://github.com/MojmirBegan/digital-electronics-1/tree/main/labs/x1-project_UART/images/tb_receiver.png" />
</p>

## Instructions
1. Connect the **JA port of the transmitter** board and the **JB port of the receiver** board using two wires. One wire should connect pins 1 and the other wire should connect pins 6.<br> The ***TX*** and ***RX*** switches (*SW[11]*, *SW[10]*) select the board mode.

2. Set the baud rate on both boards.

   | **Baud rate** | **SW[15]** | **SW[14]** | **SW[13]** |
   | :-: | :-: | :-: | :-: |
   | 4800 | 0 | 0 | 0 |
   | 9600 | 0 | 0 | 1 |
   | 14400 | 0 | 1 | 0 |
   | 19200 | 0 | 1 | 1 |
   | 28800 | 1 | 0 | 0 |
   | 38400 | 1 | 0 | 1 |
   | 57600 | 1 | 1 | 0 |
   | 115200 | 1 | 1 | 1 |

3. Set the ***Parity Enable*** (*SW[9]*)and the ***Parity Odd/Even*** (*SW[8]*) switches on both boards.

4. On the transmitter board, set the data on the ***TX_DATA*** switches (*SW[7]* to *SW[0]*).<br>

   *4.1. Optional:* Connect the receiver board to the Arduino Uno board and open PuTTY. After setting up PuTTY you should be able to send keyboard inputs to the receiver.

## References

* [Nexys A7 Reference Manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)
* [Rohde&Schwarz: Understanding UART article](https://www.rohde-schwarz.com/cz/products/test-and-measurement/essentials-test-equipment/digital-oscilloscopes/understanding-uart_254524.html#:~:text=UART%20stands%20for%20universal%20asynchronous,and%20receive%20in%20both%20directions)
* [PROTOCOLS: UART - I2C - SPI - Serial communications #001](https://www.youtube.com/watch?v=IyGwvGzrqp8&ab_channel=Electronoobs)
* [Nexys A7-50T GPIO Demo](https://github.com/Digilent/Nexys-A7-50T-GPIO)
* [UART code example 1](https://www.fpgarelated.com/thread/12580/uart-communication-for-nexys-a7-100t)
* [UART code example 2](https://www.pantechsolutions.net/vhdl-code-for-uart-serial-communication#:~:text=UART%20Stands%20for%20Universal%20Asynchronous,sequential%20data%20with%20control%20bits)
* [UART code example 3](https://www.analog.com/en/analog-dialogue/articles/uart-a-hardware-communication-protocol.html#:~:text=The%20transmitting%20UART%20is%20connected,parallel%20for%20the%20receiving%20device)
