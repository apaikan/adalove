
with Ada.Text_IO;
use Ada.Text_IO;

procedure Main is

task type SHORT_LINE is
   pragma PRIORITY (5);
end SHORT_LINE;

task type LONG_LINE is
   pragma PRIORITY (1);
end LONG_LINE;

pragma PRIORITY (3);   -- This is the priority for the main program

Cow, Dog, Pig          : SHORT_LINE;
Elephant, Hippopotamus : LONG_LINE;

task body SHORT_LINE is
begin
   for Index in 1..4 loop
      delay 0.0;
      Put_Line("This is a short line");
   end loop;
end SHORT_LINE;

task body LONG_LINE is
begin
   for Index in 1..3 loop
      delay 0.0;
      Put_Line("This is a much longer line to be displayed");
   end loop;
end LONG_LINE;

begin
   Put_Line("This is an example of use of a task type");
end Main;


