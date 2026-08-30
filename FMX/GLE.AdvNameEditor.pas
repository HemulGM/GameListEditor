unit GLE.AdvNameEditor;

interface

uses
  System.SysUtils, System.Variants, System.Classes, GLE.Resources, System.Types,
  System.UITypes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Layouts, FMX.StdCtrls,
  FMX.Edit, Data.Bind.Components, FMX.Controls.Presentation, WinUI3.Form,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.EditBox, FMX.NumberBox;

type
  TFormAdvNameEditor = class(TWinUIForm)
    Btn_Apply: TButton;
    Btn_Cancel: TButton;
    Panel1: TPanel;
    Lbl_Characters: TLabel;
    Lbl_EndChars: TLabel;
    Chk_DeleteChars: TCheckBox;
    Panel2: TPanel;
    Lbl_Beginning: TLabel;
    Lbl_End: TLabel;
    Chk_Add: TCheckBox;
    Edt_StartString: TEdit;
    Edt_EndString: TEdit;
    PanelCase: TPanel;
    Chk_Case: TCheckBox;
    RadioButtonFirstChar: TRadioButton;
    RadioButtonUpper: TRadioButton;
    RadioButtonLower: TRadioButton;
    Panel4: TPanel;
    Lbl_Preview: TLabel;
    MemoPreview: TMemo;
    NumberBoxChars: TNumberBox;
    NumberBoxCharsEnd: TNumberBox;
    procedure Edt_NbCharsChange(Sender: TObject);
    procedure Edt_NbCharsEndChange(Sender: TObject);
    procedure Edt_StartStringChange(Sender: TObject);
    procedure Edt_EndStringChange(Sender: TObject);
    procedure Rdg_CaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Chk_CaseChange(Sender: TObject);
    procedure Chk_DeleteCharsChange(Sender: TObject);
    procedure Chk_AddChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FPreviewStr: string;
    procedure ProcessPreview;
  public
    function Execute(out aRemChars, aAddChars, aChangeCase: Boolean; out aNbStart, aNbEnd, aCaseIndex: Integer; out aStringStart, aStringEnd: string; const aPreview: string): Boolean;
  end;

implementation

uses
  GLE.Main;

{$R *.FMX}

procedure TFormAdvNameEditor.Edt_EndStringChange(Sender: TObject);
begin
  ProcessPreview;
end;

procedure TFormAdvNameEditor.Edt_NbCharsChange(Sender: TObject);
begin
  ProcessPreview;
end;

procedure TFormAdvNameEditor.Edt_NbCharsEndChange(Sender: TObject);
begin
  ProcessPreview;
end;

procedure TFormAdvNameEditor.Edt_StartStringChange(Sender: TObject);
begin
  ProcessPreview;
end;

procedure TFormAdvNameEditor.Rdg_CaseClick(Sender: TObject);
begin
  ProcessPreview;
end;

function TFormAdvNameEditor.Execute(out aRemChars, aAddChars, aChangeCase: Boolean; out aNbStart, aNbEnd, aCaseIndex: Integer; out aStringStart, aStringEnd: string; const aPreview: string): Boolean;
begin
  FPreviewStr := aPreview;
  MemoPreview.Text := FPreviewStr;
  ShowModal;
  Result := (ModalResult = mrOk);
  if (ModalResult = mrOk) then
  begin
    aRemChars := Chk_DeleteChars.IsChecked;
    aAddChars := Chk_Add.IsChecked;
    aChangeCase := Chk_Case.IsChecked;
    if RadioButtonFirstChar.IsChecked then
      aCaseIndex := 0
    else if RadioButtonUpper.IsChecked then
      aCaseIndex := 1
    else if RadioButtonLower.IsChecked then
      aCaseIndex := 2;

    aStringStart := Edt_StartString.Text;
    aStringEnd := Edt_EndString.Text;
    if (NumberBoxChars.Value = 0) then
      aNbStart := 0
    else
      aNbStart := Trunc(NumberBoxChars.Value);
    if (NumberBoxCharsEnd.Value = 0) then
      aNbEnd := 0
    else
      aNbEnd := Trunc(NumberBoxCharsEnd.Value);
  end;
end;

procedure TFormAdvNameEditor.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;
  //TranslateComponent(Self);
end;

procedure TFormAdvNameEditor.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
end;

procedure TFormAdvNameEditor.Chk_AddChange(Sender: TObject);
begin
  Edt_StartString.Enabled := Chk_Add.IsChecked;
  Edt_EndString.Enabled := Chk_Add.IsChecked;
  Lbl_Beginning.Enabled := Chk_Add.IsChecked;
  Lbl_End.Enabled := Chk_Add.IsChecked;
  ProcessPreview;
end;

procedure TFormAdvNameEditor.Chk_CaseChange(Sender: TObject);
begin
  RadioButtonFirstChar.Enabled := Chk_Case.IsChecked;
  RadioButtonUpper.Enabled := Chk_Case.IsChecked;
  RadioButtonLower.Enabled := Chk_Case.IsChecked;
  ProcessPreview;
end;

procedure TFormAdvNameEditor.Chk_DeleteCharsChange(Sender: TObject);
begin
  NumberBoxChars.Enabled := Chk_DeleteChars.IsChecked;
  NumberBoxCharsEnd.Enabled := Chk_DeleteChars.IsChecked;
  Lbl_Characters.Enabled := Chk_DeleteChars.IsChecked;
  Lbl_EndChars.Enabled := Chk_DeleteChars.IsChecked;
  ProcessPreview;
end;

procedure TFormAdvNameEditor.ProcessPreview;
var
  NbStart, NbEnd: Integer;
  TmpStr: string;
begin
  MemoPreview.Text := FPreviewStr;
  TmpStr := FPreviewStr;

  if Chk_DeleteChars.IsChecked then
  begin
    if (NumberBoxChars.Value <> 0) then
    begin
      NbStart := Trunc(NumberBoxChars.Value);
      TmpStr := Copy(TmpStr, Succ(NbStart), (TmpStr.Length - NbStart));
    end;
    if (NumberBoxCharsEnd.Value <> 0) then
    begin
      NbEnd := Trunc(NumberBoxCharsEnd.Value);
      SetLength(TmpStr, TmpStr.Length - NbEnd);
    end;
  end;

  if Chk_Case.IsChecked then
  begin
    var aCaseIndex: Integer;
    if RadioButtonFirstChar.IsChecked then
      aCaseIndex := 0
    else if RadioButtonUpper.IsChecked then
      aCaseIndex := 1
    else
      aCaseIndex := 2;
    case aCaseIndex of
      0:
        begin
          TmpStr[1] := UpCase(TmpStr[1]);
        end;
      1:
        begin
          TmpStr := UpperCase(TmpStr);
        end;
      2:
        begin
          TmpStr := LowerCase(TmpStr);
        end;
    end;
  end;

  if Chk_Add.IsChecked then
  begin
    if (Edt_StartString.Text <> '') then
    begin
      TmpStr := Edt_StartString.Text + TmpStr;
    end;
    if (Edt_EndString.Text <> '') then
    begin
      TmpStr := TmpStr + Edt_EndString.Text;
    end;
  end;

  MemoPreview.Text := TmpStr;
end;

end.

