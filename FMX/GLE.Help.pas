unit GLE.Help;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.IniFiles,
  GLE.Resources, System.Types, System.UITypes, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Layouts, FMX.Memo, FMX.Memo.Types, FMX.ScrollBox, FMX.StdCtrls,
  FMX.Controls.Presentation, WinUI3.Form, Pixie.ControlBase.FMX,
  Pixie.CustomControl.FMX, Pixie.HtmlView.FMX.Base, Pixie.MarkdownView.FMX,
  Markdown4D.Fmx.Viewer;

type
  TFormHelp = class(TWinUIForm)
    Btn_Close: TButton;
    Chk_ShowTips: TCheckBox;
    Layout1: TLayout;
    MarkdownViewerHelp: TMarkdownViewer;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  protected
    procedure DoOnSettingChange; override;
  public
    function Execute(aChecked: Boolean): Boolean;
  end;

implementation

uses
  GLE.Main, FMX.BehaviorManager, Markdown4D.Theme;

{$R *.FMX}

procedure TFormHelp.DoOnSettingChange;
begin
  inherited;
  if IsDark then
  begin
    MarkdownViewerHelp.ThemePreset := TMarkdownThemePreset.Dark;
  end
  else
  begin
    MarkdownViewerHelp.ThemePreset := TMarkdownThemePreset.Light;
  end;
  MarkdownViewerHelp.Theme.BackgroundColor := TAlphaColors.Null;
end;

function TFormHelp.Execute(aChecked: Boolean): Boolean;
begin
  Chk_ShowTips.IsChecked := aChecked;
  ShowModal;
  Result := not (Chk_ShowTips.IsChecked);
end;

procedure TFormHelp.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;
end;

procedure TFormHelp.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
end;

procedure TFormHelp.Btn_CloseClick(Sender: TObject);
begin
  Close;
end;

end.

