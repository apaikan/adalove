
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
    task body Srf04Task is
        Period : constant Time_Span := Milliseconds(300);
        Next_Time : Time := Clock;
        Data : ARM_String(1..80);
        Last : Unsigned_8;
        Value : Long_Integer := 0;
        -- reading pulse width 
        function PulseIn(Port : Integer; 
                         Pin : Integer; TimeoutMs : Long_Integer) return Long_Integer is
        Now : Long_Integer;       
        begin
            -- wait for any previous pulse to finish
            Now := HTime.GetTick; 
            while PinRead(Port, Pin) /= 0 loop 
                if HTime.GetSpanMsec(Now, HTime.GetTick) > TimeoutMs then
                    return -1;
                end if;
            end loop;
            
            -- wait for pulse to begin
            Now := HTime.GetTick; 
            while PinRead(Port, Pin) = 0 loop 
                if HTime.GetSpanMsec(Now, HTime.GetTick) > TimeoutMs then
                    return -1;
                end if;
            end loop;
            
            -- wait for pulse to finish
            Now := HTime.GetTick; 
            while PinRead(Port, Pin) /= 0 loop 
                if HTime.GetSpanMsec(Now, HTime.GetTick) > TimeoutMs then
                    return -1;
                end if;
            end loop;
            return HTime.GetSpanUsec(Now, HTime.GetTick); 
        end;

      begin
        HTime.Init;
        PinTypeOutput(PORTD, PIN0);     -- Trig pin
        PinTypeInput(PORTD, PIN1);      -- Echo pin
        loop
            Next_Time := Next_Time + Period;
            delay until Next_Time; 

            -- trriging the sensor
            PinWrite(PORTD, PIN0, 0);
            HTime.WaitUsec(10);
            PinWrite(PORTD, PIN0, PIN0);
            HTime.WaitUsec(10);
            PinWrite(PORTD, PIN0, 0);
            
            -- reading the pulse width
            Value := Long_Integer(Float(PulseIn(PORTD, PIN1, 500)) / 5.246);
            Stdio.LongToStr(Value, Data, Last); 
            Stdio.Put_Line(Data(1 .. Last));
        end loop;
    end Srf04Task;


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

