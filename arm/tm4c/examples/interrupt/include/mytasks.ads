with System;

package MyTasks is

    subtype Item is Integer; 
    UART0_IntID : constant := 21;

    -- monitor object
    protected Monitor is
--        pragma Priority (System.Interrupt_Priority'Last - 10);

        procedure UartIntHandler;
        pragma Attach_Handler (UartIntHandler, UART0_IntID);

        entry Get(Data : out Integer);
    private
        Container : Integer;
        Received  : Boolean := False;
    end Monitor;


    -- tasks
    task UartTask is
        pragma Priority (130);
        pragma Storage_Size (2*1024);
    end UartTask;

end MyTasks;


