unit Test1Unit;

interface

uses
  AccessAdapterUnit,
  System.Generics.Collections,
  AdaptersUnit,
  TestsUnit;

type
  Test1 = class(TInterfacedObject, Tests)
  private
    Adapter: Adapters;
  public
    procedure setTest(Caption: string);
    function getQuest: TList<string>;
    function getAnswer: TList<string>;
    function getCorrect: TDictionary<integer, integer>;
  published
    constructor create;
  end;

implementation

{ Test1 }

constructor Test1.create;
begin
  Adapter := AccessAdapter.create;
end;

function Test1.getAnswer: TList<string>;
begin
  result := Adapter.getAnswer;
end;

function Test1.getCorrect: TDictionary<integer, integer>;
begin
  result := Adapter.getCorrect;
end;

function Test1.getQuest: TList<string>;
begin
  result := Adapter.getQuest;
end;

procedure Test1.setTest(Caption: string);
begin
  Adapter.setTest(Caption);
end;

end.
