with System;

package MyTasks is

    -- RTC task
    task RTCTask is
        pragma Priority (130);
        pragma Storage_Size (2*1024);
    end RTCTask;

    -- blinky
    task BlinkyTask is
         pragma Priority (120);
         pragma Storage_Size (2*1024);
    end BlinkyTask;

end MyTasks;


