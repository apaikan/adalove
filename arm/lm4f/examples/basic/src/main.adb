with Interfaces.C;      use Interfaces.C;

with LM4F120.Sysctl;    use LM4F120.Sysctl;
with LM4F120.Gpio;      use LM4F120.Gpio;
with LM4F120.Memmap;    use LM4F120.Memmap;

procedure Main is
begin    
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
    GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1 + GPIO_PIN_2 + GPIO_PIN_3);
    -- turn off all leds execpt the green
    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, 0);
    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_2, 0);
    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_3, GPIO_PIN_3);
end Main;


