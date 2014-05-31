
with Ada.Text_IO;       use Ada.Text_IO;
with Interfaces.C;      use Interfaces.C;

procedure Main is

    function GetRandom(a,b : in Integer) return Integer;
      pragma Import (CPP, GetRandom, "_Z9getRandomii");
begin
    Put_Line("This is an example of using C++ funtion in Ada!");

    for i in 1 .. 10 loop
        Put_Line(Integer'Image(GetRandom(1,10)));
    end loop;
end Main;


