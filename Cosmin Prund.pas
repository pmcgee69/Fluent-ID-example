program TestFluentInterfaces;
{$APPTYPE CONSOLE}

//   https://stackoverflow.com/a/5104244/8106387
//   https://web.archive.org/web/20110227200636/http://paste.ideaslabs.com/show/lzILqOs6PK

uses
  SysUtils,Windows;

type

  ITestIntf = interface
    procedure SetName(Name:string);
    procedure SetAge(Age:Integer);

    function FluentSetName(Name:string):ITestIntf;
    function FluentSetAge(Age:Integer):ITestIntf;

    function GetName:string;
    function GetAge:Integer;
  end;

  TTestIntfImp = class(TInterfacedObject, ITestIntf)
  protected
    FName: string;
    FAge: Integer;
  public
    procedure SetName(Name:string);
    procedure SetAge(Age:Integer);

    function FluentSetName(Name:string):ITestIntf;
    function FluentSetAge(Age:Integer):ITestIntf;

    function GetName:string;
    function GetAge:Integer;

    class function MakeIntf: ITestIntf;
  end;

  TTestObj = class
  protected
    FName: string;
    FAge: Integer;
  public
    procedure SetName(Name:string);
    procedure SetAge(Age:Integer);

    function FluentSetName(Name:string):TTestObj;
    function FluentSetAge(Age:Integer):TTestObj;

    function GetName:string;
    function GetAge:Integer;
  end;

  TTestRoutine = procedure(NumIterations:Integer) of object;

  TTestBothImplementations = class
  protected
    procedure MakeSureTheInterfaceIsUsed(Intf: ITestIntf);
    procedure MakeSureTheObjIsUsed(Obj: TTestObj);

    procedure TestNonFluent(NumIterations: Integer);
    procedure TestFluent(NumIterations: Integer);

    procedure TestNonFluent_Obj(NumIterations: Integer);
    procedure TestFluent_Obj(NumIterations: Integer);
  public
    procedure TimeTest(TheTest: TTestRoutine; NumIterations: Integer; TestName:string);

    procedure RunTests;
  end;

{ TTestIntfImp }

function TTestIntfImp.FluentSetAge(Age: Integer): ITestIntf;
begin
  FAge := Age;
  Result := Self;
end;

function TTestIntfImp.FluentSetName(Name: string): ITestIntf;
begin
  FName := Name;
  Result := Self;
end;

function TTestIntfImp.GetAge: Integer;
begin
  Result := FAge;
end;

function TTestIntfImp.GetName: string;
begin
  Result := FName;
end;

class function TTestIntfImp.MakeIntf: ITestIntf;
begin
  Result := TTestIntfImp.Create;
end;

procedure TTestIntfImp.SetAge(Age: Integer);
begin
  FAge := Age;
end;

procedure TTestIntfImp.SetName(Name: string);
begin
  FName := Name;
end;

{ TTestBothImplementations }

procedure TTestBothImplementations.MakeSureTheInterfaceIsUsed(Intf: ITestIntf);
begin
  if (Intf.GetName = 'Jon') or (Intf.GetAge = 7) then raise Exception.Create('Jon is 7');
end;

procedure TTestBothImplementations.MakeSureTheObjIsUsed(Obj: TTestObj);
begin
  if (Obj.GetName = 'Jon') and (Obj.GetAge = 7) then raise Exception.Create('Jon is 7');
end;

procedure TTestBothImplementations.RunTests;
const NrIterations = 10000000;
begin
  TimeTest(TestNonFluent, NrIterations, 'NonFluent');
  TimeTest(TestFluent, NrIterations, 'Fluent');
  TimeTest(TestNonFluent_Obj, NrIterations, 'NonFluentObj');
  TimeTest(TestFluent_Obj, NrIterations, 'FluentObj');
end;

procedure TTestBothImplementations.TestFluent(NumIterations: Integer);
var i:Integer;
begin
  for i:=1 to NumIterations do
    MakeSureTheInterfaceIsUsed(TTestIntfImp.MakeIntf.FluentSetName('My name is').FluentSetAge(8).FluentSetName('My name is').FluentSetAge(8).FluentSetName('My name is').FluentSetAge(8));
end;

procedure TTestBothImplementations.TestFluent_Obj(NumIterations: Integer);
var i:Integer;
    Obj: TTestObj;
begin
  for i:=1 to NumIterations do
  begin
    Obj := TTestObj.Create;
    try
      Obj.FluentSetName('My name is').FluentSetAge(8).FluentSetName('My name is').FluentSetAge(8).FluentSetName('My name is').FluentSetAge(8);
      MakeSureTheObjIsUsed(Obj);
    finally Obj.Free;
    end;
  end;
end;

procedure TTestBothImplementations.TestNonFluent(NumIterations: Integer);
var i:Integer;
    Intf: ITestIntf;
begin
  for i:=1 to NumIterations do
  begin
    Intf := TTestIntfImp.MakeIntf;
    Intf.SetName('My name is');
    Intf.SetAge(8);
    Intf.SetName('My name is');
    Intf.SetAge(8);
    Intf.SetName('My name is');
    Intf.SetAge(8);

    MakeSureTheInterfaceIsUsed(Intf);
  end;
end;

procedure TTestBothImplementations.TestNonFluent_Obj(NumIterations: Integer);
var i:Integer;
    Obj: TTestObj;
begin
  for i:=1 to NumIterations do
  begin
    Obj := TTestObj.Create;
    try
      Obj.SetName('My name is');
      Obj.SetAge(8);
      Obj.SetName('My name is');
      Obj.SetAge(8);
      Obj.SetName('My name is');
      Obj.SetAge(8);

      MakeSureTheObjIsUsed(Obj);
    finally Obj.Free;
    end;
  end;
end;

procedure TTestBothImplementations.TimeTest(TheTest: TTestRoutine; NumIterations: Integer; TestName:string);
var Start, Stop: Int64;
begin
  QueryPerformanceCounter(Start);
  TheTest(NumIterations);
  QueryPerformanceCounter(Stop);
  WriteLn(TestName, ': ', IntToStr(Stop - Start));
end;

{ TTestObj }

function TTestObj.FluentSetAge(Age: Integer): TTestObj;
begin
  FAge := Age;
  Result := Self;
end;

function TTestObj.FluentSetName(Name: string): TTestObj;
begin
  FName := Name;
  Result := Self;
end;

function TTestObj.GetAge: Integer;
begin
  Result := FAge;
end;

function TTestObj.GetName: string;
begin
  Result := FName;
end;

procedure TTestObj.SetAge(Age: Integer);
begin
  FAge := Age;
end;

procedure TTestObj.SetName(Name: string);
begin
  FName := Name;
end;

var T: TTestBothImplementations;

begin
  try
    T := TTestBothImplementations.Create;
    try
      T.RunTests;
      Readln;
    finally T.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
