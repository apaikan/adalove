pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with MyTasks; use MyTasks;

procedure Main is
   pragma Priority (0);
begin        
    loop
        null;
    end loop;
end Main;

