program Fluent1;
{$APPTYPE CONSOLE}

uses
  U_fluent_intf,
  TTest_intf,
  TTest_obj;

begin
    TTestIntfImp.MakeIntf
                .id
                .FluentSetName('My name is bob')
                .id
                .FluentSetAge(8)
                .id
                .FluentSetName('My name is tom')
                .id
                .FluentSetAge(9)
                .id
                .FluentSetName('My name is peg')
                .id
                .FluentSetAge(3)
                .id;
    var Obj := TTestObj.Create;
    try
             Obj.FluentSetName('My name is bob')
                .id
                .FluentSetAge(8)
                .id
                .FluentSetName('My name is tom')
                .id
                .FluentSetAge(9)
                .id
                .FluentSetName('My name is peg')
                .id
                .FluentSetAge(3)
                .id;
    finally  Obj.Free;
    end;
    Readln;
end.
