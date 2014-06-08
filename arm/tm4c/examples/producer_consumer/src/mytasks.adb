
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with TM4C.Gpio;         use TM4C.Gpio;

package body MyTasks is

    --
    -- protected buffer 
    -- 
    protected body Buffer is
        procedure Put(Element : Item) is
        begin
            Container := Element;
            Received := True;
        end Put;

        entry Get(Element : out Item)
            when Received is
        begin
            Element := Container;
            Received := False;
        end Get;
    end Buffer;

    --
    -- Producer task
    --
    task body Producer is
        Period : constant Time_Span := Milliseconds (1000);
        Activation : Time := Clock;
        Element : Item := 0;
    begin
        PinTypeOutput(PORTF, PIN2);
        loop
            delay until Activation;
            if Element = 0 then
                Element :=  PIN2;
            else
                Element := 0;
            end if;
            Buffer.Put(Element);
            Activation := Activation + Period;
        end loop;
    end Producer;


    --
    -- Consumer Task
    --
    task body Consumer is
        Element : Item;
    begin
        loop
            Buffer.Get(Element);
            PinWrite(PORTF, PIN2, Element);
        end loop;
    end Consumer;

end MyTasks;

