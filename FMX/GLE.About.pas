unit GLE.About;

interface

uses
  System.SysUtils, System.Variants, System.Classes, GLE.Resources, System.Types,
  System.UITypes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Layouts, FMX.Memo,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Controls.Presentation, FMX.StdCtrls,
  WinUI3.Form;

type
  TFrm_About = class(TWinUIForm)
    Red_About: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
      { Dйclarations privйes }
  public
    procedure Execute;
  end;

implementation

uses
  GLE.Main;

{$R *.FMX}

const
  AURL_ENABLEURL = 1;
  AURL_ENABLEEAURLS = 8;

procedure TFrm_About.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;
 // TranslateComponent(Self);
  Red_About.Lines.Add(Rst_Text);
end;

procedure TFrm_About.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
end;

procedure TFrm_About.Execute;
begin
  ShowModal;
end;

end.

