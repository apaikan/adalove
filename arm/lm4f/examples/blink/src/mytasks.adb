
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with LM4F.Gpio;         use LM4F.Gpio;

package body MyTasks is
    --
    -- Red Task body
    --
    task body RedTask is
        Period : constant Time_Span := To_Time_Span (0.5);
        Next_Time : Time := Clock;
        Toggle : Boolean := False;
    begin
        PinTypeOutput(PORTF, PIN1);
        loop
            if Toggle = False then
                Toggle :=  True;
                PinWrite(PORTF, PIN1, PIN1);
            else
                Toggle := False;
                PinWrite(PORTF, PIN1, 0);
            end if;

            -- wait for the next period
            Next_Time := Next_Time + Period;
            delay until Next_Time;
        end loop;
    end RedTask;

    --
    -- Green Task body
    --
    task body GreenTask is
        Period : constant Time_Span := To_Time_Span (1.0);
        Next_Time : Time := Clock;
        Toggle : Boolean := False;
    begin
        PinTypeOutput(PORTF, PIN3);
        loop
            if Toggle = False then
                Toggle :=  True;
                PinWrite(PORTF, PIN3, PIN3);
            else
                Toggle := False;
                PinWrite(PORTF, PIN3, 0);
            end if;

          -- wait for the next period
          Next_Time := Next_Time + Period;
          delay until Next_Time;
      end loop;
  end GreenTask;

end MyTasks;

