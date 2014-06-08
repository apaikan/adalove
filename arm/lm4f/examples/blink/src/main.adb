pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;

with LM4F120.Sysctl;    use LM4F120.Sysctl;
with LM4F120.Gpio;      use LM4F120.Gpio;
with LM4F120.Memmap;    use LM4F120.Memmap;

with MyTasks;           use MyTasks;

procedure Main is
   pragma Priority (0);
begin        
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
    GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1 + GPIO_PIN_2 + GPIO_PIN_3);
    -- turn off all leds
    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, 0);
    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_2, 0);
    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_3, 0);

    loop
        null;
    end loop;
end Main;

