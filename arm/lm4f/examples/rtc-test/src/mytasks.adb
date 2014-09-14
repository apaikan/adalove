
with Ada.Real_Time;     use Ada.Real_Time;
with TM4C.Gpio;         use TM4C.Gpio;
with TM4C.Uart;
with ARM.Uart;
with ARM.Strings;       use ARM.Strings;
with TM4C.HTimer;

with Interfaces;    use Interfaces;
with Interfaces.C;  use Interfaces.C;
with ARM.Strings;   use ARM.Strings;
with ARM.Strings.Edit; use ARM.Strings.Edit;
package body MyTasks is

    package Stdio is new ARM.Uart(Port => TM4C.Uart.UART0);
    package HTime is new TM4C.HTimer;

    --
    -- RTC task
    --
    task body RTCTask is
        Period : constant Time_Span := Milliseconds(100);
        Next_Time : Time := Clock;
        Data : ARM_String(1..80);
        Last : Unsigned_8;
        Value : Long_Integer := 0;
      begin
        Stdio.Put_Line("Timer counter example");
        HTime.Init;
        loop
            Value := HTime.GetTick; 
            Next_Time := Next_Time + Period;
            delay until Next_Time; 
            --Value := HTime.GetSpanUsec(Value, HTime.GetTick);
            Stdio.LongToStr(Value, Data, Last); 
            Stdio.Put_Line(Data(1 .. Last));
        end loop;
    end RTCTask;


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

