with System;
with Interfaces;

package MyTasks is

    subtype Item is Integer; 
    UART0_IntID : constant := 21;

    -- monitor object
    protected Monitor is
--        pragma Priority (System.Interrupt_Priority'Last - 10);

        procedure UartIntHandler;
        pragma Attach_Handler (UartIntHandler, UART0_IntID);

        entry Get(Data : out Interfaces.Unsigned_8);
    private
        Container : Interfaces.Unsigned_8;
        Received  : Boolean := False;
    end Monitor;

    -- uart task
    task UartTask is
        pragma Priority (130);
        pragma Storage_Size (2*1024);
    end UartTask;

    -- blinky
    task BlinkyTask is
         pragma Priority (120);
         pragma Storage_Size (2*1024);
    end BlinkyTask;

end MyTasks;


