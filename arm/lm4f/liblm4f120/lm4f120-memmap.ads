-----------------------------------------------------------------------
--
-- Copyright (C) 2014 Ali Paikan (ali.paikan@gmail.com).  
--
--   Redistribution and use in source and binary forms, with or without
--   modification, are permitted provided that the following conditions
--   are met:
-- 
--   Redistributions of source code must retain the above copyright
--   notice, this list of conditions and the following disclaimer.
-- 
--   Redistributions in binary form must reproduce the above copyright
--   notice, this list of conditions and the following disclaimer in the
--   documentation and/or other materials provided with the  
--   distribution.
-- 
--   Neither the name of Texas Instruments Incorporated nor the names of
--   its contributors may be used to endorse or promote products derived
--   from this software without specific prior written permission.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-- OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-- LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-- THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
-------------------------------------------------------------------------


pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package LM4F120.Memmap is

   FLASH_BASE : constant := 16#00000000#;  --  lm4f120/hw_memmap.h:49
   SRAM_BASE : constant := 16#20000000#;  --  lm4f120/hw_memmap.h:50
   WATCHDOG0_BASE : constant := 16#40000000#;  --  lm4f120/hw_memmap.h:51
   WATCHDOG1_BASE : constant := 16#40001000#;  --  lm4f120/hw_memmap.h:52
   GPIO_PORTA_BASE : constant := 16#40004000#;  --  lm4f120/hw_memmap.h:53
   GPIO_PORTB_BASE : constant := 16#40005000#;  --  lm4f120/hw_memmap.h:54
   GPIO_PORTC_BASE : constant := 16#40006000#;  --  lm4f120/hw_memmap.h:55
   GPIO_PORTD_BASE : constant := 16#40007000#;  --  lm4f120/hw_memmap.h:56
   SSI0_BASE : constant := 16#40008000#;  --  lm4f120/hw_memmap.h:57
   SSI1_BASE : constant := 16#40009000#;  --  lm4f120/hw_memmap.h:58
   SSI2_BASE : constant := 16#4000A000#;  --  lm4f120/hw_memmap.h:59
   SSI3_BASE : constant := 16#4000B000#;  --  lm4f120/hw_memmap.h:60
   UART0_BASE : constant := 16#4000C000#;  --  lm4f120/hw_memmap.h:61
   UART1_BASE : constant := 16#4000D000#;  --  lm4f120/hw_memmap.h:62
   UART2_BASE : constant := 16#4000E000#;  --  lm4f120/hw_memmap.h:63
   UART3_BASE : constant := 16#4000F000#;  --  lm4f120/hw_memmap.h:64
   UART4_BASE : constant := 16#40010000#;  --  lm4f120/hw_memmap.h:65
   UART5_BASE : constant := 16#40011000#;  --  lm4f120/hw_memmap.h:66
   UART6_BASE : constant := 16#40012000#;  --  lm4f120/hw_memmap.h:67
   UART7_BASE : constant := 16#40013000#;  --  lm4f120/hw_memmap.h:68
   I2C0_MASTER_BASE : constant := 16#40020000#;  --  lm4f120/hw_memmap.h:69
   I2C0_SLAVE_BASE : constant := 16#40020800#;  --  lm4f120/hw_memmap.h:70
   I2C1_MASTER_BASE : constant := 16#40021000#;  --  lm4f120/hw_memmap.h:71
   I2C1_SLAVE_BASE : constant := 16#40021800#;  --  lm4f120/hw_memmap.h:72
   I2C2_MASTER_BASE : constant := 16#40022000#;  --  lm4f120/hw_memmap.h:73
   I2C2_SLAVE_BASE : constant := 16#40022800#;  --  lm4f120/hw_memmap.h:74
   I2C3_MASTER_BASE : constant := 16#40023000#;  --  lm4f120/hw_memmap.h:75
   I2C3_SLAVE_BASE : constant := 16#40023800#;  --  lm4f120/hw_memmap.h:76
   GPIO_PORTE_BASE : constant := 16#40024000#;  --  lm4f120/hw_memmap.h:77
   GPIO_PORTF_BASE : constant := 16#40025000#;  --  lm4f120/hw_memmap.h:78
   GPIO_PORTG_BASE : constant := 16#40026000#;  --  lm4f120/hw_memmap.h:79
   GPIO_PORTH_BASE : constant := 16#40027000#;  --  lm4f120/hw_memmap.h:80
   PWM0_BASE : constant := 16#40028000#;  --  lm4f120/hw_memmap.h:81
   PWM1_BASE : constant := 16#40029000#;  --  lm4f120/hw_memmap.h:82
   QEI0_BASE : constant := 16#4002C000#;  --  lm4f120/hw_memmap.h:83
   QEI1_BASE : constant := 16#4002D000#;  --  lm4f120/hw_memmap.h:84
   TIMER0_BASE : constant := 16#40030000#;  --  lm4f120/hw_memmap.h:85
   TIMER1_BASE : constant := 16#40031000#;  --  lm4f120/hw_memmap.h:86
   TIMER2_BASE : constant := 16#40032000#;  --  lm4f120/hw_memmap.h:87
   TIMER3_BASE : constant := 16#40033000#;  --  lm4f120/hw_memmap.h:88
   TIMER4_BASE : constant := 16#40034000#;  --  lm4f120/hw_memmap.h:89
   TIMER5_BASE : constant := 16#40035000#;  --  lm4f120/hw_memmap.h:90
   WTIMER0_BASE : constant := 16#40036000#;  --  lm4f120/hw_memmap.h:91
   WTIMER1_BASE : constant := 16#40037000#;  --  lm4f120/hw_memmap.h:92
   ADC0_BASE : constant := 16#40038000#;  --  lm4f120/hw_memmap.h:93
   ADC1_BASE : constant := 16#40039000#;  --  lm4f120/hw_memmap.h:94
   COMP_BASE : constant := 16#4003C000#;  --  lm4f120/hw_memmap.h:95
   GPIO_PORTJ_BASE : constant := 16#4003D000#;  --  lm4f120/hw_memmap.h:96
   CAN0_BASE : constant := 16#40040000#;  --  lm4f120/hw_memmap.h:97
   CAN1_BASE : constant := 16#40041000#;  --  lm4f120/hw_memmap.h:98
   CAN2_BASE : constant := 16#40042000#;  --  lm4f120/hw_memmap.h:99
   ETH_BASE : constant := 16#40048000#;  --  lm4f120/hw_memmap.h:100
   MAC_BASE : constant := 16#40048000#;  --  lm4f120/hw_memmap.h:101
   WTIMER2_BASE : constant := 16#4004C000#;  --  lm4f120/hw_memmap.h:102
   WTIMER3_BASE : constant := 16#4004D000#;  --  lm4f120/hw_memmap.h:103
   WTIMER4_BASE : constant := 16#4004E000#;  --  lm4f120/hw_memmap.h:104
   WTIMER5_BASE : constant := 16#4004F000#;  --  lm4f120/hw_memmap.h:105
   USB0_BASE : constant := 16#40050000#;  --  lm4f120/hw_memmap.h:106
   I2S0_BASE : constant := 16#40054000#;  --  lm4f120/hw_memmap.h:107
   GPIO_PORTA_AHB_BASE : constant := 16#40058000#;  --  lm4f120/hw_memmap.h:108
   GPIO_PORTB_AHB_BASE : constant := 16#40059000#;  --  lm4f120/hw_memmap.h:109
   GPIO_PORTC_AHB_BASE : constant := 16#4005A000#;  --  lm4f120/hw_memmap.h:110
   GPIO_PORTD_AHB_BASE : constant := 16#4005B000#;  --  lm4f120/hw_memmap.h:111
   GPIO_PORTE_AHB_BASE : constant := 16#4005C000#;  --  lm4f120/hw_memmap.h:112
   GPIO_PORTF_AHB_BASE : constant := 16#4005D000#;  --  lm4f120/hw_memmap.h:113
   GPIO_PORTG_AHB_BASE : constant := 16#4005E000#;  --  lm4f120/hw_memmap.h:114
   GPIO_PORTH_AHB_BASE : constant := 16#4005F000#;  --  lm4f120/hw_memmap.h:115
   GPIO_PORTJ_AHB_BASE : constant := 16#40060000#;  --  lm4f120/hw_memmap.h:116
   GPIO_PORTK_BASE : constant := 16#40061000#;  --  lm4f120/hw_memmap.h:117
   GPIO_PORTL_BASE : constant := 16#40062000#;  --  lm4f120/hw_memmap.h:118
   GPIO_PORTM_BASE : constant := 16#40063000#;  --  lm4f120/hw_memmap.h:119
   GPIO_PORTN_BASE : constant := 16#40064000#;  --  lm4f120/hw_memmap.h:120
   GPIO_PORTP_BASE : constant := 16#40065000#;  --  lm4f120/hw_memmap.h:121
   GPIO_PORTQ_BASE : constant := 16#40066000#;  --  lm4f120/hw_memmap.h:122
   LPC0_BASE : constant := 16#40080000#;  --  lm4f120/hw_memmap.h:123
   FAN0_BASE : constant := 16#40084000#;  --  lm4f120/hw_memmap.h:124
   EEPROM_BASE : constant := 16#400AF000#;  --  lm4f120/hw_memmap.h:125
   PECI0_BASE : constant := 16#400B0000#;  --  lm4f120/hw_memmap.h:126

   I2C4_MASTER_BASE : constant := 16#400C0000#;  --  lm4f120/hw_memmap.h:128
   I2C4_SLAVE_BASE : constant := 16#400C0800#;  --  lm4f120/hw_memmap.h:129
   I2C5_MASTER_BASE : constant := 16#400C1000#;  --  lm4f120/hw_memmap.h:130
   I2C5_SLAVE_BASE : constant := 16#400C1800#;  --  lm4f120/hw_memmap.h:131
   EPI0_BASE : constant := 16#400D0000#;  --  lm4f120/hw_memmap.h:132
   SYSEXC_BASE : constant := 16#400F9000#;  --  lm4f120/hw_memmap.h:133
   HIB_BASE : constant := 16#400FC000#;  --  lm4f120/hw_memmap.h:134
   FLASH_CTRL_BASE : constant := 16#400FD000#;  --  lm4f120/hw_memmap.h:135
   SYSCTL_BASE : constant := 16#400FE000#;  --  lm4f120/hw_memmap.h:136
   UDMA_BASE : constant := 16#400FF000#;  --  lm4f120/hw_memmap.h:137
   ITM_BASE : constant := 16#E0000000#;  --  lm4f120/hw_memmap.h:138
   DWT_BASE : constant := 16#E0001000#;  --  lm4f120/hw_memmap.h:139
   FPB_BASE : constant := 16#E0002000#;  --  lm4f120/hw_memmap.h:140
   NVIC_BASE : constant := 16#E000E000#;  --  lm4f120/hw_memmap.h:141
   TPIU_BASE : constant := 16#E0040000#;  --  lm4f120/hw_memmap.h:142

   --  skipped func __dummy__

end LM4F120.Memmap;
