unit GLE.ConfigureNetwork;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.IniFiles,
  GLE.Resources, System.Types, System.UITypes, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Layouts, FMX.StdCtrls, FMX.Edit, Data.Bind.Components,
  FMX.Controls.Presentation, WinUI3.Form;

type
  TFrm_Network = class(TWinUIForm)
    Lbl_ScreenScraper: TLabel;
    Lbl_ScreenLogin: TLabel;
    Edt_ScreenLogin: TEdit;
    Edt_ScreenPwd: TEdit;
    Edt_ProxyServer: TEdit;
    Edt_ProxyPort: TEdit;
    Edt_ProxyUser: TEdit;
    Edt_ProxyPwd: TEdit;
    Lbl_ScreenPassword: TLabel;
    Lbl_ProxyPassword: TLabel;
    Lbl_ProxyUser: TLabel;
    Lbl_Host: TLabel;
    Lbl_Port: TLabel;
    Chk_Proxy: TCheckBox;
    Btn_Save: TButton;
    Btn_Cancel: TButton;
    Label1: TLabel;
    procedure Btn_SaveClick(Sender: TObject);
    procedure Btn_CancelClick(Sender: TObject);
    procedure Chk_ProxyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SaveToIni;
    procedure EnableControls(aValue: Boolean);
  public
    procedure Execute(const aSSId, aSSPwd, aProxUser, aProxPwd, aProxServer, aProxPort: string; aProxUse: Boolean);
  end;

implementation

uses
  System.IOUtils, GLE.Main;

{$R *.FMX}

procedure TFrm_Network.Execute(const aSSId, aSSPwd, aProxUser, aProxPwd, aProxServer, aProxPort: string; aProxUse: Boolean);
begin
  Edt_ScreenLogin.Text := aSSId;
  Edt_ScreenPwd.Text := aSSPwd;
  Edt_ProxyUser.Text := aProxUser;
  Edt_ProxyPwd.Text := aProxPwd;
  Edt_ProxyServer.Text := aProxServer;
  Edt_ProxyPort.Text := aProxPort;
  Chk_Proxy.IsChecked := aProxUse;
  EnableControls(aProxUse);
  ShowModal;
end;

procedure TFrm_Network.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;
  //TranslateComponent(Self);
end;

procedure TFrm_Network.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
end;

procedure TFrm_Network.Chk_ProxyClick(Sender: TObject);
begin
  EnableControls(Chk_Proxy.IsChecked);
end;

procedure TFrm_Network.EnableControls(aValue: Boolean);
begin
  Edt_ProxyPort.Enabled := aValue;
  Edt_ProxyPwd.Enabled := aValue;
  Edt_ProxyUser.Enabled := aValue;
  Edt_ProxyServer.Enabled := aValue;
  Lbl_Host.Enabled := aValue;
  Lbl_ProxyUser.Enabled := aValue;
  Lbl_Port.Enabled := aValue;
  Lbl_ProxyPassword.Enabled := aValue;
end;

procedure TFrm_Network.Btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm_Network.SaveToIni;
var
  FileIni: TIniFile;
begin
  FileIni := TIniFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath));
  try
    FileIni.WriteString(Cst_IniOptions, Cst_IniSSUser, Edt_ScreenLogin.Text);
    FileIni.WriteString(Cst_IniOptions, Cst_IniSSPwd, Edt_ScreenPwd.Text);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyUser, Edt_ProxyUser.Text);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyPwd, Edt_ProxyPwd.Text);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyServer, Edt_ProxyServer.Text);
    if (Edt_ProxyPort.Text = '') then
      FileIni.WriteString(Cst_IniOptions, Cst_IniProxyPort, '0')
    else
      FileIni.WriteString(Cst_IniOptions, Cst_IniProxyPort, Edt_ProxyPort.Text);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniProxyUse, Chk_Proxy.IsChecked);
  finally
    FileIni.Free;
  end;
end;

procedure TFrm_Network.Btn_SaveClick(Sender: TObject);
begin
  SaveToIni;
  Close;
end;

end.

