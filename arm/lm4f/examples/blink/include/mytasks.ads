
package MyTasks is

    task RedTask is
        pragma Priority (131);
        pragma Storage_Size (2*1024);
    end RedTask;

    task GreenTask is
         pragma Priority (130);
         pragma Storage_Size (2*1024);
     end GreenTask;

end MyTasks;


