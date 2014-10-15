
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces;        use Interfaces;
with Interfaces.C;      use Interfaces.C;
with ARM.Strings;       use ARM.Strings;
--with ARM.Strings.Edit;  use ARM.Strings.Edit;
with LM4F.Gpio;          use LM4F.Gpio;
with LM4F.Uart;
--with ARM.Uart;
with ARM.I2C;


package body MyTasks is

    --package Stdio is new ARM.Uart(Port => LM4F.Uart.UART0, IRQ => 21);
    package I2C is new ARM.I2C(Base => 16#40021000#); --I2C 1

    --
    -- RTC task
    --
    task body CompassTask is
        Period : constant Time_Span := Milliseconds(300);
        Next_Time : Time := Clock;
        Data : ARM_String(1..80);
        Last : Unsigned_8;
        Value : Integer;
        Ret : Boolean;

        HMC5883_ADDRESS_MAG            : constant := 2#0001_1110#;
        HMC5883_REGISTER_MAG_CRB_REG_M : constant := 16#01#;
        HMC5883_REGISTER_MAG_MR_REG_M  : constant := 16#02#;
        HMC5883_REGISTER_MAG_OUT_X_H_M : constant := 16#03#;            
        HMC5883_MAGGAIN_1_3            : constant := 16#02#;
        -- for Gain 1.3 the LSB is defined as below:
        GAUSS_LSB_XY                   : constant := 1100; 
        GAUSS_LSB_Z                    : constant := 980; 
        GAUSS_TO_MICROTESLA            : constant := 100;

        --
        -- InitCompass
        --
        function InitCompass return Boolean is
            Data : I2C.ByteVector (1 .. 2); 
        begin
            I2C.SetFrequency(400);

            -- Enable the magnetometer
            I2C.SetAddress(HMC5883_ADDRESS_MAG, HMC5883_REGISTER_MAG_MR_REG_M);
            Data(1) := 0;
            if I2C.Write(Data, 1) = False then
                return False;
            end if;
            
            -- Set the gain to a known level
            I2C.SetAddress(HMC5883_ADDRESS_MAG, HMC5883_REGISTER_MAG_CRB_REG_M);
            Data(1) :=  HMC5883_MAGGAIN_1_3;
            if I2C.Write(Data, 1) = False then
                return False;
            end if;
            return True;
        end;

        --
        -- ReadCompass
        --
        procedure ReadCompass(Heading : out Integer; Succeed : out Boolean) is
            Data : I2C.ByteVector (1 .. 8); 
            Len : Integer;
            X, Y : Float;
        begin
            Value := 0;
            I2C.SetAddress(HMC5883_ADDRESS_MAG, HMC5883_REGISTER_MAG_OUT_X_H_M);
            Len := 6;
            I2C.Read(Data, Len);
            if Len /= 6 then 
                Succeed := False;
                return;
            end if;
            
            X := Float( Integer(Data(1)) * 256 + Integer(Data(2)) );
            Y := Float( Integer(Data(5)) * 256 + Integer(Data(6)) );
            -- Z := Integer(Data(3)) * 256 + Integer(Data(4));
            
            X := X / Float(GAUSS_LSB_XY * GAUSS_TO_MICROTESLA);
            Y := Y / Float(GAUSS_LSB_XY * GAUSS_TO_MICROTESLA);
            Heading := Integer(X); 
            Succeed := True;
        end;

      begin
        Ret := InitCompass;        
        loop
            Next_Time := Next_Time + Period;
            delay until Next_Time; 

            -- reading the compass value
            ReadCompass(Value, Ret);
            --Stdio.IntToStr(Value, Data, Last); 
            --Stdio.Put_Line(Data(1 .. Last));
        end loop;
    end CompassTask;


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

end MyTasks;

