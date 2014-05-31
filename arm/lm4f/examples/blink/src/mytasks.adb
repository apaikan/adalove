
with Ada.Real_Time;     use Ada.Real_Time;
with sysctl_h;          use sysctl_h;
with gpio_h;            use gpio_h;
with hw_memmap_h;       use hw_memmap_h;


package body MyTasks is
    --T0 : constant Time := Clock;    
    --Task1_Period : constant Time_Span := To_Time_Span (1.0);
    task body SimpleTask is
       -- Next_Time : Time := T0;
    begin    
        SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
        GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1);
        loop
            --Next_Time := Next_Time + Task1_Period;
            --delay until Next_Time;
            GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, GPIO_PIN_1); 
            --GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, 0);
        end loop;
    end SimpleTask;

end MyTasks;

