pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Real_Time;     use Ada.Real_Time;
--with Interfaces.C;    use Interfaces.C;
with MyTasks;           use MyTasks;

procedure Main is
   pragma Priority (0);
begin        
    loop
        null;
    end loop;
end Main;

