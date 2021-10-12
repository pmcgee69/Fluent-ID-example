unit TTest_intf;

interface
uses
   U_fluent_intf;
type

  TTestIntfImp = class(TInterfacedObject, ITestIntf)
  protected
    FName: string;
    FAge : Integer;
  public
    function FluentSetName(Name:string) : ITestIntf;
    function FluentSetAge (Age :Integer): ITestIntf;
    function Id                         : ITestIntf;

    class function MakeIntf             : ITestIntf;
  end;

implementation

{ TTestIntfImp }

class function TTestIntfImp.MakeIntf: ITestIntf;
begin
  Result := TTestIntfImp.Create as ITestIntf;
end;

function TTestIntfImp.Id : ITestIntf;
begin
  Result := Self;
end;


function TTestIntfImp.FluentSetAge(Age: Integer): ITestIntf;
begin
  FAge := Age;     writeln(age,'  ');  Result := Self;
end;

function TTestIntfImp.FluentSetName(Name: string): ITestIntf;
begin
  FName := Name;   writeln(name,'  '); Result := Self;
end;

end.
