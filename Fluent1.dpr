program Fluent1;
{$APPTYPE CONSOLE}

uses
  U_fluent_intf in 'U_fluent_intf.pas',
  TTest_intf in 'TTest_intf.pas',
  TTest_obj in 'TTest_obj.pas',
  TTest_rec in 'TTest_rec.pas';

begin
    TTestIntfImp.MakeIntf
                .FluentSetName('My name is bob').id.FluentSetAge(8)
                .id
                .FluentSetName('My name is tom').FluentSetAge(9)
                .id
                .FluentSetName('My name is peg').FluentSetAge(3)
                .id;

    var Obj := TTestObj.Create;
    try
             Obj.FluentSetName('My name is bob').id.FluentSetAge(8)
                .id
                .FluentSetName('My name is tom').FluentSetAge(9)
                .id
                .FluentSetName('My name is peg').FluentSetAge(3)
                .id;
    finally  Obj.Free;
    end;

    var Rec : TRecObj;
             Rec.FluentSetName('My name is bob').id.FluentSetAge(8)
                .id
                .FluentSetName('My name is tom').FluentSetAge(9)
                .id
                .FluentSetName('My name is peg').FluentSetAge(3)
                .id;
    Readln;
end.
