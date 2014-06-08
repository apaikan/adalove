
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;

with LM4F120.Sysctl;    use LM4F120.Sysctl;
with LM4F120.Gpio;      use LM4F120.Gpio;
with LM4F120.Memmap;    use LM4F120.Memmap;

package body MyTasks is
    --
    -- Red Task body
    --
    task body RedTask is
        Period : constant Time_Span := To_Time_Span (1.0);
        Next_Time : Time := Clock;
        Toggle : Boolean := False;
    begin
        loop
            if Toggle = False then
                Toggle :=  True;
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, GPIO_PIN_1); 
            else
                Toggle := False;
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, 0);
            end if;

            -- wait for the next period
            Next_Time := Next_Time + Period;
            delay until Next_Time;
        end loop;
    end RedTask;

    --
    -- Green Task body
    --
--    task body GreenTask is
--        Period : constant Time_Span := To_Time_Span (0.5);
--        Next_Time : Time := Clock;
--        Toggle : Boolean := False;
--    begin
--        loop
--            if Toggle = False then
--                Toggle :=  True;
--                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_3, GPIO_PIN_3); 
--            else
--                Toggle := False;
--                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_3, 0);
--            end if;
--
--            -- wait for the next period
--            Next_Time := Next_Time + Period;
--            delay until Next_Time;
--        end loop;
--    end GreenTask;

end MyTasks;

