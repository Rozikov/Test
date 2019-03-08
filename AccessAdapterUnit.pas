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
    // QUEST
    function getQuestTabel(Quest: string): TList<string>;
    function getQuestTabelname: string;
    // CORRECT
    function getCorrectTabel(Correct: string): TDictionary<integer, integer>;
    function getCorrectTabelname: string;
    // ANSWER
    function getAnswerTabel(Answer: string): TList<string>;
    function getAnswerTabelname: string;

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
    // Provider=Microsoft.ACE.OLEDB.12.0;
    // Data Source=Phisics.accdb;
    // Persist Security Info=False
  end;
end;

// GET ANSWER
function AccessAdapter.getAnswer: TList<string>;
var
  ADOQuery: TADOQuery;
  Answer: string;
begin
  Answer := getAnswerTabelname;
  result := getAnswerTabel(Answer);
end;

// ANSWER TABEL
function AccessAdapter.getAnswerTabel(Answer: string): TList<string>;
var
  ADOQuery: TADOQuery;
begin
  result := TList<string>.create;
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT answer FROM Main WHERE caption="' + Self.Caption + '";');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  Answer := 'Answer1';
  with (ADOQuery) do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT caption FROM ' + Answer + ';');
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

// GET ANSWER TABEL NAME
function AccessAdapter.getAnswerTabelname: string;
var
  ADOQuery: TADOQuery;
begin
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT answer FROM Main WHERE caption="' + Self.Caption + '";');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  result := 'Answer1';

end;

// GET CORRECT
function AccessAdapter.getCorrect: TDictionary<integer, integer>;
var
  Correct: string;
begin
  Correct := getCorrectTabelname;
  result := getCorrectTabel(Correct);
end;

// CORRECT TABEL
function AccessAdapter.getCorrectTabel(Correct: string)
  : TDictionary<integer, integer>;
var
  ADOQuery: TADOQuery;
begin
  result := TDictionary<integer, integer>.create;
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT quest_id, answer_id FROM' + Correct + ';');
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

// CORRECT TABEL NAME
function AccessAdapter.getCorrectTabelname: string;
var
  ADOQuery: TADOQuery;
begin
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT correct FROM Main WHERE caption="' + Self.Caption + '";');
    Open;
    Active := True;
  end;
  result := ADOQuery.FieldByName('caption').AsString;
  ADOQuery.Free;

end;

function AccessAdapter.getMenu: TList<string>;
var
  ADOQuery: TADOQuery;
  Answer: string;
  // DtaSource: TDataSource;  121 страница
begin
  result := TList<string>.create;
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT answer FROM Main Where caption="' + Self.Caption + '";');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  Answer := ADOQuery.FieldByName('answer').AsString;
  with (ADOQuery) do
  // while not ADOQuery.Eof do     121 страница
  begin
    Close;
    SQL.Clear;
    // SQL.Add('SELECT caption FROM ' + answer + ';'); !!!!!!!!!!!!!!!!!!!!!!!
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

// QUEST
function AccessAdapter.getQuest: TList<string>;
var
  ADOQuery: TADOQuery;
  Quest: string;
begin
  Quest := getQuestTabelname;
  result := getQuestTabel(Quest);
end;

// QUEST TABEL
function AccessAdapter.getQuestTabel(Quest: string): TList<string>;
VAR
  ADOQuery: TADOQuery;
begin
  result := TList<string>.create;
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT caption FROM ' + Quest + ';');
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

// QUEST TABEL NAME
function AccessAdapter.getQuestTabelname: string;
VAR
  ADOQuery: TADOQuery;
begin
  ADOQuery := TADOQuery.create(nil);
  with (ADOQuery) do
  begin
    Connection := ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT quest FROM Main WHERE caption="' + Self.Caption + '";');
    Open;
    Active := True;
  end;
  ADOQuery.First;
  result := ADOQuery.FieldByName('quset').AsString;
  ADOQuery.Free;

end;

procedure AccessAdapter.setTest(Caption: string);
begin
  Self.Caption := Caption;
end;

end.
