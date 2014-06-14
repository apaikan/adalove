with Interfaces;    use Interfaces;
with Interfaces.C;  use Interfaces.C;
with TM4C.Htimer;  
with Ada.Unchecked_Conversion;

package body TM4C.HTimer is

    TIMER_CFG_RTC : constant := 16#01000000#;  --  timer.h:70
    TIMER_A : constant := 16#000000ff#;  --  timer.h:157
    TIMER_B : constant := 16#0000ff00#;  --  timer.h:158
    TIMER_BOTH : constant := 16#0000ffff#;  --  timer.h:159
    TIMER_CFG_A_PERIODIC_UP : constant := 16#00000032#;  --  timer.h:75
    TIMER_CFG_B_PERIODIC_UP : constant := 16#00003200#;  --  timer.h:84

    function TimerValueGet (Base : Integer; Timer : Integer) return Integer;  -- timer.h:263
    pragma Import (C, TimerValueGet, "TimerValueGet");

    function TimerValueGet64 (Base : Integer) return Integer;  -- timer.h:264
    pragma Import (C, TimerValueGet64, "TimerValueGet64");

    procedure EnableTimer (Base : Integer; Timer : Integer);  -- timer.h:237
    pragma Import (C, EnableTimer, "TimerEnable");

    procedure DisableTimer (Base : Integer; Timer : Integer);  -- timer.h:238
    pragma Import (C, DisableTimer, "TimerDisable");

    procedure ConfigureTimer (Base : Integer; Config : Integer);  -- timer.h:239
    pragma Import (C, ConfigureTimer, "TimerConfigure");

    procedure Init is 
    begin
        ConfigureTimer(Timer, TIMER_CFG_A_PERIODIC_UP);
        EnableTimer(Timer, TIMER_A);
    end;

    function GetTick return Integer is
    begin
        return abs TimerValueGet(Timer, TIMER_A);
    end;

    function GetSpan( StartT : Integer; 
                      EndT : Integer) return Integer is
    begin
        return abs( abs EndT - abs StartT);
    end;

    function GetSpanUsec ( StartT : Integer;
                        EndT : Integer) return Integer is
    begin
        return GetSpan(StartT, EndT) * 1000_000 / TickPerSec;
    end;

    function GetSpanMsec ( StartT : Integer;
                        EndT : Integer) return Integer is
    begin
        return GetSpan(StartT, EndT) * 1000 / TickPerSec;
    end;

    function GetSpanSec (StartT : Integer;
                        EndT : Integer) return Integer is
    begin
        return GetSpan(StartT, EndT) / TickPerSec;
    end;

    -- busy waiting in microseconds 
    procedure WaitUsec(Duration : Integer) is 
        Stime : Integer := GetTick;
    begin
        while GetSpanUsec(Stime, GetTick) < Duration  loop
            null;
        end loop;
    end;

    -- busy waiting in miliroseconds 
    procedure WaitMsec(Duration : Integer) is 
        Stime : Integer := GetTick;
    begin
        while GetSpanMsec(Stime, GetTick) < Duration  loop
            null;
        end loop;
    end;

end TM4C.HTimer;

