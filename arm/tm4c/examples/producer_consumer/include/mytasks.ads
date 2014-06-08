
package MyTasks is

    subtype Item is Integer; 

    protected Buffer is
        procedure Put (Element : Item);
        entry Get (Element : out Item);
    private
        Container : Item;
        Received  : Boolean := False;
    end Buffer;

    -- tasks
    task Producer is
        pragma Storage_Size (2*1024);
    end Producer;

    task Consumer is
         pragma Storage_Size (2*1024);
    end Consumer;

end MyTasks;


