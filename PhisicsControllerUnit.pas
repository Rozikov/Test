unit PhisicsControllerUnit;

interface

uses
  Test1Unit,
  TestsUnit,
  ControllersUnit,
  System.Generics.Collections,
  MainUnit,
  MenuUnit;

type
  PhisicsController = class(TInterfacedObject, Controllers)
  private
    Test: Tests;
    /// <link>aggregation</link>
    Menu1: Main;
  public
    procedure setTest(Caption: string);
    function getMenu: TList<string>;
    function getQuest: TList<string>;
    function getAnswer: TList<string>;
    function getCorrect: TDictionary<integer, integer>;
  end;

implementation

function PhisicsController.getAnswer: TList<string>;
begin
  result := TList<string>.create;
  result := Test.getAnswer;
end;

function PhisicsController.getCorrect: TDictionary<integer, integer>;
begin
  result := TDictionary<integer, integer>.create;
  // result := TList<string>.create;
  result := Test.getCorrect;
end;

function PhisicsController.getMenu: TList<string>;
begin
  result := TList<string>.create;
  Menu1 := Menu.create;
  result := Menu1.getMenu;

end;

function PhisicsController.getQuest: TList<string>;
begin
  result := TList<string>.create;
  result := Test.getQuest;
end;

procedure PhisicsController.setTest(Caption: string);

begin
  Test := Test1.create;
  Test.setTest(Caption);
end;

end.
