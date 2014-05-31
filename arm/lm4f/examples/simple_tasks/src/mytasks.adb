
with Ada.Real_Time;     use Ada.Real_Time;

package body MyTasks is
    Period : constant Time_Span := To_Time_Span (0.5);
    task body SimpleTask is
        Next_Time : Time := Clock;
    begin    
        loop
            Next_Time := Next_Time + Period;
            delay until Next_Time;
        end loop;
    end SimpleTask;

end MyTasks;

