
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with TM4C.Gpio;         use TM4C.Gpio;
with TM4C.Uart;
with ARM.Uart;
with ARM.Strings;       use ARM.Strings;

package body MyTasks is

    --
    -- Uart task
    --
    task body UartTask is
        Period : constant Time_Span := Seconds(1);
        Next_Time : Time := Clock;
        --Msg : constant ARM_String := "Hello";
        package Stdio is new ARM.Uart(Port => TM4C.Uart.UART0);
    begin
        PinTypeOutput(PORTF, PIN1+PIN2+PIN3);
        loop
            -- wait for the next period
            Next_Time := Next_Time + Period;            
            delay until Next_Time;          
            Stdio.Put_Line("Hello from Ada :)");
      end loop;

    end UartTask;

    --
    -- Blinky Task body
    --
    task body BlinkyTask is        
        Period : constant Time_Span := Seconds(3);
        Next_Time : Time := Clock;
    begin
        PinTypeOutput(PORTF, PIN1+PIN2+PIN3);
        loop
            -- wait for the next period
            Next_Time := Next_Time + Period - Milliseconds(50);
            delay until Next_Time;            
            PinWrite(PORTF, PIN1, PIN1);
            PinWrite(PORTF, PIN2, PIN2);
            PinWrite(PORTF, PIN3, PIN3);
            -- wait for some ms then turn of leds
            Next_Time := Next_Time + Milliseconds(50);
            delay until Next_Time;            
            PinWrite(PORTF, PIN1, 0);
            PinWrite(PORTF, PIN2, 0);
            PinWrite(PORTF, PIN3, 0); 
      end loop;
  end BlinkyTask;

end MyTasks;

