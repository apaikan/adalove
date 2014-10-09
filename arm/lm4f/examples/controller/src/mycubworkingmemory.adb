
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with LM4F.ADC;          use LM4F.ADC;
with LM4F.Gpio;         use LM4F.Gpio;
with LM4F.HTimer;

package body MyCubWorkingMemory is

    package HTime is new LM4F.HTimer;

    --
    -- GetBatteryVolt
    --
    function GetBatteryVolt return Integer
    is
        RawData : Integer;
    begin
        BatteryRaw.Get(RawData);
        return Integer(Float(RawData) * 0.805860806 * 11.0);
    end GetBatteryVolt;

    --
    --  GetDistance 
    --
    function GetDistance return Integer
    is
        RawData : Integer;
    begin
        DistanceRaw.Get(RawData);
        return RawData;
    end getDistance;

    --
    -- protected BatteryRaw
    -- 
    protected body BatteryRaw is
        procedure Put(Data : Integer) is
        begin
            Container := Data;
        end Put;

        procedure Get(Data : out Integer) is
        begin
            Data := Container;
        end Get;
    end BatteryRaw;

    --
    -- protected DistanceRaw
    -- 
    protected body DistanceRaw is
        procedure Put(Data : Integer) is
        begin
            Container := Data;
        end Put;

        procedure Get(Data : out Integer) is
        begin
            Data := Container;
        end Get;
    end DistanceRaw;

    --
    -- BatteryStatusUpdater task
    --
    task body BatteryStatusUpdater is
        Period : constant Time_Span := Seconds(5);
        Activation : Time := Clock;
        Value : aliased Integer := 0;
        Ret : Integer := 0;
    begin
        -- configure adc
        SequenceConfigure(ADC0_BASE, 3, ADC_TRIGGER_PROCESSOR, 0);
        SequenceStepConfigure(ADC0_BASE, 3, 0, ADC_CTL_CH6 + ADC_CTL_IE + ADC_CTL_END);
        SequenceEnable(ADC0_BASE, 3);
        IntClear(ADC0_BASE, 3);

        loop
            delay until Activation;
            Activation := Activation + Period;
            -- reading adc value
            ProcessorTrigger(ADC0_BASE, 3);
            --while IntStatus(ADC0_BASE, 3, 0) /= 0 loop 
            --    null;
            --end loop;
            IntClear(ADC0_BASE, 3);
            Ret := SequenceDataGet(ADC0_BASE, 3, Value'Access);
            BatteryRaw.Put(Value);
        end loop;
    end BatteryStatusUpdater;

    --
    -- SonarStatusUpdater
    --
    task body SonarStatusUpdater is
        Period : constant Time_Span := Milliseconds(500);
        Next_Time : Time := Clock;
        Value : Integer := 0;
        -- reading pulse width 
        function PulseIn(Port : Integer; 
                         Pin : Integer; TimeoutMs : Long_Integer) return Long_Integer is
        Now : Long_Integer;       
        begin
            -- wait for any previous pulse to finish
            Now := HTime.GetTick; 
            while PinRead(Port, Pin) /= 0 loop 
                if HTime.GetSpanMsec(Now, HTime.GetTick) > TimeoutMs then
                    return -1;
                end if;
            end loop;
            
            -- wait for pulse to begin
            Now := HTime.GetTick; 
            while PinRead(Port, Pin) = 0 loop 
                if HTime.GetSpanMsec(Now, HTime.GetTick) > TimeoutMs then
                    return -1;
                end if;
            end loop;
            
            -- wait for pulse to finish
            Now := HTime.GetTick; 
            while PinRead(Port, Pin) /= 0 loop 
                if HTime.GetSpanMsec(Now, HTime.GetTick) > TimeoutMs then
                    return -1;
                end if;
            end loop;
            return HTime.GetSpanUsec(Now, HTime.GetTick); 
        end;

      begin
        HTime.Init;
        PinTypeOutput(PORTA, PIN2);     -- Trig pin
        PinTypeInput(PORTA, PIN3);      -- Echo pin
        loop
            Next_Time := Next_Time + Period;
            delay until Next_Time; 

            -- trriging the sensor
            PinWrite(PORTA, PIN2, 0);
            HTime.WaitUsec(10);
            PinWrite(PORTA, PIN2, PIN2);
            HTime.WaitUsec(10);
            PinWrite(PORTA, PIN2, 0);
            
            -- reading the pulse width
            Value := Integer(Float(PulseIn(PORTA, PIN3, 500)) / 5.246);
            DistanceRaw.Put(Value);
        end loop;
    end SonarStatusUpdater;

end MyCubWorkingMemory;

