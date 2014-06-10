with System;

package MyTasks is

    -- uart task
    task UartTask is
        pragma Priority (130);
        pragma Storage_Size (2*1024);
    end UartTask;

    -- blinky
    task BlinkyTask is
         pragma Priority (120);
         pragma Storage_Size (2*1024);
    end BlinkyTask;

end MyTasks;


