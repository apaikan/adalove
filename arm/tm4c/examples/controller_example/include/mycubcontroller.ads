with System;

package MyCubController is
   
    subtype Joint_ID is Integer range 0..3;
    subtype Joint_POS is Integer range 8..160;
    type Joint_Context is array (0..3) of Joint_POS;

    function StartController return Boolean; 
    function StopController return Boolean; 
    function SetPose(joint: Joint_ID, pos: Joint_POS) return Boolean;
    function GoToPose(joint: Joint_ID, pos: Joint_POS, tms: Long_Integer) return Boolean;
    function GoToPoseSync(joint: Joint_ID, pos: Joint_POS, tms: Long_Integer) return Boolean;
    function CheckMotionDone(joint: Joint_ID) return Boolean;
    function CheckMotionDone return Boolean;
    function GetContext return Joint_Context;
    function SetContext(ctx: Joint_Context) return Boolean;

    -- uart task
--    task UartTask is
--        pragma Priority (130);
--        pragma Storage_Size (2*1024);
--    end UartTask;

end MyCubController;


