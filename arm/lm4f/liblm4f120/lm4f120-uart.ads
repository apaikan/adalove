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

package LM4F120.Uart is

   UART_INT_9BIT : constant := 16#1000#;  --  uart.h:62
   UART_INT_OE : constant := 16#400#;  --  uart.h:63
   UART_INT_BE : constant := 16#200#;  --  uart.h:64
   UART_INT_PE : constant := 16#100#;  --  uart.h:65
   UART_INT_FE : constant := 16#080#;  --  uart.h:66
   UART_INT_RT : constant := 16#040#;  --  uart.h:67
   UART_INT_TX : constant := 16#020#;  --  uart.h:68
   UART_INT_RX : constant := 16#010#;  --  uart.h:69
   UART_INT_DSR : constant := 16#008#;  --  uart.h:70
   UART_INT_DCD : constant := 16#004#;  --  uart.h:71
   UART_INT_CTS : constant := 16#002#;  --  uart.h:72
   UART_INT_RI : constant := 16#001#;  --  uart.h:73

   UART_CONFIG_WLEN_MASK : constant := 16#00000060#;  --  uart.h:84
   UART_CONFIG_WLEN_8 : constant := 16#00000060#;  --  uart.h:85
   UART_CONFIG_WLEN_7 : constant := 16#00000040#;  --  uart.h:86
   UART_CONFIG_WLEN_6 : constant := 16#00000020#;  --  uart.h:87
   UART_CONFIG_WLEN_5 : constant := 16#00000000#;  --  uart.h:88
   UART_CONFIG_STOP_MASK : constant := 16#00000008#;  --  uart.h:89
   UART_CONFIG_STOP_ONE : constant := 16#00000000#;  --  uart.h:90
   UART_CONFIG_STOP_TWO : constant := 16#00000008#;  --  uart.h:91
   UART_CONFIG_PAR_MASK : constant := 16#00000086#;  --  uart.h:92
   UART_CONFIG_PAR_NONE : constant := 16#00000000#;  --  uart.h:93
   UART_CONFIG_PAR_EVEN : constant := 16#00000006#;  --  uart.h:94
   UART_CONFIG_PAR_ODD : constant := 16#00000002#;  --  uart.h:95
   UART_CONFIG_PAR_ONE : constant := 16#00000082#;  --  uart.h:96
   UART_CONFIG_PAR_ZERO : constant := 16#00000086#;  --  uart.h:97

   UART_FIFO_TX1_8 : constant := 16#00000000#;  --  uart.h:105
   UART_FIFO_TX2_8 : constant := 16#00000001#;  --  uart.h:106
   UART_FIFO_TX4_8 : constant := 16#00000002#;  --  uart.h:107
   UART_FIFO_TX6_8 : constant := 16#00000003#;  --  uart.h:108
   UART_FIFO_TX7_8 : constant := 16#00000004#;  --  uart.h:109

   UART_FIFO_RX1_8 : constant := 16#00000000#;  --  uart.h:117
   UART_FIFO_RX2_8 : constant := 16#00000008#;  --  uart.h:118
   UART_FIFO_RX4_8 : constant := 16#00000010#;  --  uart.h:119
   UART_FIFO_RX6_8 : constant := 16#00000018#;  --  uart.h:120
   UART_FIFO_RX7_8 : constant := 16#00000020#;  --  uart.h:121

   UART_DMA_ERR_RXSTOP : constant := 16#00000004#;  --  uart.h:128
   UART_DMA_TX : constant := 16#00000002#;  --  uart.h:129
   UART_DMA_RX : constant := 16#00000001#;  --  uart.h:130

   UART_RXERROR_OVERRUN : constant := 16#00000008#;  --  uart.h:137
   UART_RXERROR_BREAK : constant := 16#00000004#;  --  uart.h:138
   UART_RXERROR_PARITY : constant := 16#00000002#;  --  uart.h:139
   UART_RXERROR_FRAMING : constant := 16#00000001#;  --  uart.h:140

   UART_OUTPUT_RTS : constant := 16#00000800#;  --  uart.h:148
   UART_OUTPUT_DTR : constant := 16#00000400#;  --  uart.h:149

   UART_INPUT_RI : constant := 16#00000100#;  --  uart.h:156
   UART_INPUT_DCD : constant := 16#00000004#;  --  uart.h:157
   UART_INPUT_DSR : constant := 16#00000002#;  --  uart.h:158
   UART_INPUT_CTS : constant := 16#00000001#;  --  uart.h:159

   UART_FLOWCONTROL_TX : constant := 16#00008000#;  --  uart.h:167
   UART_FLOWCONTROL_RX : constant := 16#00004000#;  --  uart.h:168
   UART_FLOWCONTROL_NONE : constant := 16#00000000#;  --  uart.h:169

   UART_TXINT_MODE_FIFO : constant := 16#00000000#;  --  uart.h:177
   UART_TXINT_MODE_EOT : constant := 16#00000010#;  --  uart.h:178

   UART_CLOCK_SYSTEM : constant := 16#00000000#;  --  uart.h:186
   UART_CLOCK_PIOSC : constant := 16#00000005#;  --  uart.h:187

   subtype tBoolean is unsigned;  -- uart.h:43

   procedure UARTParityModeSet (ulBase : unsigned_long; ulParity : unsigned_long);  -- uart.h:194
   pragma Import (C, UARTParityModeSet, "UARTParityModeSet");

   function UARTParityModeGet (ulBase : unsigned_long) return unsigned_long;  -- uart.h:195
   pragma Import (C, UARTParityModeGet, "UARTParityModeGet");

   procedure UARTFIFOLevelSet
     (ulBase : unsigned_long;
      ulTxLevel : unsigned_long;
      ulRxLevel : unsigned_long);  -- uart.h:196
   pragma Import (C, UARTFIFOLevelSet, "UARTFIFOLevelSet");

   procedure UARTFIFOLevelGet
     (ulBase : unsigned_long;
      pulTxLevel : access unsigned_long;
      pulRxLevel : access unsigned_long);  -- uart.h:198
   pragma Import (C, UARTFIFOLevelGet, "UARTFIFOLevelGet");

   procedure UARTConfigSetExpClk
     (ulBase : unsigned_long;
      ulUARTClk : unsigned_long;
      ulBaud : unsigned_long;
      ulConfig : unsigned_long);  -- uart.h:200
   pragma Import (C, UARTConfigSetExpClk, "UARTConfigSetExpClk");

   procedure UARTConfigGetExpClk
     (ulBase : unsigned_long;
      ulUARTClk : unsigned_long;
      pulBaud : access unsigned_long;
      pulConfig : access unsigned_long);  -- uart.h:202
   pragma Import (C, UARTConfigGetExpClk, "UARTConfigGetExpClk");

   procedure UARTEnable (ulBase : unsigned_long);  -- uart.h:205
   pragma Import (C, UARTEnable, "UARTEnable");

   procedure UARTDisable (ulBase : unsigned_long);  -- uart.h:206
   pragma Import (C, UARTDisable, "UARTDisable");

   procedure UARTFIFOEnable (ulBase : unsigned_long);  -- uart.h:207
   pragma Import (C, UARTFIFOEnable, "UARTFIFOEnable");

   procedure UARTFIFODisable (ulBase : unsigned_long);  -- uart.h:208
   pragma Import (C, UARTFIFODisable, "UARTFIFODisable");

   procedure UARTEnableSIR (ulBase : unsigned_long; bLowPower : tBoolean);  -- uart.h:209
   pragma Import (C, UARTEnableSIR, "UARTEnableSIR");

   procedure UARTDisableSIR (ulBase : unsigned_long);  -- uart.h:210
   pragma Import (C, UARTDisableSIR, "UARTDisableSIR");

   function UARTCharsAvail (ulBase : unsigned_long) return tBoolean;  -- uart.h:211
   pragma Import (C, UARTCharsAvail, "UARTCharsAvail");

   function UARTSpaceAvail (ulBase : unsigned_long) return tBoolean;  -- uart.h:212
   pragma Import (C, UARTSpaceAvail, "UARTSpaceAvail");

   function UARTCharGetNonBlocking (ulBase : unsigned_long) return long;  -- uart.h:213
   pragma Import (C, UARTCharGetNonBlocking, "UARTCharGetNonBlocking");

   function UARTCharGet (ulBase : unsigned_long) return long;  -- uart.h:214
   pragma Import (C, UARTCharGet, "UARTCharGet");

   function UARTCharPutNonBlocking (ulBase : unsigned_long; ucData : unsigned_char) return tBoolean;  -- uart.h:215
   pragma Import (C, UARTCharPutNonBlocking, "UARTCharPutNonBlocking");

   procedure UARTCharPut (ulBase : unsigned_long; ucData : unsigned_char);  -- uart.h:217
   pragma Import (C, UARTCharPut, "UARTCharPut");

   procedure UARTBreakCtl (ulBase : unsigned_long; bBreakState : tBoolean);  -- uart.h:218
   pragma Import (C, UARTBreakCtl, "UARTBreakCtl");

   function UARTBusy (ulBase : unsigned_long) return tBoolean;  -- uart.h:219
   pragma Import (C, UARTBusy, "UARTBusy");

   procedure UARTIntRegister (ulBase : unsigned_long; pfnHandler : access procedure);  -- uart.h:220
   pragma Import (C, UARTIntRegister, "UARTIntRegister");

   procedure UARTIntUnregister (ulBase : unsigned_long);  -- uart.h:221
   pragma Import (C, UARTIntUnregister, "UARTIntUnregister");

   procedure UARTIntEnable (ulBase : unsigned_long; ulIntFlags : unsigned_long);  -- uart.h:222
   pragma Import (C, UARTIntEnable, "UARTIntEnable");

   procedure UARTIntDisable (ulBase : unsigned_long; ulIntFlags : unsigned_long);  -- uart.h:223
   pragma Import (C, UARTIntDisable, "UARTIntDisable");

   function UARTIntStatus (ulBase : unsigned_long; bMasked : tBoolean) return unsigned_long;  -- uart.h:224
   pragma Import (C, UARTIntStatus, "UARTIntStatus");

   procedure UARTIntClear (ulBase : unsigned_long; ulIntFlags : unsigned_long);  -- uart.h:225
   pragma Import (C, UARTIntClear, "UARTIntClear");

   procedure UARTDMAEnable (ulBase : unsigned_long; ulDMAFlags : unsigned_long);  -- uart.h:226
   pragma Import (C, UARTDMAEnable, "UARTDMAEnable");

   procedure UARTDMADisable (ulBase : unsigned_long; ulDMAFlags : unsigned_long);  -- uart.h:227
   pragma Import (C, UARTDMADisable, "UARTDMADisable");

   function UARTRxErrorGet (ulBase : unsigned_long) return unsigned_long;  -- uart.h:228
   pragma Import (C, UARTRxErrorGet, "UARTRxErrorGet");

   procedure UARTRxErrorClear (ulBase : unsigned_long);  -- uart.h:229
   pragma Import (C, UARTRxErrorClear, "UARTRxErrorClear");

   procedure UARTSmartCardEnable (ulBase : unsigned_long);  -- uart.h:230
   pragma Import (C, UARTSmartCardEnable, "UARTSmartCardEnable");

   procedure UARTSmartCardDisable (ulBase : unsigned_long);  -- uart.h:231
   pragma Import (C, UARTSmartCardDisable, "UARTSmartCardDisable");

   procedure UARTModemControlSet (ulBase : unsigned_long; ulControl : unsigned_long);  -- uart.h:232
   pragma Import (C, UARTModemControlSet, "UARTModemControlSet");

   procedure UARTModemControlClear (ulBase : unsigned_long; ulControl : unsigned_long);  -- uart.h:234
   pragma Import (C, UARTModemControlClear, "UARTModemControlClear");

   function UARTModemControlGet (ulBase : unsigned_long) return unsigned_long;  -- uart.h:236
   pragma Import (C, UARTModemControlGet, "UARTModemControlGet");

   function UARTModemStatusGet (ulBase : unsigned_long) return unsigned_long;  -- uart.h:237
   pragma Import (C, UARTModemStatusGet, "UARTModemStatusGet");

   procedure UARTFlowControlSet (ulBase : unsigned_long; ulMode : unsigned_long);  -- uart.h:238
   pragma Import (C, UARTFlowControlSet, "UARTFlowControlSet");

   function UARTFlowControlGet (ulBase : unsigned_long) return unsigned_long;  -- uart.h:239
   pragma Import (C, UARTFlowControlGet, "UARTFlowControlGet");

   procedure UARTTxIntModeSet (ulBase : unsigned_long; ulMode : unsigned_long);  -- uart.h:240
   pragma Import (C, UARTTxIntModeSet, "UARTTxIntModeSet");

   function UARTTxIntModeGet (ulBase : unsigned_long) return unsigned_long;  -- uart.h:241
   pragma Import (C, UARTTxIntModeGet, "UARTTxIntModeGet");

   procedure UARTClockSourceSet (ulBase : unsigned_long; ulSource : unsigned_long);  -- uart.h:242
   pragma Import (C, UARTClockSourceSet, "UARTClockSourceSet");

   function UARTClockSourceGet (ulBase : unsigned_long) return unsigned_long;  -- uart.h:243
   pragma Import (C, UARTClockSourceGet, "UARTClockSourceGet");

   procedure UART9BitEnable (ulBase : unsigned_long);  -- uart.h:244
   pragma Import (C, UART9BitEnable, "UART9BitEnable");

   procedure UART9BitDisable (ulBase : unsigned_long);  -- uart.h:245
   pragma Import (C, UART9BitDisable, "UART9BitDisable");

   procedure UART9BitAddrSet
     (ulBase : unsigned_long;
      ucAddr : unsigned_char;
      ucMask : unsigned_char);  -- uart.h:246
   pragma Import (C, UART9BitAddrSet, "UART9BitAddrSet");

   procedure UART9BitAddrSend (ulBase : unsigned_long; ucAddr : unsigned_char);  -- uart.h:248
   pragma Import (C, UART9BitAddrSend, "UART9BitAddrSend");

end LM4F120.Uart;

