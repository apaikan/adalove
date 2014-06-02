
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;

with LM4F120.Sysctl;    use LM4F120.Sysctl;
with LM4F120.Gpio;      use LM4F120.Gpio;
with LM4F120.Memmap;    use LM4F120.Memmap;
with LM4F120.Pinmap;    use LM4F120.Pinmap;
with LM4F120.UART;      use LM4F120.Uart;

package body MyTasks is
    task body SimpleTask is
        Task1_Period : constant Time_Span := To_Time_Span (1.0);
        Next_Time : Time := Clock;
        Toggle : Boolean := False;
    begin
        -- init Led 
        SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
        GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1);

        -- init uart
        SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);
        GPIOPinConfigure(GPIO_PA0_U0RX);
        GPIOPinConfigure(GPIO_PA1_U0TX);

        --GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0 or GPIO_PIN_1);
        GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0);
        GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_1);

        --UARTConfigSetExpClk(UART0_BASE, SysCtlClockGet(), 115200,
        --                (UART_CONFIG_WLEN_8 | UART_CONFIG_STOP_ONE |
        --                 UART_CONFIG_PAR_NONE));

        loop
            if Toggle = False then
                Toggle :=  True;
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, GPIO_PIN_1); 
                UARTCharPut(UART0_BASE, To_C("A"));
            else
                Toggle := False;
                GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, 0);
            end if;

            -- wait for the next period
            Next_Time := Next_Time + Task1_Period;
            delay until Next_Time;
        end loop;
    end SimpleTask;

end MyTasks;

