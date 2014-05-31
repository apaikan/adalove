pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Text_IO;           use Ada.Text_IO;
with MyTasks; use MyTasks;

procedure Main is
   pragma Priority (5);
begin        
    loop
        null;
    end loop;

end Main;

