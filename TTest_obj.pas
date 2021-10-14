unit TTest_obj;

interface

type

  TTestObj = class
  protected
    FName: string;
    FAge : Integer;
  public
    function FluentSetName(Name:string) : TTestObj;
    function FluentSetAge (Age :Integer): TTestObj;
    function Id                         : TTestObj;
  end;

implementation

{ TTestObj }

function TTestObj.Id : TTestObj;
begin
  Result := Self;
end;

function TTestObj.FluentSetAge(Age: Integer): TTestObj;
begin
  FAge := Age;     writeln(age,'  ');  Result := Self;
end;

function TTestObj.FluentSetName(Name: string): TTestObj;
begin
  FName := Name;   write(name,'  ');   Result := Self;
end;

end.
