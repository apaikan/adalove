
with Ada.Text_IO;           use Ada.Text_IO;
with Simple;                use Simple;

procedure Main is
    num : Integer := 0;

begin        
    Put_Line ("Hello, world!");    
    num := Simple.Inc(num);
    num := Simple.Inc(num);
    Put_Line (Integer'Image(num));
    
    num := Simple.Dec(num);
    Put_Line (Integer'Image(num));

end Main;


