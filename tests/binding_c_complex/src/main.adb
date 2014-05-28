
with Ada.Text_IO;           use Ada.Text_IO;
with Interfaces.C;          use Interfaces.C;
with Interfaces.C.Strings;  use Interfaces.C.Strings;
with sqlite3_h;             use sqlite3_h;
with System;

procedure Main is
    db : System.Address;
    ret : Integer;
--    db_name : Strings.chars_ptr := New_String("test.db");
begin
    Put_Line("This is an example of using C funtion in Ada!");
    ret := Integer(sqlite3_open(New_String("test.db"), db));

end Main;


