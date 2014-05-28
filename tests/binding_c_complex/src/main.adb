
with Ada.Text_IO;       use Ada.Text_IO;
with random_num_h;      use random_num_h;
with Interfaces.C;      use Interfaces.C;

procedure Main is
begin
    Put_Line("This is an example of using C funtion in Ada!");

    for i in 1 .. 10 loop
        Put_Line(Integer'Image( Integer(GetRandom(int(1),int(10))) ));
    end loop;
end Main;


