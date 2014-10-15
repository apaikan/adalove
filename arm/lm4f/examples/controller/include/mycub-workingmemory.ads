with System;
with Interfaces;    use Interfaces;

package MyCub.WorkingMemory is
  
    type Orientation is record
        X : Float;
        Y : Float;
        Z : Float;
    end record;

    function GetBatteryVolt return Integer; 
    function GetDistance return Integer; 
    function GetOrientation return Orientation;

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

    protected OrientationRaw is
        procedure Put (Data : Orientation);
        procedure Get (Data : out Orientation);
    private
        Container : Orientation;
    end OrientationRaw;

    -- tasks
    task BatteryStatusUpdater is
        pragma Priority (BAT_TASK_PRIO);
        pragma Storage_Size (2*1024);
    end BatteryStatusUpdater;

    task OrientationStatusUpdater is
        pragma Priority (CMPS_TASK_PRIO);
        pragma Storage_Size (2*1024);
    end OrientationStatusUpdater;

    task SonarStatusUpdater is
        pragma Priority (SONAR_TASK_PRIO);
        pragma Storage_Size (2*1024);
    end SonarStatusUpdater;

private
    function Combine(lo : Unsigned_8; hi : Unsigned_8) return Integer;
    pragma Import (C, Combine, "combine");

end MyCub.WorkingMemory;


