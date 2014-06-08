pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;
with TM4C.Gpio;      use TM4C.Gpio;

procedure Main is
begin    
    PinTypeOutput(PORTF, PIN1);
    PinWrite(PORTF, PIN1, PIN1);
end Main;


