unit GLE.MoreInfos;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.DateUtils, GLE.Game,
  System.Types, System.UITypes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Layouts,
  FMX.StdCtrls, FMX.Edit, Data.Bind.Components, FMX.Controls.Presentation,
  WinUI3.Form;

type
  TFormMorInfos = class(TWinUIForm)
    Btn_Close: TButton;
    Edt_Playcount: TEdit;
    Edt_LastPlayed: TEdit;
    Edt_Crc32: TEdit;
    Edt_Md5: TEdit;
    Edt_Sha1: TEdit;
    Lbl_Playcount: TLabel;
    Lbl_LastPlayed: TLabel;
    Lbl_Crc32: TLabel;
    Lbl_Md5: TLabel;
    Lbl_Sha1: TLabel;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    procedure Execute(aGame: TGame);
  end;

implementation

uses
  GLE.Main;

{$R *.FMX}

procedure TFormMorInfos.Execute(aGame: TGame);
begin
  Edt_Playcount.Text := aGame.PlayCount;
  if not aGame.Lastplayed.IsEmpty then
    Edt_LastPlayed.Text := FormatDateTime('dd/mm/yyyy hh:mm:ss', ISO8601ToDate(aGame.Lastplayed))
  else
    Edt_LastPlayed.Text := '';
  Edt_Crc32.Text := aGame.Crc32;
  Edt_Md5.Text := aGame.Md5;
  Edt_Sha1.Text := aGame.Sha1;

  ShowModal;
end;

procedure TFormMorInfos.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;
  //TranslateComponent(Self);
end;

procedure TFormMorInfos.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
end;

procedure TFormMorInfos.Btn_CloseClick(Sender: TObject);
begin
  Close;
end;

end.

