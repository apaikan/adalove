with Interfaces;    use Interfaces;
with Interfaces.C;  use Interfaces.C;
with ARM.Strings;   use ARM.Strings;
with TM4C.Uart;      use TM4C.Uart;
with Ada.Unchecked_Conversion;

package body ARM.Uart is

    procedure Put (Ch : Character) is
    begin
        CharPut (Port, To_U8 (Ch));
    end Put;

    procedure New_Line is
      EOL : constant := 16#0A#;
    begin
      CharPut(Port, EOL);
    end New_Line;


    procedure CRLF is
      LF : constant := 16#0A#;
      CR : constant := 16#0D#;
    begin
      CharPut (Port, CR);
      CharPut (Port, LF);
    end CRLF;


    procedure Put (S : ARM_String) is
    begin
      for I in S'Range loop
         Put (S (I));
      end loop;
    end Put;

    procedure Put_Line (S : ARM_String) is
    begin
      Put (S);
      --New_Line;
      CRLF;
    end Put_Line;

end ARM.Uart;

