with System;

package MyCubWorkingMemory is
   
    function GetBatteryVolt return Integer; 
    function GetDistance return Integer; 

    protected BatteryRaw is
        procedure Put (Data : Integer);
        entry Get (Data : out Integer);
    private
        Container : Integer;
        Received  : Boolean := False;
    end BatteryRaw;

    protected DistanceRaw is
        procedure Put (Data : Integer);
        entry Get (Data : out Integer);
    private
        Container : Integer;
        Received  : Boolean := False;
    end DistanceRaw;

    -- tasks
    task BatteryStatusUpdater is
        pragma Priority (121);
        pragma Storage_Size (2*1024);
    end BatteryStatusUpdater;

    task SonarStatusUpdater is
        pragma Priority (122);
        pragma Storage_Size (2*1024);
    end SonarStatusUpdater;


end MyCubWorkingMemory;


