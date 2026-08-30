unit GLE.Help;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.IniFiles,
  GLE.Resources, System.Types, System.UITypes, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Layouts, FMX.Memo, FMX.Memo.Types, FMX.ScrollBox, FMX.StdCtrls,
  FMX.Controls.Presentation, WinUI3.Form, Pixie.ControlBase.FMX,
  Pixie.CustomControl.FMX, Pixie.HtmlView.FMX.Base, Pixie.MarkdownView.FMX;

type
  TFrm_Help = class(TWinUIForm)
    Btn_Close: TButton;
    Chk_ShowTips: TCheckBox;
    Red_Help: TMemo;
    Layout1: TLayout;
    PixieMarkdownView1: TPixieMarkdownView;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    function Execute(aChecked: Boolean): Boolean;
  end;

implementation

uses
  GLE.Main, FMX.BehaviorManager;

{$R *.FMX}

function TFrm_Help.Execute(aChecked: Boolean): Boolean;
begin
  Chk_ShowTips.IsChecked := aChecked;
  ShowModal;
  Result := not (Chk_ShowTips.IsChecked);
end;

procedure TFrm_Help.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;

  //TranslateComponent(Self);
  Red_Help.ScrollAnimation := TBehaviorBoolean.True;
end;

procedure TFrm_Help.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
end;

procedure TFrm_Help.Btn_CloseClick(Sender: TObject);
begin
  Close;
end;

end.

