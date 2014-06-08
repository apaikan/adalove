
with Ada.Real_Time;     use Ada.Real_Time;
with Ada.Text_IO;       use Ada.Text_IO;

--with Interfaces.C;      use Interfaces.C;

package body MyTasks is
    --
    -- Task 1 body
    --
    task body Task1 is
        Period : constant Time_Span := To_Time_Span (0.5);
        Next_Time : Time := Clock;
        Toggle : Boolean := False;
    begin
        loop
            Put_Line("Task1");
            -- wait for the next period
            Next_Time := Next_Time + Period;
            delay until Next_Time;
        end loop;
    end Task1;

    --
    -- Task 2 body
    --
    task body Task2 is
        Period : constant Time_Span := To_Time_Span (1.0);
        Next_Time : Time := Clock;
        Toggle : Boolean := False;
    begin
        loop
            Put_Line("Task2");
            -- wait for the next period
            Next_Time := Next_Time + Period;
            delay until Next_Time;
        end loop;
    end Task2;

end MyTasks;

