unit AccessAdapterUnit;

interface

uses
  SysUtils,
  Data.DB,
  Data.Win.ADODB,
  System.Generics.Collections,
  Adaptersunit;

type
  AccessAdapter = class(TInterfacedObject, Adapters)
  private
    Caption: string;
    ADOConnection: TADOConnection;
    function getMenu: TList<string>;
    procedure setTest(Caption: string);
    function getQuest: TList<string>;
    function getAnswer: TList<string>;
    function getCorrect: TDictionary<integer, integer>;
  published
    constructor create;
  end;

implementation

{ AccessAdapter }

constructor AccessAdapter.create;
begin
  ADOConnection := TADOConnection.create(nil);
  with (ADOConnection) do
  begin
    Provider := 'Microsoft.ACE.OLEDB.12.0';
    Mode := cmShareDenyNone;
    LoginPrompt := False;
    ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;' +
      'Data Source=Phisics.accdb;' + 'Persist Security Info=False';
    Connected := True;
    //  Provider=Microsoft.ACE.OLEDB.12.0;
    //Data Source=Phisics.accdb;
    //Persist Security Info=False
  end;
end;

function AccessAdapter.getAnswer: TList<string>;
begin

end;

function AccessAdapter.getCorrect: TDictionary<integer, integer>;
var
  ADOQuery: TADOQuery;
  correct: string;
begin
  result := TDictionary<integer, integer>.create;
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT correct FROM Main WHERE caption="' + self.Caption + '";');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  correct := ADOQuery.FieldByName('caption').AsString;
  with (ADOQuery) do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT quest_id, answer_id FROM' + correct + ';');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  While not ADOQuery.Eof do
  begin
    result.Add(StrToInt(ADOQuery.FieldByName('quest_id').AsString),
      StrToInt(ADOQuery.FieldByName('anser_id').AsString));
    ADOQuery.Next;
  end;
  ADOQuery.Free;
end;

function AccessAdapter.getMenu: TList<string>;
var
  ADOQuery: TADOQuery;
  answer: string;
  // DtaSource: TDataSource;  121 страница
begin
  result := TList<string>.create;
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT answer FROM Main Where caption="' + self.Caption + '";');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  answer := ADOQuery.FieldByName('answer').AsString;
  with (ADOQuery) do
  // while not ADOQuery.Eof do     121 страница
  begin
    Close;
    SQL.Clear;
    //SQL.Add('SELECT caption FROM ' + answer + ';'); !!!!!!!!!!!!!!!!!!!!!!!
    SQL.Add('SELECT caption FROM Answer1;');
    Open;
    Active := True;
  end;
  while not ADOQuery.Eof do
  begin
    result.Add(ADOQuery.FieldByName('caption').AsString);
    ADOQuery.Next;
  end;
  ADOQuery.Free;
end;

function AccessAdapter.getQuest: TList<string>;
var
  ADOQuery: TADOQuery;
  quest: string;
begin
  result := TList<string>.create;
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT quest FROM Main WHERE caption="' + self.Caption + '";');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  quest := ADOQuery.FieldByName('quset').AsString;
  with (ADOQuery) do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT caption FROM ' + quest + ';');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  while not ADOQuery.Eof do
  begin
    result.Add(ADOQuery.FieldByName('caption').AsString);
    ADOQuery.Next;
  end;
  ADOQuery.Free;
end;

procedure AccessAdapter.setTest(Caption: string);
begin
  self.Caption := Caption;
end;

end.
