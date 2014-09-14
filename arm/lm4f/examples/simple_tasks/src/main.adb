pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Real_Time;     use Ada.Real_Time;
with MyTasks;           use MyTasks;

--pragma Storage_Size (100);

procedure Main is
    Period : constant Time_Span := To_Time_Span (1.0);
    Next_Time : Time := Clock;
begin    
    loop
        Next_Time := Next_Time + Period;
        delay until Next_Time;
    end loop;
end Main;


