with System;

package MyTasks is

    -- RTC task
    task Srf04Task is
        pragma Priority (130);
        pragma Storage_Size (2*1024);
    end Srf04Task;

    -- blinky
    task BlinkyTask is
         pragma Priority (120);
         pragma Storage_Size (2*1024);
    end BlinkyTask;

end MyTasks;


