# Lab 4: Seven-segment display decoder

<!--
![Logo](../../logolink_eng.jpg)
<p align="center">
  The Study of Modern and Developing Engineering BUT<br>
  CZ.02.2.69/0.0/0.0/18_056/0013325
</p>
-->

### Learning objectives

After completing this lab you will be able to:

* Use 7-segment display
* Use VHDL processes
* Understand the structural VHDL description

The purpose of this laboratory exercise is to design a 7-segment display decoder and to become familiar with the VHDL structural description that allows you to build a larger system from simpler or predesigned components.

### Table of contents

* [Pre-Lab preparation](#preparation)
* [Part 1: Synchronize Git and create a new folder](#part1)
* [Part 2: VHDL code for seven-segment display decoder](#part2)
* [Part 3: Top level VHDL code](#part3)
* [Experiments on your own](#experiments)
* [Post-Lab report](#report)
* [References](#references)

<a name="preparation"></a>

## Pre-Lab preparation

The Nexys A7 board provides two four-digit common anode seven-segment LED displays (configured to behave like a single eight-digit display).

1. See [schematic](https://github.com/tomas-fryza/digital-electronics-1/blob/master/docs/nexys-a7-sch.pdf) or [reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board and find out the connection of 7-segment displays, ie to which FPGA pins are connected and how.

2. Complete the decoder truth table for **common anode** 7-segment display.

   | **Symbol** | **Inputs** | **a** | **b** | **c** | **d** | **e** | **f** | **g** |
   | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
   | 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
   | 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
   | 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
   | 3 | 0011 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |
   | 4 | 0100 | 1 | 0 | 0 | 1 | 1 | 0 | 0 |
   | 5 | 0101 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
   | 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
   | 7 | 0111 | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
   | 8 | 1000 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
   | 9 | 1001 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
   | A | 1010 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
   | b | 1011 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
   | C | 1100 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |
   | d | 1101 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
   | E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
   | F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |

   > ![https://lastminuteengineers.com/seven-segment-arduino-tutorial/](images/7-Segment-Display-Number-Formation-Segment-Contol.png)
   >
   > The image above was used from website: [How Seven Segment Display Works & Interface it with Arduino](https://lastminuteengineers.com/seven-segment-arduino-tutorial/).
   >

<a name="part1"></a>

## Part 1: Synchronize repositories and create a new folder

1. Run Git Bash (Windows) of Terminal (Linux), navigate to your working directory, and update local repository.

   > **Help:** Useful bash and git commands are `cd` - Change working directory. `mkdir` - Create directory. `ls` - List information about files in the current directory. `pwd` - Print the name of the current working directory. `git status` - Get state of working directory and staging area. `git pull` - Update local repository and working folder.

   ```bash
   ## Windows Git Bash or Linux:
   $ git pull
   ```

2. Create a new working folder `04-segment` for this exercise.

3. Use your favorite text editor, such as VS Code, Notepad++, etc. and create a new file `README.md` in your `04-segment/` folder. Copy/paste [report template](https://raw.githubusercontent.com/tomas-fryza/digital-electronics-1/master/labs/04-segment/report.md) to your `04-segment/README.md` file.

<a name="part2"></a>

## Part 2: VHDL code for seven-segment display decoder

The Hex to 7-Segment Decoder converts 4-bit binary data to 7-bit control signal which can be displayed on 7-segment display. A display consist of 7 LED segments to display 0 to 9 and A to F.

1. Perform the following steps to simulate the seven-segment display decoder in Vivado.

   1. Create a new Vivado RTL project `display` in your `04-segment` working folder.
   2. Create a VHDL source file `hex_7seg` for the decoder.
   3. Choose default board: `Nexys A7-50T`.
   4. Use **Define Module** dialog and define I/O ports of entity `hex_7seg` as follows.

      | **Port name** | **Direction** | **Type** | **Description** |
      | :-: | :-: | :-- | :-- |
      | `blank` | input | `std_logic` | Display is clear if blank = 1 |
      | `hex` | input   | `std_logic_vector(3 downto 0)` | Binary representation of one hexadecimal symbol |
      | `seg` | output  | `std_logic_vector(6 downto 0)` | Seven active-low segments in the order: a, b, ..., g |

      ![Vivado Port definition](images/vivado_io_ports.png)





   5. Copy/paste the archtitecture [template](https://www.edaplayground.com/x/Vdpu). Use [combinational process](https://github.com/tomas-fryza/digital-electronics-1/wiki/Processes) and complete an architecture of the decoder. Note that, the process `p_7seg_decoder` is "executed" only when `hex` or `blank` value is changed. Inside a process, `case`-`when` [assignments](https://github.com/tomas-fryza/digital-electronics-1/wiki/Signal-assignments) can be used.








   6. Create a VHDL simulation source `tb_hex_7seg`, copy/paste the [template](https://www.edaplayground.com/x/Vdpu), complete all test cases, and verify the functionality of your decoder.

   7. Use **Flow** > **Open Elaborated design** and see the schematic after RTL analysis. Note that RTL (Register Transfer Level) represents digital circuit at the abstract level.

<a name="part3"></a>

## Part 3: Top level VHDL code

VHDL provides a mechanism how to build a larger system from simpler or predesigned components. It is called an instantiation. Each instantiation statement creates an instance (copy) of a design entity.

VHDL-93 and later offers two methods of instantiation: **direct instantiation** and **component instantiation**. In direct instantiation, the entity itself is directly instantiated in an architecture. Its ports are connected using the port map. Let the top-level design `top.vhd`, implements an instance of the module defined in `hex_7seg.vhd`.

1. Perform the following steps to implement the seven-segment display decoder on the Nexys A7 board.

   1. Create a new VHDL design source `top` in your project.
   2. Use **Define Module** dialog and define I/O ports of entity `top` as follows.

      | **Port name** | **Direction** | **Type** | **Description** |
      | :-: | :-: | :-- | :-- |
      | `SW` | in  | `std_logic_vector(3 downto 0)` | Input binary data |
      | `LED` | out | `std_logic_vector(7 downto 0)` | LED indicators |
      | `CA` | out | `std_logic` | Cathod A |
      | `CB` | out | `std_logic` | Cathod B |
      | `CC` | out | `std_logic` | Cathod C |
      | `CD` | out | `std_logic` | Cathod D |
      | `CE` | out | `std_logic` | Cathod E |
      | `CF` | out | `std_logic` | Cathod F |
      | `CG` | out | `std_logic` | Cathod G |
      | `AN` | out | `std_logic_vector(7 downto 0)` | Common anode signals to individual displays |
      | `BTNC` | in | `std_logic` | Blank (clear) display |

   3. Use [direct instantiation](https://github.com/tomas-fryza/digital-electronics-1/wiki/Direct-instantiation) and define an architecture of the top level.

```vhdl
------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------

architecture behavioral of top is

begin

  --------------------------------------------------------------------
  -- Instance (copy) of hex_7seg entity
  --------------------------------------------------------------------

  hex2seg : entity work.hex_7seg
    port map (
      blank  => BTNC,
      hex    => SW,
      seg(6) => CA,
      seg(5) => CB,

      -- WRITE YOUR CODE HERE
      seg(4) => CC,
      seg(3) => CD,
      seg(2) => CE,
      seg(1) => CF,
      seg(0) => CG
    );

  -- Connect one common anode to 3.3V
  AN <= b"1111_0111";

  -- Display input value on LEDs
  LED(3 downto 0) <= SW;

--------------------------------------------------------------------
-- Experiments on your own: LED(7:4) indicators

-- Turn LED(4) on if input value is equal to 0, ie "0000"
-- LED(4) <= `0` when WRITE YOUR CODE HERE

-- Turn LED(5) on if input value is greater than "1001", ie 10, 11, 12, ...
-- LED(5) <= WRITE YOUR CODE HERE

-- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
-- LED(6) <= WRITE YOUR CODE HERE

-- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
-- LED(7) <= WRITE YOUR CODE HERE

end architecture behavioral;
```

   ![Top level](images/top_hex_7seg.png)

   4. Create a new [constraints XDC](https://raw.githubusercontent.com/Digilent/digilent-xdc/master/Nexys-A7-50T-Master.xdc) file: `nexys-a7-50t` and uncomment used pins according to the `top` entity.
   5. Compile the project and download the generated bitstream `YOUR_FOLDER/display/display.runs/impl_1/top.bit` into the FPGA chip.
   6. Test the functionality of the seven-segment display decoder by toggling the switches and observing the display and LEDs. Change the binary value `AN <= b"0111_1111"` and observe its effect on the display selection.

      ![Nexys A7 board](images/nexys_a7_segment.jpg)

   7. Use **IMPLEMENTATION > Open Implemented Design > Schematic** to see the generated structure.

2. When you finish, always synchronize the contents of your working folder with the local and remote versions of your repository. This way you are sure that you will not lose any of your changes. To do that, use git commands to add, commit, and push all local changes to your remote repository. Check GitHub web page for changes.

   > **Help:** Useful git commands are `git status` - Get state of working directory and staging area. `git add` - Add new and modified files to the staging area. `git commit` - Record changes to the local repository. `git push` - Push changes to remote repository. `git pull` - Update local repository and working folder. Note that, a brief description of useful git commands can be found [here](https://github.com/tomas-fryza/digital-electronics-1/wiki/Useful-Git-commands) and detailed description of all commands is [here](https://github.com/joshnh/Git-Commands).

<a name="experiments"></a>

## Experiments on your own

1. Complete the truth table for LEDs according to comments in source code above.

   | **Hex** | **Inputs** | **LED4** | **LED5** | **LED6** | **LED7** |
   | :-: | :-: | :-: | :-: | :-: | :-: |
   | 0 | 0000 |  |  |  |  |
   | 1 | 0001 |  |  |  |  |
   | 2 |      |  |  |  |  |
   | 3 |      |  |  |  |  |
   | 4 |      |  |  |  |  |
   | 5 |      |  |  |  |  |
   | 6 |      |  |  |  |  |
   | 7 |      |  |  |  |  |
   | 8 | 1000 |  |  |  |  |
   | 9 |      |  |  |  |  |
   | A |      |  |  |  |  |
   | b |      |  |  |  |  |
   | C |      |  |  |  |  |
   | d |      |  |  |  |  |
   | E | 1110 |  |  |  |  |
   | F | 1111 |  |  |  |  |

2. Use VHDL construction `when`-`else` or low-level gates `and`, `or`, and `not` and write logic functions for LED(7:4) indicators in the simplest way possible.

<a name="report"></a>

## Post-Lab report

*Complete all parts of `04-segment/README.md` file (see Part 1.3) in Czech, Slovak, or English, push it to your GitHub repository, and submit a link to this file via [BUT e-learning](https://moodle.vutbr.cz/). The deadline for submitting the task is the day before the next lab, i.e. in one week.*

*Vypracujte všechny části ze souboru `04-segment/README.md` (viz Část 1.3) v českém, slovenském, nebo anglickém jazyce, uložte je na váš GitHub repozitář a odevzdejte link na tento soubor prostřednictvím [e-learningu VUT](https://moodle.vutbr.cz/). Termín odevzdání úkolu je den před dalším laboratorním cvičením, tj. za jeden týden.*

<a name="references"></a>

## References

1. Digilent blog. [Nexys A7 Reference Manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual)

2. LastMinuteEngineers. [How Seven Segment Display Works & Interface it with Arduino](https://lastminuteengineers.com/seven-segment-arduino-tutorial/)

3. Tomas Fryza. [Template for 7-segment display decoder](https://www.edaplayground.com/x/Vdpu)

4. Digilent. [General .xdc file for the Nexys A7-50T](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-A7-50T-Master.xdc)
