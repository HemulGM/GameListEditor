unit GLE.NameEditor;

interface

uses
  System.SysUtils, System.Variants, System.Classes, GLE.Resources, System.Types,
  System.UITypes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Layouts, FMX.StdCtrls,
  FMX.Edit, Data.Bind.Components, FMX.Controls.Presentation, WinUI3.Form,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.EditBox, FMX.NumberBox;

type
  TFormNameEditor = class(TWinUIForm)
    ButtonApply: TButton;
    ButtonCancel: TButton;
    Panel1: TPanel;
    LabelCharacters: TLabel;
    LabelEndChars: TLabel;
    CheckBoxDeleteChars: TCheckBox;
    Panel2: TPanel;
    LabelBeginning: TLabel;
    LabelEnd: TLabel;
    CheckBoxAdd: TCheckBox;
    EditStartString: TEdit;
    EditEndString: TEdit;
    PanelCase: TPanel;
    CheckBoxCase: TCheckBox;
    RadioButtonFirstChar: TRadioButton;
    RadioButtonUpper: TRadioButton;
    RadioButtonLower: TRadioButton;
    Panel4: TPanel;
    LabelPreview: TLabel;
    MemoPreview: TMemo;
    NumberBoxChars: TNumberBox;
    NumberBoxCharsEnd: TNumberBox;
    Panel3: TPanel;
    CheckBoxReplace: TCheckBox;
    EditReplaceFind: TEdit;
    EditReplace: TEdit;
    LabelReplaceFind: TLabel;
    LabelReplaceReplace: TLabel;
    CheckBoxReplaceCase: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateChanges(Sender: TObject);
  private
    FPreviewStr: string;
    function GetLambdaFunc: TFunc<string, string>;
  public
    function Execute(out Lambda: TFunc<string, string>; const APreview: string): Boolean;
  end;

implementation

uses
  GLE.Main, System.Character;

{$R *.FMX}

procedure TFormNameEditor.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;
end;

function TFormNameEditor.Execute(out Lambda: TFunc<string, string>; const APreview: string): Boolean;
begin
  FPreviewStr := APreview;
  MemoPreview.Text := FPreviewStr;
  UpdateChanges(nil);
  Result := ShowModal = mrOk;
  if not Result then
    Exit;
end;

procedure TFormNameEditor.UpdateChanges(Sender: TObject);
begin
  NumberBoxChars.Enabled := CheckBoxDeleteChars.IsChecked;
  NumberBoxCharsEnd.Enabled := CheckBoxDeleteChars.IsChecked;
  LabelCharacters.Enabled := CheckBoxDeleteChars.IsChecked;
  LabelEndChars.Enabled := CheckBoxDeleteChars.IsChecked;
  LabelReplaceFind.Enabled := CheckBoxReplace.IsChecked;
  LabelReplaceReplace.Enabled := CheckBoxReplace.IsChecked;
  EditReplace.Enabled := CheckBoxReplace.IsChecked;
  EditReplaceFind.Enabled := CheckBoxReplace.IsChecked;
  RadioButtonFirstChar.Enabled := CheckBoxCase.IsChecked;
  RadioButtonUpper.Enabled := CheckBoxCase.IsChecked;
  RadioButtonLower.Enabled := CheckBoxCase.IsChecked;
  EditStartString.Enabled := CheckBoxAdd.IsChecked;
  EditEndString.Enabled := CheckBoxAdd.IsChecked;
  LabelBeginning.Enabled := CheckBoxAdd.IsChecked;
  LabelEnd.Enabled := CheckBoxAdd.IsChecked;
  MemoPreview.Text := GetLambdaFunc()(FPreviewStr);
end;

procedure TFormNameEditor.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
end;

function TFormNameEditor.GetLambdaFunc: TFunc<string, string>;
begin
  var RemChars := CheckBoxDeleteChars.IsChecked;
  var AddChars := CheckBoxAdd.IsChecked;
  var ChangeCase := CheckBoxCase.IsChecked;
  var CaseIndex := 0;
  if RadioButtonFirstChar.IsChecked then
    CaseIndex := 0
  else if RadioButtonUpper.IsChecked then
    CaseIndex := 1
  else if RadioButtonLower.IsChecked then
    CaseIndex := 2;
  var StringStart := EditStartString.Text;
  var StringEnd := EditEndString.Text;
  var NbStart := Trunc(NumberBoxChars.Value);
  var NbEnd := Trunc(NumberBoxCharsEnd.Value);
  var Replace := CheckBoxReplace.IsChecked and not EditReplaceFind.Text.IsEmpty;
  var ReplaceFind := EditReplaceFind.Text;
  var ReplaceText := EditReplace.Text;
  var ReplaceFlags: TReplaceFlags := [TReplaceFlag.rfReplaceAll, TReplaceFlag.rfIgnoreCase];
  if CheckBoxReplaceCase.IsChecked then
    ReplaceFlags := ReplaceFlags - [TReplaceFlag.rfIgnoreCase];

  Result :=
    function(Source: string): string
    begin
      Result := Source;

      if Result.IsEmpty then
        Exit;

      if Replace then
      begin
        Result := Result.Replace(ReplaceFind, ReplaceText, ReplaceFlags);
      end;

      if Result.IsEmpty then
        Exit;

      if RemChars then
      begin
        if NbStart <> 0 then
          Result := Copy(Result, Succ(NbStart), Result.Length - NbStart);
        if NbEnd <> 0 then
          SetLength(Result, Result.Length - NbEnd);
      end;

      if ChangeCase then
      begin
        case CaseIndex of
          0:
            Result[1] := Result[1].ToUpper;
          1:
            Result := Result.ToUpper;
          2:
            Result := Result.ToLower;
        end;
      end;

      if AddChars then
      begin
        if StringStart <> '' then
          Result := StringStart + Result;
        if StringEnd <> '' then
          Result := Result + StringEnd;
      end;
    end;
end;

end.

