
with Ada.Real_Time;     use Ada.Real_Time;
with TM4C.Gpio;         use TM4C.Gpio;
with TM4C.Uart;
with TM4C.ADC;          use TM4C.ADC;
with ARM.Uart;
with ARM.Strings;       use ARM.Strings;

with Interfaces;    use Interfaces;
with Interfaces.C;  use Interfaces.C;
with ARM.Strings;   use ARM.Strings;
with ARM.Strings.Edit; use ARM.Strings.Edit;
package body MyTasks is

    package Stdio is new ARM.Uart(Port => TM4C.Uart.UART0);

    --
    -- Temprature task
    --
    task body TempratureTask is
        Period : constant Time_Span := Milliseconds(1000);
        Next_Time : Time := Clock;
        Data : ARM_String(1..80);
        Last : Unsigned_8;
        Value : aliased Integer := 0;
        Ret : Integer := 0;
      begin
        -- configure adc
        SequenceConfigure(ADC0_BASE, 3, ADC_TRIGGER_PROCESSOR, 0);
       --SequenceStepConfigure(ADC0_BASE, 3, 0, ADC_CTL_TS + ADC_CTL_IE + ADC_CTL_END);
        SequenceConfigure(ADC0_BASE, 3, 0, ADC_CTL_CH6 + ADC_CTL_IE + ADC_CTL_END);
        SequenceEnable(ADC0_BASE, 3);
        IntClear(ADC0_BASE, 3);
        loop
            Next_Time := Next_Time + Period;
            delay until Next_Time;

            -- reading adc value
            ProcessorTrigger(ADC0_BASE, 3);
            while IntStatus(ADC0_BASE, 3, 0) /= 0 loop 
                null;
            end loop;
            IntClear(ADC0_BASE, 3);
            Ret := SequenceDataGet(ADC0_BASE, 3, Value'Access);
            --Value := ((1475 * 1023) - (2250 * Value)) / 10230;
            --Value := (1475 - ((2475 * Value)) / 4096)/10;           
            -- printing Temprature
            Stdio.IntToStr(Value, Data, Last); 
            Stdio.Put_Line(Data(1 .. Last));
        end loop;
    end TempratureTask;


    --
    -- Blinky Task body
    --
    task body BlinkyTask is        
        Period : constant Time_Span := Seconds(3);
        Next_Time : Time := Clock;
    begin
        PinTypeOutput(PORTF, PIN3);
        loop
            -- wait for the next period
            Next_Time := Next_Time + Period - Milliseconds(50);
            delay until Next_Time;            
            PinWrite(PORTF, PIN3, PIN3);
            -- wait for some ms then turn of leds
            Next_Time := Next_Time + Milliseconds(50);
            delay until Next_Time;            
            PinWrite(PORTF, PIN3, 0);
      end loop;
  end BlinkyTask;

end MyTasks;

