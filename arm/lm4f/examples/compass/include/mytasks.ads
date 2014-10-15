with System;

package MyTasks is

    -- Compass task
    task CompassTask is
        pragma Priority (130);
        pragma Storage_Size (2*1024);
    end CompassTask;

    -- blinky
    task BlinkyTask is
         pragma Priority (120);
         pragma Storage_Size (2*1024);
    end BlinkyTask;

end MyTasks;


