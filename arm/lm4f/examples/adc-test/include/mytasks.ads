with System;

package MyTasks is

    -- Temprature task
    task TempratureTask is
        pragma Priority (130);
        pragma Storage_Size (2*1024);
    end TempratureTask;

    -- blinky
    task BlinkyTask is
         pragma Priority (120);
         pragma Storage_Size (2*1024);
    end BlinkyTask;

end MyTasks;


