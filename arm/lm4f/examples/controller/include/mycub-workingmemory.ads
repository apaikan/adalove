with System;

package MyCub.WorkingMemory is
   
    function GetBatteryVolt return Integer; 
    function GetDistance return Integer; 
    function GetHeading return Integer;

    protected BatteryRaw is
        procedure Put (Data : Integer);
        procedure Get (Data : out Integer);
    private
        Container : Integer;
    end BatteryRaw;

    protected DistanceRaw is
        procedure Put (Data : Integer);
        procedure Get (Data : out Integer);
    private
        Container : Integer;
    end DistanceRaw;

    protected HeadingRaw is
        procedure Put (Data : Float);
        procedure Get (Data : out Float);
    private
        Container : Float;
    end HeadingRaw;

    -- tasks
    task BatteryStatusUpdater is
        pragma Priority (BAT_TASK_PRIO);
        pragma Storage_Size (2*1024);
    end BatteryStatusUpdater;

    task HeadingStatusUpdater is
        pragma Priority (CMPS_TASK_PRIO);
        pragma Storage_Size (2*1024);
    end HeadingStatusUpdater;

    task SonarStatusUpdater is
        pragma Priority (SONAR_TASK_PRIO);
        pragma Storage_Size (2*1024);
    end SonarStatusUpdater;

end MyCub.WorkingMemory;


