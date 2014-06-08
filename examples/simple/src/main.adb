
with Ada.Text_IO;           use Ada.Text_IO;
with Simple;                use Simple;

procedure Main is
    type Unsigned_Integer is mod 2**Integer'Size;
    num : Integer := 0;
    a : constant := 16#01#;
    b : constant := 16#02#;
begin        
    Put_Line ("Hello, world!");    
    num := Simple.Inc(num);
    num := Simple.Inc(num);
    Put_Line (Integer'Image(num));

    num := Simple.Dec(num);
    Put_Line (Integer'Image(num));

    --Put_Line(Integer'Image(a));
    --Put_Line(Integer'Image(Integer(Unsigned_Integer(a) or Unsigned_Integer(b))));

end Main;


