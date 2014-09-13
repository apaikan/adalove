
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with TM4C.Gpio;         use TM4C.Gpio;
with TM4C.Uart;
with ARM.Uart;
with ARM.Strings;       use ARM.Strings;

with Interfaces;    use Interfaces;
with Interfaces.C;  use Interfaces.C;
with ARM.Strings;   use ARM.Strings;

package body MyTasks is

    package Stdio is new ARM.Uart(Port => TM4C.Uart.UART0);

    --
    -- Uart task
    --
    task body UartTask is
        Data : ARM_String(1..80);
        Last : Unsigned_8;
      begin
        Stdio.Put_Line("Insert the message <enter>");
        loop
            Stdio.Get_Line(Data, Last, Echo => True);
            -- Stdio.Put_Line(Data(1 .. Last));
            if Data(1..Last) = "Hello" then 
                Stdio.Put_Line("Hey you! :)");
            else
                Stdio.Put("Got it: ");
                Stdio.Put_Line(Data(1..Last));
            end if;
        end loop;

    end UartTask;

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

