
with Ada.Real_Time;     use Ada.Real_Time;
with Interfaces.C;      use Interfaces.C;


package body MyCubController is
    
    function SetContext(ctx: Joint_Context) return Boolean
    is
    begin
        null;
        return True;
    end;


    -- function SetPose(joint: Joint_ID; pos: Joint_POS) return Boolean
    -- is
    -- begin
     --   null;
     --   return True;
     --end;

end MyCubController;

