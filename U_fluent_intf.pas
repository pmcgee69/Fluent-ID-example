unit U_fluent_intf;

interface

type

  ITestIntf = interface
    function FluentSetName(Name:string) : ITestIntf;
    function FluentSetAge (Age :Integer): ITestIntf;
    function Id                         : ITestIntf;
  end;

implementation

end.
