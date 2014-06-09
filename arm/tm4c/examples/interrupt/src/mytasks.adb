
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with TM4C.Gpio;         use TM4C.Gpio;
with TM4C.Uart;         use TM4C.Uart;

package body MyTasks is

    --
    -- Monitor object
    -- 
    protected body Monitor is
        procedure UartIntHandler is
            Flag : Integer;
        begin
            Flag := IntStatus(UART0, TRUE);
            IntClear(UART0, Flag);
            --if Flag = (INT_RX + INT_RT) then
            if Flag = INT_RX or Flag = INT_RT then
                while CharsAvail(UART0) = TRUE loop
                    Container := CharGetNonBlocking(UART0);
                    Received := True;
                end loop;    
            end if;    
        end UartIntHandler;

        entry Get(Data: out Integer) when Received is
        begin
            Data := Container;
            Received := False;
        end Get;
    end Monitor;

    --
    -- Uart task
    --
    task body UartTask is
        Data : Integer;      
    begin
        PinTypeOutput(PORTF, PIN1);
        loop
            Monitor.Get(Data); 
            -- handle interrupt here
            CharPut(UART0, Data);
            if Data = 97 then 
                PinWrite(PORTF, PIN1, PIN1);
            else
                PinWrite(PORTF, PIN1, 0);
            end if;
        end loop;
    end UartTask;

end MyTasks;

