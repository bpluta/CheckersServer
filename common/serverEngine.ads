with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with Ada.Command_Line;
with parser;
with requestHandler;
with Ada.Strings.Unbounded;

with GNAT.Sockets; use GNAT.Sockets;
with GNAT.Command_Line; use GNAT.Command_Line;
with Ada.Streams; use type Ada.Streams.Stream_Element_Count;

limited with serverHandler;

package serverEngine is
  pragma Suppress (Elaboration_Check);
    package UB renames Ada.Strings.Unbounded;

    subtype PortRange is Port_Type range 0 .. 65535;

    Server : Socket_Type;
    Socket : Socket_Type;

    Address : Sock_Addr_Type;
    Client : Sock_Addr_Type;
    Channel : Stream_Access;
    Port : PortRange;
    Errors : Natural := 0;

    CRLF : String := (1 => ASCII.CR, 2 => ASCII.LF);
    Send : String := (1 => ASCII.CR, 2 => ASCII.LF, 3 => ASCII.CR, 4 => ASCII.LF);

    Offset : Ada.Streams.Stream_Element_Count;
    Data : Ada.Streams.Stream_Element_Array (1 .. 512);

    HTTPrequest : UB.Unbounded_String;

    Index : Ada.Streams.Stream_Element_Offset;
    Request : parser.RequestRecord;

    task serverRunner is
      entry run;
    end serverRunner;

end serverEngine;
