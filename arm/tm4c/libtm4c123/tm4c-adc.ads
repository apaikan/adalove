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

with Interfaces;    use Interfaces;
with Interfaces.C;  use Interfaces.C;
with Ada.Unchecked_Conversion;

package TM4C.ADC is

   ADC0_BASE : constant := 16#40038000#;  --  hw_memmap.h:97
   ADC1_BASE : constant := 16#40039000#;  --  hw_memmap.h:98
   ADC_TRIGGER_PROCESSOR : constant := 16#00000000#;  --  adc.h:65
   ADC_TRIGGER_NEVER : constant  := 16#0000000E#;  --  adc.h:75
   ADC_TRIGGER_ALWAYS : constant := 16#0000000F#;  --  adc.h:76
   ADC_CTL_TS : constant  := 16#00000080#;  --  adc.h:84
   ADC_CTL_IE : constant  := 16#00000040#;  --  adc.h:85
   ADC_CTL_END : constant := 16#00000020#;  --  adc.h:86
 
   procedure SequenceConfigure
     (Base : Integer;
      SequenceNum : Integer;
      Trigger : Integer;
      Priority : Integer);  -- adc.h:241
   pragma Import (C, SequenceConfigure, "ADCSequenceConfigure");

   procedure SequenceStepConfigure
     (Base : Integer;
      SequenceNum : Integer;
      Step : Integer;
      Config : Integer);  -- adc.h:243
   pragma Import (C, SequenceStepConfigure, "ADCSequenceStepConfigure");

   procedure SequenceEnable (Base : Integer; SequenceNum : Integer);  -- adc.h:239
   pragma Import (C, SequenceEnable, "ADCSequenceEnable");

   procedure SequenceDisable (Base : Integer; SequenceNum : Integer);  -- adc.h:240
   pragma Import (C, SequenceDisable, "ADCSequenceDisable");

   procedure IntClear (Base : Integer; SequenceNum : Integer);  -- adc.h:238
   pragma Import (C, IntClear, "ADCIntClear");

   procedure ProcessorTrigger (Base : Integer; SequenceNum : Integer);  -- adc.h:256
   pragma Import (C, ProcessorTrigger, "ADCProcessorTrigger");

   function IntStatus
     (Base : Integer;
      SequenceNum : Integer;
      bMasked : Integer) return Integer;  -- adc.h:236
   pragma Import (C, IntStatus, "ADCIntStatus");

   function SequenceDataGet
     (Base : Integer;
      SequenceNum : Integer;
      pBuffer : access Long_Integer) return Long_Integer;  -- adc.h:254
   pragma Import (C, SequenceDataGet, "ADCSequenceDataGet");


end TM4C.ADC;





