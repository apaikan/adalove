
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with Interfaces;        use Interfaces;
with LM4F.Gpio;         use LM4F.Gpio;
with LM4F.Uart;         use LM4F.Uart;

package body MyTasks is

    --
    -- Monitor object
    -- 
    protected body Monitor is
        procedure UartIntHandler is
            Flag   : Integer;
            Status : Boolean; 
        begin
            Flag := IntStatus(UART0, TRUE);
            IntClear(UART0, Flag);
            --if Flag = (INT_RX + INT_RT) then
            if Flag = INT_RX or Flag = INT_RT then
                while CharsAvail(UART0) = TRUE loop
                    Container := CharGetNonBlocking(UART0);
                    Status := CharPutNonBlocking(UART0, Container);
                    Received := True;
                end loop;    
            end if;    
        end UartIntHandler;

        entry Get(Data: out Unsigned_8) when Received is
        begin
            Data := Container;
            Received := False;
        end Get;
    end Monitor;

    --
    -- Uart task
    --
    task body UartTask is
        Data : Unsigned_8;      
    begin
        PinTypeOutput(PORTF, PIN2);
        loop
            Monitor.Get(Data); 
            -- handle interrupt here
            if Data = 97 then 
                PinWrite(PORTF, PIN2, PIN2);
            else
                PinWrite(PORTF, PIN2, 0);
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

