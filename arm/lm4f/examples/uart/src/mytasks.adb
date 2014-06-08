
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;

with LM4F120.Sysctl;    use LM4F120.Sysctl;
with LM4F120.Gpio;      use LM4F120.Gpio;
with LM4F120.Memmap;    use LM4F120.Memmap;
with LM4F120.Pinmap;    use LM4F120.Pinmap;
with LM4F120.UART;      use LM4F120.Uart;

package body MyTasks is
    task body SimpleTask is
        Baudrate : constant := 115200;
        Task1_Period : constant Time_Span := To_Time_Span (1.0);
        Next_Time : Time := Clock;
        Toggle : Boolean := False;
    begin
        -- init Led 
        SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
        GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1 + GPIO_PIN_3);

        loop
            if Toggle = False then
                Toggle :=  True;
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, GPIO_PIN_1); 
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_3, 0); 
                UARTCharPut(UART0_BASE, 65);
                UARTCharPut(UART0_BASE, 10);
--                UARTCharPut(UART0_BASE, unsigned_char('A'));
            else
                Toggle := False;
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_3, GPIO_PIN_3); 
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, 0);
            end if;

            -- wait for the next period
            Next_Time := Next_Time + Task1_Period;
            delay until Next_Time;
        end loop;
    end SimpleTask;

end MyTasks;

