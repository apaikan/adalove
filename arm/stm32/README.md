adalove
=======

Whatever done for any ARM cpu STM32 (F10X)


Quick guide on how to run the example: 

-- Compiling --
1) cd <example>
2) make

-- Running the J-Link debugger --
3) $ sudo openocd --file .../conf/ocd_ministm32.cfg

-- Flashing the binary --
4) $ telnet localhost 4444
     reset halt
     flash probe 0
     stm32f1x mass_erase 0
     flash write_bank 0 test.bin 0
     reset halt

-- Debuging --
5) $ /usr/local/arm-none-eabi-insight/bin/arm-none-eabi-insight --eval-command="target remote localhost:3333" test.out

