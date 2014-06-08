adalove
=======

Whatever done for any ARM cpu tm4c123G


Quick guide on how to run the example: 

-- Compiling --
1) cd <example>
2) make

-- Running the J-Link debugger --
3) $ sudo openocd --file --file /usr/local/share/openocd/scripts/board/ek-tm4c123gxl.cfg

-- Flashing the binary --
4) sudo lm4flash main.bin


-- Debuging --
4) $ telnet localhost 4444
     reset halt
5) $ /usr/local/arm-none-eabi-insight/bin/arm-none-eabi-insight --eval-command="target remote localhost:3333" test.out

