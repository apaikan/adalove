
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with TM4C.Gpio;         use TM4C.Gpio;
with TM4C.Uart;
with ARM.Uart;
with ARM.Strings;       use ARM.Strings;

with Interfaces;        use Interfaces;
with Interfaces.C;      use Interfaces.C;
with ARM.Strings;       use ARM.Strings;

package body MyCubInterface is

    package Stdio is new ARM.Uart(Port => TM4C.Uart.UART0);

    -- '  setpos 1 30 '
    procedure ParseCommand(Str: ARM_String;
                           Last: Unsigned_8;
                           Commands: out MyCub_Command;
                           Count: out Unsigned_8)
    is
        Pos : Unsigned_8 := Str'First;
        --Idx : Unsigned_8 := 0;
    begin
        Count := 0;
        while Pos <= Last loop
            -- skip starting spaces
            while Str(Pos) = ' ' loop 
                Pos := Pos + 1; 
                exit when Pos > Last;
            end loop;
            
            exit when Pos > Last; 

            -- copy a command
            Count := Count + 1;
            Commands(Count).Size := 0;
            while Str(Pos) /= ' ' loop
                if Commands(Count).Size < 20 then
                    Commands(Count).Str(Commands(Count).Size+1) := Str(Pos);
                    Commands(Count).Size := Commands(Count).Size + 1;
                end if;    
                Pos := Pos + 1;
                exit when Pos > Last; 
            end loop;           

            -- increament commands counter
            exit when Count > 4;
        end loop;       
    end ParseCommand;


    --
    -- Uart task
    --
    task body UartTask is
        Data : ARM_String(1..80);
        Last : Unsigned_8;
        Commands : MyCub_Command;
        Count : Unsigned_8;
        Joint : Integer;
        Pos : Integer;
        Duration : Integer;
      begin
        loop
            Stdio.Get_Line(Data, Last, Echo => True);
            ParseCommand(Data, Last, Commands, Count);
            -- Stdio.Put_Line("Commands:");
            
            if Count = 0 then
                Stdio.Put_Line("[error]"); 
            end if;

            --
            -- ping
            --
            if Commands(1).Str(1..Commands(1).Size) = "ping" then
                Stdio.Put_Line("[ok]"); 
            --
            -- startControl
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "startControl" then
                -- start motor controller here
                Stdio.Put_Line("[error]"); 
            --
            -- stopControl
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "stopControl" then
                -- TODO
                Stdio.Put_Line("[ok]"); 
            --
            -- setPose
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "setPose" then
                if Count >= 3 then
                    Joint := Stdio.StrToInt(Commands(2).Str, Commands(2).Size);
                    Pos := Stdio.StrToInt(Commands(3).Str, Commands(3).Size);
                    Stdio.Put_Line("[ok]");
                else
                    Stdio.Put_Line("[error]"); 
                end if;
            --
            -- gotoPose
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "gotoPose" then
                if Count >= 3 then
                    Joint := Stdio.StrToInt(Commands(2).Str, Commands(2).Size);
                    Pos := Stdio.StrToInt(Commands(3).Str, Commands(3).Size);
                    if Count >= 4 then
                        Duration := Stdio.StrToInt(Commands(4).Str, Commands(4).Size);
                    else
                        Duration := 0;
                    end if;
                    Stdio.Put_Line("[ok]");
                else
                    Stdio.Put_Line("[error]"); 
                end if;
            --
            -- goToPoseSync
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "goToPoseSync" then
                if Count >= 3 then
                    Joint := Stdio.StrToInt(Commands(2).Str, Commands(2).Size);
                    Pos := Stdio.StrToInt(Commands(3).Str, Commands(3).Size);
                    if Count >= 4 then
                        Duration := Stdio.StrToInt(Commands(4).Str, Commands(4).Size);
                    else
                        Duration := 0;
                    end if;
                    Stdio.Put_Line("[ok]");
                else
                    Stdio.Put_Line("[error]"); 
                end if;
            --
            -- getBatteryVolt
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "getBatteryVolt" then
                Stdio.Put_Line("0.0"); 
            --
            -- getBatteryCurrent
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "getBatteryCurrent" then
                Stdio.Put_Line("0.0"); 
            --
            -- getDistance
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "getDistance" then
                if Count >= 2 then
                    Joint := Stdio.StrToInt(Commands(2).Str, Commands(2).Size);
                    Stdio.Put_Line("0");
                else
                    Stdio.Put_Line("[error]"); 
                end if;
            --
            -- getPose
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "getPose" then
                if Count >= 2 then
                    Joint := Stdio.StrToInt(Commands(2).Str, Commands(2).Size);
                    Stdio.Put_Line("0");
                else
                    Stdio.Put_Line("[error]"); 
                end if;

            --
            -- Unknown command
            --
            else
                Stdio.Put_Line("[error]"); 
            end if;

        end loop;
    end UartTask;

    --
    -- Blinky Task body
    --
    task body BlinkyTask is        
        Period : constant Time_Span := Seconds(3);
        Next_Time : Time := Clock;
    begin
        PinTypeOutput(PORTF, PIN3);
        loop
            -- wait for the next period
            Next_Time := Next_Time + Period - Milliseconds(50);
            delay until Next_Time;            
            PinWrite(PORTF, PIN3, PIN3);
            -- wait for some ms then turn of leds
            Next_Time := Next_Time + Milliseconds(50);
            delay until Next_Time;            
            PinWrite(PORTF, PIN3, 0);
      end loop;
  end BlinkyTask;

end MyCubInterface;

