unit TTest_rec;

interface

type
  TRecObj = record
    fname : string;
    fage  : integer;
    function FluentSetAge(Age: Integer): TRecObj;
    function FluentSetName(Name: string): TRecObj;
    function id : TRecObj;
  end;

implementation

{ TRecObj }

function TRecObj.Id : TRecObj;
begin
  Result := Self;
end;

function TRecObj.FluentSetAge(Age: Integer): TRecObj;
begin
  FAge := Age;     writeln(age,'  ');  Result := Self;
end;

function TRecObj.FluentSetName(Name: string): TRecObj;
begin
  FName := Name;   write(name,'  ');   Result := Self;
end;

end.
