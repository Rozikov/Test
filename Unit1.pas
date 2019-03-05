unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
  ControllersUnit, PhisicsControllerUnit, Vcl.StdCtrls, Data.DB, Data.Win.ADODB;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    Button1: TButton;
    list: Tlist<string>;
    Buttons: Tlist<TButton>; // страница 128
    // Labels: Tlist<TLabel>;
    /// <link>aggregation</link>
    Controller1: Controllers;
    procedure destroysButtons;
    // procedure destroysLabels;
    procedure createPanels(list: Tlist<String>);
  public
    procedure onClick(Sender: TObject);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.createPanels(list: Tlist<String>);
var
  i: integer;
  s: string;
begin
  i := 0;
  Buttons := Tlist<TButton>.Create;
  self.list := Tlist<string>.Create;
  self.list := list;
  for s in list do
  begin
    Buttons.Add(TButton.Create(self));
    with Buttons.Last do
    begin
      Parent := self;
      Top := i * 41;
      Caption := s;
      Width := 300;
      onClick := onClick;
    end;
    i := i + 1;
  end;
end;

procedure TForm1.destroysButtons;
{var
  s: string;}
begin
  {for s in list do
  begin
    with Buttons.Last do
    begin
      Parent := nil;
      Destroy;
    end;
  end;}
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  list: Tlist<string>;
begin
  Controller1 := PhisicsController.Create;
  list := Tlist<string>.Create;
  list := Controller1.getMenu;
  createPanels(list);
  // createPanels(Controller1.getMenu);
end;

procedure TForm1.onClick(Sender: TObject);
var
  quest: Tlist<string>;
  answers: Tlist<string>;
  correct: TDictionary<integer, integer>;
begin
  Controller1.setTest((Sender as TButton).Caption);
  destroysButtons;
  quest := Tlist<string>.Create;
  answers := Tlist<string>.Create;
  correct := TDictionary<integer, integer>.Create;
  quest := Controller1.getQuest;
  answers := Controller1.getAnswer;
  correct := Controller1.getCorrect;
end;

end.
