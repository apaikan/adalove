
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with TM4C.Gpio;         use TM4C.Gpio;

package body MyTasks is

    --
    -- Monitor object
    -- 
    protected body Monitor is
        procedure UartIntHandler is
        begin
            Signaled := True;
        end ;

        entry Wait when Signaled is
        begin
            Signaled := False;
        end Wait;
    end Monitor;

    --
    -- Uart task
    --
    task body UartTask is

    begin
        PinTypeOutput(PORTF, PIN1);
        loop
            Monitor.Wait;
            PinWrite(PORTF, PIN1, PIN1);
            -- handle interrupt here
            null;
        end loop;
    end UartTask;

end MyTasks;

