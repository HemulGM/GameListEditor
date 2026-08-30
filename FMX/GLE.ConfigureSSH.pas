unit GLE.ConfigureSSH;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Types, System.UITypes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Layouts, FMX.StdCtrls, FMX.Edit,
  Data.Bind.Components, FMX.Controls.Presentation, WinUI3.Form;

type
  TFrm_ConfigureSSH = class(TWinUIForm)
    Lbl_RecalLogin: TLabel;
    Lbl_RecalPwd: TLabel;
    Lbl_RetroPwd: TLabel;
    Lbl_RetroLogin: TLabel;
    Edt_RecalLogin: TEdit;
    Edt_RecalPwd: TEdit;
    Edt_RetroLogin: TEdit;
    Edt_RetroPwd: TEdit;
    Btn_Save: TButton;
    Btn_Cancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Dйclarations privйes }
  public
    function Execute(var aRecalLogin, aRecalPwd, aRetroLogin, aRetroPwd: string): Boolean;
  end;

implementation

uses
  GLE.Main;

{$R *.FMX}

//On passe les paramиtres en var pour rйcupйrer les changements directement

function TFrm_ConfigureSSH.Execute(var aRecalLogin, aRecalPwd, aRetroLogin, aRetroPwd: string): Boolean;
begin
  Edt_RecalLogin.Text := aRecalLogin;
  Edt_RecalPwd.Text := aRecalPwd;
  Edt_RetroLogin.Text := aRetroLogin;
  Edt_RetroPwd.Text := aRetroPwd;

  ShowModal;

  Result := (ModalResult = mrOk);

   //si on a cliquй sur Ok, on change les valeurs des paramиtres
   //pour renvoyer dans la fenкtre principale
  if Result then
  begin
    aRecalLogin := Edt_RecalLogin.Text;
    aRecalPwd := Edt_RecalPwd.Text;
    aRetroLogin := Edt_RetroLogin.Text;
    aRetroPwd := Edt_RetroPwd.Text;
  end;
end;

procedure TFrm_ConfigureSSH.FormCreate(Sender: TObject);
begin
  SubscribeToChangeStyleBook := True;
  StyleBook := FormMain.StyleBook;
  //TranslateComponent(Self);
end;

//а lapparition de la fenкtre on met le focus sur cancel
procedure TFrm_ConfigureSSH.FormShow(Sender: TObject);
begin
  DoOnSettingChange;
  Btn_Cancel.SetFocus;
end;

end.

