
with Ada.Real_Time;     use Ada.Real_Time;
with Ada.Text_IO;           use Ada.Text_IO;

package body MyTasks is
    T0 : constant Time := Clock;    
    Task1_Period : constant Time_Span := To_Time_Span (0.5);
    task body SimpleTask is
       Next_Time : Time := T0;
    begin    
        loop
            Next_Time := Next_Time + Task1_Period;
            delay until Next_Time;
           Put_Line("MyTasks...");
        end loop;
    end SimpleTask;

end MyTasks;

