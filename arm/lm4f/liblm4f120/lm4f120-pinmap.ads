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
with LM4F120;

package LM4F120.Pinmap is

   GPIO_PA0_U0RX : constant := 16#00000001#;  --  pin_map.h:49819

   GPIO_PA1_U0TX : constant := 16#00000401#;  --  pin_map.h:49821

   GPIO_PA2_SSI0CLK : constant := 16#00000802#;  --  pin_map.h:49823

   GPIO_PA3_SSI0FSS : constant := 16#00000C02#;  --  pin_map.h:49825

   GPIO_PA4_SSI0RX : constant := 16#00001002#;  --  pin_map.h:49827

   GPIO_PA5_SSI0TX : constant := 16#00001402#;  --  pin_map.h:49829

   GPIO_PA6_I2C1SCL : constant := 16#00001803#;  --  pin_map.h:49831

   GPIO_PA7_I2C1SDA : constant := 16#00001C03#;  --  pin_map.h:49833

   GPIO_PB0_U1RX : constant := 16#00010001#;  --  pin_map.h:49835
   GPIO_PB0_T2CCP0 : constant := 16#00010007#;  --  pin_map.h:49836

   GPIO_PB1_U1TX : constant := 16#00010401#;  --  pin_map.h:49838
   GPIO_PB1_T2CCP1 : constant := 16#00010407#;  --  pin_map.h:49839

   GPIO_PB2_I2C0SCL : constant := 16#00010803#;  --  pin_map.h:49841
   GPIO_PB2_T3CCP0 : constant := 16#00010807#;  --  pin_map.h:49842

   GPIO_PB3_I2C0SDA : constant := 16#00010C03#;  --  pin_map.h:49844
   GPIO_PB3_T3CCP1 : constant := 16#00010C07#;  --  pin_map.h:49845

   GPIO_PB4_SSI2CLK : constant := 16#00011002#;  --  pin_map.h:49847
   GPIO_PB4_CAN0RX : constant := 16#00011008#;  --  pin_map.h:49848
   GPIO_PB4_T1CCP0 : constant := 16#00011007#;  --  pin_map.h:49849

   GPIO_PB5_SSI2FSS : constant := 16#00011402#;  --  pin_map.h:49851
   GPIO_PB5_CAN0TX : constant := 16#00011408#;  --  pin_map.h:49852
   GPIO_PB5_T1CCP1 : constant := 16#00011407#;  --  pin_map.h:49853

   GPIO_PB6_SSI2RX : constant := 16#00011802#;  --  pin_map.h:49855
   GPIO_PB6_T0CCP0 : constant := 16#00011807#;  --  pin_map.h:49856

   GPIO_PB7_SSI2TX : constant := 16#00011C02#;  --  pin_map.h:49858
   GPIO_PB7_T0CCP1 : constant := 16#00011C07#;  --  pin_map.h:49859

   GPIO_PC0_TCK : constant := 16#00020001#;  --  pin_map.h:49861
   GPIO_PC0_SWCLK : constant := 16#00020001#;  --  pin_map.h:49862
   GPIO_PC0_T4CCP0 : constant := 16#00020007#;  --  pin_map.h:49863

   GPIO_PC1_TMS : constant := 16#00020401#;  --  pin_map.h:49865
   GPIO_PC1_SWDIO : constant := 16#00020401#;  --  pin_map.h:49866
   GPIO_PC1_T4CCP1 : constant := 16#00020407#;  --  pin_map.h:49867

   GPIO_PC2_TDI : constant := 16#00020801#;  --  pin_map.h:49869
   GPIO_PC2_T5CCP0 : constant := 16#00020807#;  --  pin_map.h:49870

   GPIO_PC3_SWO : constant := 16#00020C01#;  --  pin_map.h:49872
   GPIO_PC3_TDO : constant := 16#00020C01#;  --  pin_map.h:49873
   GPIO_PC3_T5CCP1 : constant := 16#00020C07#;  --  pin_map.h:49874

   GPIO_PC4_U4RX : constant := 16#00021001#;  --  pin_map.h:49876
   GPIO_PC4_U1RX : constant := 16#00021002#;  --  pin_map.h:49877
   GPIO_PC4_WT0CCP0 : constant := 16#00021007#;  --  pin_map.h:49878
   GPIO_PC4_U1RTS : constant := 16#00021008#;  --  pin_map.h:49879

   GPIO_PC5_U4TX : constant := 16#00021401#;  --  pin_map.h:49881
   GPIO_PC5_U1TX : constant := 16#00021402#;  --  pin_map.h:49882
   GPIO_PC5_WT0CCP1 : constant := 16#00021407#;  --  pin_map.h:49883
   GPIO_PC5_U1CTS : constant := 16#00021408#;  --  pin_map.h:49884

   GPIO_PC6_U3RX : constant := 16#00021801#;  --  pin_map.h:49886
   GPIO_PC6_WT1CCP0 : constant := 16#00021807#;  --  pin_map.h:49887

   GPIO_PC7_U3TX : constant := 16#00021C01#;  --  pin_map.h:49889
   GPIO_PC7_WT1CCP1 : constant := 16#00021C07#;  --  pin_map.h:49890

   GPIO_PD0_SSI3CLK : constant := 16#00030001#;  --  pin_map.h:49892
   GPIO_PD0_SSI1CLK : constant := 16#00030002#;  --  pin_map.h:49893
   GPIO_PD0_I2C3SCL : constant := 16#00030003#;  --  pin_map.h:49894
   GPIO_PD0_WT2CCP0 : constant := 16#00030007#;  --  pin_map.h:49895

   GPIO_PD1_SSI3FSS : constant := 16#00030401#;  --  pin_map.h:49897
   GPIO_PD1_SSI1FSS : constant := 16#00030402#;  --  pin_map.h:49898
   GPIO_PD1_I2C3SDA : constant := 16#00030403#;  --  pin_map.h:49899
   GPIO_PD1_WT2CCP1 : constant := 16#00030407#;  --  pin_map.h:49900

   GPIO_PD2_SSI3RX : constant := 16#00030801#;  --  pin_map.h:49902
   GPIO_PD2_SSI1RX : constant := 16#00030802#;  --  pin_map.h:49903
   GPIO_PD2_WT3CCP0 : constant := 16#00030807#;  --  pin_map.h:49904

   GPIO_PD3_SSI3TX : constant := 16#00030C01#;  --  pin_map.h:49906
   GPIO_PD3_SSI1TX : constant := 16#00030C02#;  --  pin_map.h:49907
   GPIO_PD3_WT3CCP1 : constant := 16#00030C07#;  --  pin_map.h:49908

   GPIO_PD4_U6RX : constant := 16#00031001#;  --  pin_map.h:49910
   GPIO_PD4_WT4CCP0 : constant := 16#00031007#;  --  pin_map.h:49911

   GPIO_PD5_U6TX : constant := 16#00031401#;  --  pin_map.h:49913
   GPIO_PD5_WT4CCP1 : constant := 16#00031407#;  --  pin_map.h:49914

   GPIO_PD6_U2RX : constant := 16#00031801#;  --  pin_map.h:49916
   GPIO_PD6_WT5CCP0 : constant := 16#00031807#;  --  pin_map.h:49917

   GPIO_PD7_U2TX : constant := 16#00031C01#;  --  pin_map.h:49919
   GPIO_PD7_WT5CCP1 : constant := 16#00031C07#;  --  pin_map.h:49920
   GPIO_PD7_NMI : constant := 16#00031C08#;  --  pin_map.h:49921

   GPIO_PE0_U7RX : constant := 16#00040001#;  --  pin_map.h:49923

   GPIO_PE1_U7TX : constant := 16#00040401#;  --  pin_map.h:49925

   GPIO_PE4_U5RX : constant := 16#00041001#;  --  pin_map.h:49927
   GPIO_PE4_I2C2SCL : constant := 16#00041003#;  --  pin_map.h:49928
   GPIO_PE4_CAN0RX : constant := 16#00041008#;  --  pin_map.h:49929

   GPIO_PE5_U5TX : constant := 16#00041401#;  --  pin_map.h:49931
   GPIO_PE5_I2C2SDA : constant := 16#00041403#;  --  pin_map.h:49932
   GPIO_PE5_CAN0TX : constant := 16#00041408#;  --  pin_map.h:49933

   GPIO_PF0_U1RTS : constant := 16#00050001#;  --  pin_map.h:49935
   GPIO_PF0_SSI1RX : constant := 16#00050002#;  --  pin_map.h:49936
   GPIO_PF0_CAN0RX : constant := 16#00050003#;  --  pin_map.h:49937
   GPIO_PF0_T0CCP0 : constant := 16#00050007#;  --  pin_map.h:49938
   GPIO_PF0_NMI : constant := 16#00050008#;  --  pin_map.h:49939
   GPIO_PF0_C0O : constant := 16#00050009#;  --  pin_map.h:49940
   GPIO_PF0_TRD2 : constant := 16#0005000E#;  --  pin_map.h:49941

   GPIO_PF1_U1CTS : constant := 16#00050401#;  --  pin_map.h:49943
   GPIO_PF1_SSI1TX : constant := 16#00050402#;  --  pin_map.h:49944
   GPIO_PF1_T0CCP1 : constant := 16#00050407#;  --  pin_map.h:49945
   GPIO_PF1_C1O : constant := 16#00050409#;  --  pin_map.h:49946
   GPIO_PF1_TRD1 : constant := 16#0005040E#;  --  pin_map.h:49947

   GPIO_PF2_T1CCP0 : constant := 16#00050807#;  --  pin_map.h:49949
   GPIO_PF2_SSI1CLK : constant := 16#00050802#;  --  pin_map.h:49950
   GPIO_PF2_TRD0 : constant := 16#0005080E#;  --  pin_map.h:49951

   GPIO_PF3_CAN0TX : constant := 16#00050C03#;  --  pin_map.h:49953
   GPIO_PF3_T1CCP1 : constant := 16#00050C07#;  --  pin_map.h:49954
   GPIO_PF3_SSI1FSS : constant := 16#00050C02#;  --  pin_map.h:49955
   GPIO_PF3_TRCLK : constant := 16#00050C0E#;  --  pin_map.h:49956

   GPIO_PF4_T2CCP0 : constant := 16#00051007#;  --  pin_map.h:49958
   --  unsupported macro: PinTypeADC(ulName) GPIOPinTypeADC(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeCAN(ulName) GPIOPinTypeCAN(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeComparator(ulName) GPIOPinTypeComparator(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeI2C(ulName) GPIOPinTypeI2C(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeEthernetLED(ulName) GPIOPinTypeEthernetLED(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypePWM(ulName) GPIOPinTypePWM(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeQEI(ulName) GPIOPinTypeQEI(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeSSI(ulName) GPIOPinTypeSSI(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeTimer(ulName) GPIOPinTypeTimer(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeUART(ulName) GPIOPinTypeUART(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PinTypeUSBDigital(ulName) GPIOPinTypeUSBDigital(ulName ##_PORT, ulName ##_PIN)
   --  unsupported macro: PeripheralEnable(ulName) SysCtlPeripheralEnable(ulName ##_PERIPH)

   --  skipped func __dummy__

end LM4F120.Pinmap;

