
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with LM4F.Gpio;         use LM4F.Gpio;
with LM4F.Uart;
with ARM.Uart;
with ARM.Strings;       use ARM.Strings;

with Interfaces;        use Interfaces;
with Interfaces.C;      use Interfaces.C;
with ARM.Strings;       use ARM.Strings;

with MyCubController;   use MyCubController;
with MyCubWorkingMemory; use MyCubWorkingMemory;

package body MyCubInterface is

    package Stdio is new ARM.Uart(Port => LM4F.Uart.UART3, IRQ => 75); -- 21 for UART0

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
        Ret : Boolean;
      begin
            -- wait for few seconds then start the Uart
            PinTypeOutput(PORTF, PIN1);
            PinWrite(PORTF, PIN1, PIN1);
            delay until Clock + Seconds(15); 
            PinWrite(PORTF, PIN1, 0);
            UartSetup;

        loop
            Stdio.Get_Line(Data, Last, Echo => False);
            ParseCommand(Data, Last, Commands, Count);
            -- Stdio.Put_Line("Commands:");
            
            if Count = 0 then
                Stdio.Put_Line("[error]"); 

            --
            -- ping
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "ping" or 
                  Commands(1).Str(2..Commands(1).Size) = "ping"  then
                Stdio.Put_Line("[ok]"); 
            --
            -- startControl
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "startControl" then
                
                if StartController = True then 
                    for I in 0..3 loop
                        Ret := SetPose(I, 8);
                    end loop;
                    Stdio.Put_Line("[ok]"); 
                else
                    Stdio.Put_Line("[error]"); 
                end if;
            --
            -- stopControl
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "stopControl" then
                StopController;
                Stdio.Put_Line("[ok]"); 
            --
            -- setPose
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "setPose" then
                if Count >= 3 then
                    Joint := Stdio.StrToInt(Commands(2).Str, Commands(2).Size);
                    Pos := Stdio.StrToInt(Commands(3).Str, Commands(3).Size);
                    if SetPose(Joint, Pos) = True then
                        Stdio.Put_Line("[ok]");
                    else
                        Stdio.Put_Line("[error]");
                    end if;
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
                    if SetPose(Joint, Pos) = True then
                        Stdio.Put_Line("[ok]");
                    else
                        Stdio.Put_Line("[error]");
                    end if;
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
                    if SetPose(Joint, Pos) = True then
                        Stdio.Put_Line("[ok]");
                    else
                        Stdio.Put_Line("[error]");
                    end if;
                else
                    Stdio.Put_Line("[error]"); 
                end if;
            --
            -- getBatteryVolt
            --
            elsif Commands(1).Str(1..Commands(1).Size) = "getBatteryVolt" then
                Pos := GetBatteryVolt;
                Stdio.IntToStr(Pos, Data, Last); 
                Stdio.Put_Line(Data(1 .. Last));
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
                    Pos := GetDistance;
                    Stdio.IntToStr(Pos, Data, Last); 
                    Stdio.Put_Line(Data(1 .. Last));
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

