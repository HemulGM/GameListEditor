unit GLE.Main;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.IniFiles,
  System.Generics.Collections, System.RegularExpressions, System.UITypes,
  System.ImageList, System.StrUtils, System.SyncObjs, Xml.omnixmldom, Xml.xmldom,
  Xml.XMLIntf, Xml.XMLDoc, GLE.Help, GLE.Resources, GLE.Game, GLE.NameEditor,
  GLE.DownloadThread, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Types, FMX.Types, FMX.Graphics,
  FMX.Controls, FMX.Forms, FMX.Layouts, FMX.StdCtrls, FMX.Memo, FMX.Edit,
  FMX.Menus, FMX.ScrollBox, FMX.Memo.Types, FMX.Dialogs, FMX.ImgList,
  FMX.ListBox, FMX.Objects, FMX.TabControl, FMX.Filter.Effects,
  FMX.Controls.Presentation, FmxPasLibVlcPlayerUnit, FMX.SearchBox,
  DX.Pdf.Viewer.FMX, WinUI3.Form, FMX.Colors, FMX.ExtCtrls, FMX.Effects, FMX.Ani,
  FMX.EditBox, FMX.NumberBox, Pixie.ControlBase.FMX, Pixie.CustomControl.FMX,
  Pixie.HtmlView.FMX.Base, Pixie.MarkdownView.FMX, Markdown4D.Fmx.Viewer;

type
  TMediaInfo = class
    FileExt: string;
    FileLink: string;
  end;

  TListBoxItemSystem = class(TListBoxItem)
  public
    SystemKind: TSystemKind;
  end;

  TListBoxItemGame = class(TListBoxItem)
  public
    Game: TGame;
  end;

  TFormMain = class(TWinUIForm)
    TabControlEditor: TTabControl;
    TabItemEditGame: TTabItem;
    TabItemEditScrape: TTabItem;
    Lbl_Name: TLabel;
    Lbl_Region: TLabel;
    Lbl_Date: TLabel;
    Lbl_Players: TLabel;
    Lbl_Rating: TLabel;
    Lbl_Publisher: TLabel;
    Lbl_Developer: TLabel;
    Lbl_Genre: TLabel;
    EditGameRating: TEdit;
    EditGameReleaseDate: TEdit;
    EditGameDeveloper: TEdit;
    EditGamePublisher: TEdit;
    EditGameGenre: TEdit;
    EditGamePlayers: TEdit;
    EditGameName: TEdit;
    EditGameRegion: TEdit;
    XMLDoc: TXMLDocument;
    MenuItemActions: TMenuItem;
    MenuItemSystem: TMenuItem;
    MenuItemSystemLowerCase: TMenuItem;
    MenuItemSystemUpperCase: TMenuItem;
    MenuItemRemoveRegion: TMenuItem;
    MenuItemDeleteOrphans: TMenuItem;
    MenuItemDeleteDuplicates: TMenuItem;
    MenuItemExportTxt: TMenuItem;
    MenuItemGame: TMenuItem;
    MenuItemGameLowerCase: TMenuItem;
    MenuItemGameUpperCase: TMenuItem;
    MenuItemSelection: TMenuItem;
    MenuItemSetHidden: TMenuItem;
    MenuItemSetNoHidden: TMenuItem;
    MenuItemSetFavorite: TMenuItem;
    MenuItemSetNoFavorite: TMenuItem;
    MenuItemNameEditor: TMenuItem;
    OpenFile: TOpenDialog;
    SaveDialog: TSaveDialog;
    NetHTTPClientScrape: TNetHTTPClient;
    Layout1: TLayout;
    LayoutGameList: TLayout;
    ListBoxGames: TListBox;
    SearchBoxGames: TSearchBox;
    Layout4: TLayout;
    StyleBookWinUI3: TStyleBook;
    LayoutClient: TLayout;
    PanelSystems: TPanel;
    Label1: TLabel;
    ListBoxSystems: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    SearchBoxSystems: TSearchBox;
    ListBoxItem3: TListBoxItem;
    Layout6: TLayout;
    ImageNoBox: TImage;
    PanelGame: TPanel;
    VertScrollBoxGame: TVertScrollBox;
    ToolBar1: TToolBar;
    ButtonChangeImage: TButton;
    PathLabel1: TPathLabel;
    ButtonRemovePicture: TButton;
    PathLabel2: TPathLabel;
    ButtonSetDefaultPicture: TButton;
    PathLabel3: TPathLabel;
    ButtonChangeVideo: TButton;
    PathLabel4: TPathLabel;
    ButtonRemoveVideo: TButton;
    PathLabel5: TPathLabel;
    Panel1: TPanel;
    ButtonSaveChanges: TButton;
    ButtonScrape: TButton;
    Panel2: TPanel;
    MenuItemChangeAll: TMenuItem;
    Layout3: TLayout;
    TabControlMedia: TTabControl;
    TabItemMediaPicture: TTabItem;
    ImageGame: TImage;
    ImageGameBackground: TImage;
    TabItemMediaVideo: TTabItem;
    ImageGameBackgroundVideo: TImage;
    LayoutPlayer: TLayout;
    Rectangle1: TRectangle;
    VlcPlayer: TFmxPasLibVlcPlayer;
    MemoGameDescription: TMemo;
    Panel3: TPanel;
    Layout7: TLayout;
    Layout8: TLayout;
    EditGameRomPath: TEdit;
    Label2: TLabel;
    MenuItemGameDelete: TMenuItem;
    RadioButtonPreviewPicture: TRadioButton;
    RadioButtonPreviewVideo: TRadioButton;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Layout9: TLayout;
    Layout11: TLayout;
    ImageScreenScraper: TImage;
    VertScrollBox2: TVertScrollBox;
    PanelScrapeMedia: TPanel;
    Lbl_ScrapeName: TLabel;
    EditScrapeName: TEdit;
    EditScrapeDate: TEdit;
    Lbl_ScrapeDate: TLabel;
    Lbl_ScrapePublisher: TLabel;
    EditScrapePublisher: TEdit;
    EditScrapeDeveloper: TEdit;
    Lbl_ScrapeDeveloper: TLabel;
    EditScrapeRating: TEdit;
    Lbl_ScrapeRating: TLabel;
    EditScrapePlayers: TEdit;
    Lbl_ScrapePlayers: TLabel;
    EditScrapeRegion: TEdit;
    Lbl_ScrapeRegion: TLabel;
    EditScrapeGenre: TEdit;
    Lbl_ScrapeGenre: TLabel;
    Lbl_ScrapeDescription: TLabel;
    MemoScrapeDescription: TMemo;
    VertScrollBox3: TVertScrollBox;
    ButtonScrapeLowerText: TButton;
    ButtonScrapeUpperText: TButton;
    ButtonStartScrape: TButton;
    CheckBoxScrapePicWheel: TCheckBox;
    CheckBoxScrapePicVideo: TCheckBox;
    CheckBoxScrapePicTitle: TCheckBox;
    CheckBoxScrapePicScreenshot: TCheckBox;
    CheckBoxScrapePicMix2: TCheckBox;
    CheckBoxScrapePicMix1: TCheckBox;
    CheckBoxScrapePicBox3D: TCheckBox;
    CheckBoxScrapePicBox2D: TCheckBox;
    CheckBoxScrapePicArcadeBox: TCheckBox;
    EditScrapeCRC: TEdit;
    CheckBoxManualCRC: TCheckBox;
    ListBoxMedia: TListBox;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Label5: TLabel;
    ImageScrapeLoading: TImage;
    ProgressBarScrapeMedia: TProgressBar;
    ButtonGameDelete: TButton;
    Path1: TPath;
    MenuItemDeleteROMNotInList: TMenuItem;
    TabItemEditManual: TTabItem;
    RadioButtonPreviewManual: TRadioButton;
    LayoutHead: TLayout;
    LabelTitle: TLabel;
    LayoutHeadIcon: TLayout;
    ImageIcon: TImage;
    LayoutCaption: TLayout;
    ButtonWinMin: TButton;
    ButtonWinMax: TButton;
    ButtonWinClose: TButton;
    MenuBarMain: TMenuBar;
    ButtonSettings: TButton;
    StyleBookWinUI3Light: TStyleBook;
    PanelManual: TPanel;
    ToolBar2: TToolBar;
    ToolBar3: TToolBar;
    ButtonGameMainTab: TButton;
    Button2: TButton;
    CheckBoxScrapeVideo: TCheckBox;
    CheckBoxScrapePicture: TCheckBox;
    CheckBoxScrapeInfos: TCheckBox;
    ButtonScrapeSave: TButton;
    Label4: TLabel;
    Label3: TLabel;
    Layout10: TLayout;
    Label6: TLabel;
    TabControlMain: TTabControl;
    TabItemMainGameList: TTabItem;
    TabItemMainSystems: TTabItem;
    TabItemMainWelcome: TTabItem;
    TabItemMainSettings: TTabItem;
    ButtonGamesOptions: TButton;
    PopupGamesOptions: TPopup;
    LabelFilter: TLabel;
    ComboBoxGamesFilter: TComboBox;
    CheckBoxGamesListByRom: TCheckBox;
    CheckBoxGamesFullRomName: TCheckBox;
    Panel4: TPanel;
    ShadowEffect1: TShadowEffect;
    Layout2: TLayout;
    RadioButtonGameListViewMini: TRadioButton;
    RadioButtonGameListViewFull: TRadioButton;
    PathLabel6: TPathLabel;
    PathLabel7: TPathLabel;
    LabelGamesCount: TLabel;
    Panel5: TPanel;
    ImageSystemLogo: TImage;
    Panel6: TPanel;
    CheckBoxGameFavorite: TCheckBox;
    CheckBoxGameKids: TCheckBox;
    CheckBoxGameHidden: TCheckBox;
    ButtonSystemsOptions: TButton;
    PopupSystemsOptions: TPopup;
    Panel7: TPanel;
    ShadowEffect3: TShadowEffect;
    Label7: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    PopupMenuSystemsOptions: TPopupMenu;
    MenuItemSystemsManager: TMenuItem;
    EditOldName: TEdit;
    EditOldDate: TEdit;
    CheckBoxScrapeName: TCheckBox;
    CheckBoxScrapeDate: TCheckBox;
    EditOldDeveloper: TEdit;
    EditOldGenre: TEdit;
    CheckBoxScrapeGenre: TCheckBox;
    CheckBoxScrapeDeveloper: TCheckBox;
    EditOldPublisher: TEdit;
    CheckBoxScrapePublisher: TCheckBox;
    EditOldRegion: TEdit;
    CheckBoxScrapeRegion: TCheckBox;
    EditOldRating: TEdit;
    CheckBoxScrapeRating: TCheckBox;
    EditOldPlayers: TEdit;
    CheckBoxScrapePlayers: TCheckBox;
    MemoOldDescription: TMemo;
    CheckBoxScrapeDescription: TCheckBox;
    TabControlSettings: TTabControl;
    TabItemSettingsMain: TTabItem;
    TabItemSettingsNetwork: TTabItem;
    TabItemSettingsView: TTabItem;
    VertScrollBox1: TVertScrollBox;
    Label9: TLabel;
    Layout23: TLayout;
    Panel32: TPanel;
    Label68: TLabel;
    Label69: TLabel;
    PathLabel8: TPathLabel;
    ComboBoxTheme: TComboBox;
    ExpanderSetAccent: TExpander;
    Layout5: TLayout;
    RadioButtonSetAccentAuto: TRadioButton;
    RadioButtonSetAccentManual: TRadioButton;
    ComboColorBoxAccentColor: TComboColorBox;
    ExpanderSetBG: TExpander;
    Layout14: TLayout;
    RadioButtonSetBGSystem: TRadioButton;
    ComboColorBoxSetBGColor1: TComboColorBox;
    RadioButtonSetBGGradient: TRadioButton;
    PopupBoxStyle: TComboBox;
    RadioButtonSetBGImage: TRadioButton;
    Layout15: TLayout;
    Panel8: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    PathLabel9: TPathLabel;
    CheckBoxCustomTitle: TCheckBox;
    ComboColorBoxSetBGColor2: TComboColorBox;
    Button1: TButton;
    VertScrollBox4: TVertScrollBox;
    Layout12: TLayout;
    LabelSetCaption1: TLabel;
    LabelSetCaption2: TLabel;
    PathLabelSet1: TPathLabel;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    ButtonSetView: TButton;
    Label8: TLabel;
    Label19: TLabel;
    PathLabel12: TPathLabel;
    PathLabel10: TPathLabel;
    ButtonSetNetwork: TButton;
    Label13: TLabel;
    Label14: TLabel;
    PathLabel11: TPathLabel;
    PathLabel13: TPathLabel;
    Layout16: TLayout;
    Panel9: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    PathLabel14: TPathLabel;
    CheckBoxSetGodMode: TCheckBox;
    VertScrollBox5: TVertScrollBox;
    ExpanderSetProxy: TExpander;
    Layout17: TLayout;
    LabelHost: TLabel;
    EditProxyServer: TEdit;
    LabelPort: TLabel;
    NumberBoxProxyPort: TNumberBox;
    LabelProxyUser: TLabel;
    EditProxyUser: TEdit;
    LabelProxyPassword: TLabel;
    EditProxyPwd: TEdit;
    ExpanderSetScraper: TExpander;
    Layout18: TLayout;
    LabelScreenLogin: TLabel;
    EditSetScreenLogin: TEdit;
    EditSetScreenPwd: TEdit;
    LabelScreenPassword: TLabel;
    PasswordEditButton1: TPasswordEditButton;
    PasswordEditButton2: TPasswordEditButton;
    Label17: TLabel;
    Label18: TLabel;
    Layout13: TLayout;
    Label10: TLabel;
    Label20: TLabel;
    Button3: TButton;
    Button4: TButton;
    ButtonSettingsHelp: TButton;
    Layout19: TLayout;
    Panel10: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    PathLabel15: TPathLabel;
    CheckBoxSetShowTips: TCheckBox;
    ExpanderSetPrompts: TExpander;
    Layout20: TLayout;
    CheckBoxSetDelPrompts: TCheckBox;
    TabItemSettingsSSH: TTabItem;
    VertScrollBox6: TVertScrollBox;
    ExpanderSetRecalbox: TExpander;
    Layout21: TLayout;
    Label26: TLabel;
    EditSetRecalboxLogin: TEdit;
    Label27: TLabel;
    EditSetRecalboxPwd: TEdit;
    PasswordEditButton3: TPasswordEditButton;
    ExpanderSetRetropie: TExpander;
    Layout22: TLayout;
    Label28: TLabel;
    EditSetRetropieLogin: TEdit;
    EditSetRetropiePwd: TEdit;
    PasswordEditButton4: TPasswordEditButton;
    Label29: TLabel;
    ButtonSettingsSSH: TButton;
    Label23: TLabel;
    Label24: TLabel;
    PathLabel16: TPathLabel;
    PathLabel17: TPathLabel;
    Label25: TLabel;
    ButtonSettingsBack: TButton;
    TabItemMainHelp: TTabItem;
    PixieMarkdownView1: TPixieMarkdownView;
    Layout24: TLayout;
    Label30: TLabel;
    FloatAnimation3: TFloatAnimation;
    ButtonHelpBack: TButton;
    ButtonHelp: TButton;
    PathLabel18: TPathLabel;
    MarkdownViewerHelp: TMarkdownViewer;
    ButtonChooseFolder: TButton;
    PathLabel19: TPathLabel;
    ButtonReloadFolder: TButton;
    Popup1: TPopup;
    Panel11: TPanel;
    ShadowEffect2: TShadowEffect;
    Label31: TLabel;
    ComboBox2: TComboBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label32: TLabel;
    Layout25: TLayout;
    Panel12: TPanel;
    Label33: TLabel;
    Label34: TLabel;
    PathLabel20: TPathLabel;
    CheckBoxSetAutohash: TCheckBox;
    Layout26: TLayout;
    Panel13: TPanel;
    Label35: TLabel;
    Label36: TLabel;
    PathLabel21: TPathLabel;
    CheckBoxSetGenesisLogo: TCheckBox;
    Layout27: TLayout;
    ButtonWelcomeChooseFolder: TButton;
    Label37: TLabel;
    Label38: TLabel;
    Layout28: TLayout;
    Panel14: TPanel;
    Label39: TLabel;
    Label40: TLabel;
    PathLabel22: TPathLabel;
    CheckBoxSetOpenLastFolder: TCheckBox;
    Layout29: TLayout;
    CheckBoxSetPiPrompts: TCheckBox;
    Panel15: TPanel;
    RadioButtonPreviewHash: TRadioButton;
    TabItemMediaHash: TTabItem;
    Lbl_Crc32: TLabel;
    Lbl_Md5: TLabel;
    Lbl_Sha1: TLabel;
    EditGameHashCRC32: TEdit;
    EditGameHashMD5: TEdit;
    EditGameHashSHA1: TEdit;
    ButtonCalsHash: TButton;
    EditGamePlayCount: TEdit;
    Label41: TLabel;
    EditGameLastPlayed: TEdit;
    Label42: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonSaveChangesClick(Sender: TObject);
    procedure FieldChange(Sender: TObject);
    procedure ButtonSetDefaultPictureClick(Sender: TObject);
    procedure ComboBoxGamesFilterChange(Sender: TObject);
    procedure ButtonBtn_ChangeAll1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ChangeCaseClick(Sender: TObject);
    procedure ChangeCaseGameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonRemovePictureClick(Sender: TObject);
    procedure MenuItemRemoveRegionClick(Sender: TObject);
    procedure MenuItemDeleteOrphansClick(Sender: TObject);
    procedure MenuItemDeleteDuplicatesClick(Sender: TObject);
    procedure ButtonStartScrapeClick(Sender: TObject);
    procedure MenuItemSetHiddenClick(Sender: TObject);
    procedure MenuItemSetNoHiddenClick(Sender: TObject);
    procedure MenuItemSetFavoriteClick(Sender: TObject);
    procedure MenuItemSetNoFavoriteClick(Sender: TObject);
    procedure MenuItemNameEditorClick(Sender: TObject);
    procedure MenuItemExportTxtClick(Sender: TObject);
    procedure ButtonScrapeSaveClick(Sender: TObject);
    procedure ButtonScrapeUpperTextClick(Sender: TObject);
    procedure ButtonScrapeLowerTextClick(Sender: TObject);
    procedure Chk_ScrapeClick(Sender: TObject);
    procedure TabControlMediaChange(Sender: TObject);
    procedure ButtonChangeVideoClick(Sender: TObject);
    procedure ButtonRemoveVideoClick(Sender: TObject);
    procedure ListBoxGamesChange(Sender: TObject);
    procedure ButtonScrapeClick(Sender: TObject);
    procedure ButtonGameMainTabClick(Sender: TObject);
    procedure ButtonChangeImageClick(Sender: TObject);
    procedure GameMediaChange(Sender: TObject);
    procedure ListBoxMediaChange(Sender: TObject);
    procedure CheckBoxManualCRCChange(Sender: TObject);
    procedure MenuItemDeleteROMNotInListClick(Sender: TObject);
    procedure ButtonSettingsClick(Sender: TObject);
    procedure PopupBoxStyleChange(Sender: TObject);
    procedure CheckBoxCustomAccentChange(Sender: TObject);
    procedure ComboColorBoxAccentColorChange(Sender: TObject);
    procedure CheckBoxCustomTitleChange(Sender: TObject);
    procedure CheckBoxGamesListByRomChange(Sender: TObject);
    procedure CheckBoxGamesFullRomNameChange(Sender: TObject);
    procedure ButtonGamesOptionsClick(Sender: TObject);
    procedure GameListViewChange(Sender: TObject);
    procedure ButtonSystemsOptionsClick(Sender: TObject);
    procedure ListBoxSystemsChange(Sender: TObject);
    procedure ComboBoxThemeChange(Sender: TObject);
    procedure TabControlSettingsChange(Sender: TObject);
    procedure ButtonSetViewClick(Sender: TObject);
    procedure ButtonSetNetworkClick(Sender: TObject);
    procedure LabelSetCaption1Click(Sender: TObject);
    procedure CheckBoxSetShowTipsChange(Sender: TObject);
    procedure CheckBoxSetPiPromptsChange(Sender: TObject);
    procedure ButtonSettingsSSHClick(Sender: TObject);
    procedure ButtonSettingsBackClick(Sender: TObject);
    procedure ButtonSettingsHelpClick(Sender: TObject);
    procedure ButtonHelpBackClick(Sender: TObject);
    procedure ButtonChooseFolderClick(Sender: TObject);
    procedure ButtonReloadFolderClick(Sender: TObject);
    procedure CheckBoxSetAutohashChange(Sender: TObject);
    procedure CheckBoxSetGodModeChange(Sender: TObject);
    procedure CheckBoxSetGenesisLogoChange(Sender: TObject);
    procedure CheckBoxSetOpenLastFolderChange(Sender: TObject);
    procedure ButtonCalsHashClick(Sender: TObject);
  private
    FLanguage: Integer;
    FRootPath: string;
    FCurrentFolder: string;
    FVideoScrapeLink: string;
    FIsLoading: Boolean;
    FFolderIsOnPi, FSysIsRecal, FPiLoadedOnce: Boolean;
    FScrapedGame: TGame;
    FSystemList: TObjectDictionary<string, TObjectList<TGame>>;
    FPdfViewer: TPdfViewer;
    FPictureLinks: TObjectList<TMediaInfo>;
    FInfosList: TStringList;
    FMaxThreads, FThreadCount, FStartCount: Integer;
    FTempXmlPath: string;
    procedure LoadFromIni;
    procedure SaveToIni;
    procedure BuildSystemsList(aReload: Boolean = False);
    procedure LoadGamesList(const aSystem: string);
    procedure LoadGame(aGame: TGame);
    procedure ClearAllFields;
    procedure SaveBatchChangesToGamelist;
    procedure SaveChangesToGamelist(aScrape, aSaveVideo, aSavePic, aSaveInfos: Boolean);
    procedure EnableControls(AValue: Boolean);
    procedure EnableComponents(AValue: Boolean);
    procedure CheckIfChangesToSave;
    procedure ChangeImage(const aPath: string; aGame: TGame);
    procedure ChangeVideo(const aPath: string; aGame: TGame);
    procedure LoadSystemLogo(const aPictureName: string);
    procedure DeleteGame(aGame: TGame; reloadGameList: Boolean = True);
    procedure DeleteGamePicture;
    procedure DeleteGameVideo;
    procedure StartGameVideo(const aPath: string);
    procedure StopGameVideo;
    procedure RemoveRegionFromGameName(aGame: TGame; aStartPos: Integer);
    procedure ConvertFieldsCase(aGame: TGame; aUnique: Boolean = False; aUp: Boolean = False);
    procedure StopOrStartES(AStop, ARecal: Boolean);
    procedure DeleteDuplicates(const aSystem: string);
    procedure SetFavoriteOrHidden(AFavorite, AValue: Boolean);
    procedure TransformGamesNames(Func: TFunc<string, string>);
    procedure ExportToTxt;
    function GetSystemKind: TSystemKind;
    function GetCurrentFolderName: string;
    function GetCurrentLogoName: string;
    function GetCurrentSystemId: string;
    function GetCountryEnum(const aShortName: string): TCountryName;
    function BuildGamesList(const aPathToFile: string): TObjectList<TGame>;
    function GetLangEnum(aNumber: Integer): TLangName;
    function MyMessageDlg(const Title, Text: string; Buttons: TArray<string>): Integer;

    procedure ClearScrapeMedia;
    procedure ParseXml;
    procedure DisplayPictures;
    procedure FillFields;
    procedure EnableScrapeComponents(AValue: Boolean);
    procedure GetPictures;
    procedure GetPicture(aMedia: TMediaInfo);
    procedure ThreadTerminated(Sender: TObject);
    procedure EmptyScrapeFields;
    procedure ConvertScrapeToUpOrLow(aUp: Boolean = False);
    procedure UpdateVideo(aGame: TGame);
    procedure SaveLinkToFile(aLink, aPath: string);

    function GetGameXml(const ASysId: string; aGame: TGame): Boolean;
    procedure FillGameItem(Item: TListBoxItemGame; Game: TGame);
    function GetCurrentGameListPath: string;
    procedure UpdateImage(AGame: TGame);
    procedure CreatePdfViewer;
    procedure UpdateManual(AGame: TGame);
  private
    OverAccentColor: TAlphaColor;
    procedure SetGodMode(const Value: Boolean);
    procedure SetDelWoPrompt(const Value: Boolean);
    procedure SetPiPrompts(const Value: Boolean);
    procedure SetRecalLogin(const Value: string);
    procedure SetRecalPwd(const Value: string);
    procedure SetRetroLogin(const Value: string);
    procedure SetRetroPwd(const Value: string);
    function GetRecalLogin: string;
    function GetRecalPwd: string;
    function GetRetroLogin: string;
    function GetRetroPwd: string;
    function GetGodMode: Boolean;
    function GetDelWoPrompt: Boolean;
    function GetAutoHash: Boolean;
    procedure SetAutoHash(const Value: Boolean);
    function GetShowTips: Boolean;
    procedure SetShowTips(const Value: Boolean);
    function GetGenesisLogo: Boolean;
    procedure SetGenesisLogo(const Value: Boolean);
    function GetOpenLastFolder: Boolean;
    procedure SetOpenLastFolder(const Value: Boolean);
    function GetPiPrompts: Boolean;
    function GetSSLogin: string;
    function GetSSPwd: string;
    procedure SetSSLogin(const Value: string);
    procedure SetSSPwd(const Value: string);
  protected
    procedure DoOnSettingChange; override;
  public
    FImgList: TObjectList<TImage>;
    function CreateHTTPClient: THTTPClient;
    function CreateProxySettings: TProxySettings;
    property GodMode: Boolean read GetGodMode write SetGodMode;
    property DelWoPrompt: Boolean read GetDelWoPrompt write SetDelWoPrompt;
    property PiPrompts: Boolean read GetPiPrompts write SetPiPrompts;
    property RecalLogin: string read GetRecalLogin write SetRecalLogin;
    property RecalPwd: string read GetRecalPwd write SetRecalPwd;
    property RetroLogin: string read GetRetroLogin write SetRetroLogin;
    property RetroPwd: string read GetRetroPwd write SetRetroPwd;
    property AutoHash: Boolean read GetAutoHash write SetAutoHash;
    property GenesisLogo: Boolean read GetGenesisLogo write SetGenesisLogo;
    property ShowTips: Boolean read GetShowTips write SetShowTips;
    property OpenLastFolder: Boolean read GetOpenLastFolder write SetOpenLastFolder;

    property SSLogin: string read GetSSLogin write SetSSLogin;
    property SSPwd: string read GetSSPwd write SetSSPwd;
    procedure WarnUser(const AMessage: string);
    procedure WarnUserWithSafeUrl(const aMessage, aMessage2, aUrl: string);
  end;

var
  FormMain: TFormMain;
  CounterGuard: TCriticalSection;

implementation

uses
  System.IOUtils, FMX.BehaviorManager, WinUI3.Style, System.Messaging,
  Markdown4D.Theme, WinUI3.Dialogs, System.DateUtils
  {$IFDEF POSIX}
    , Posix.StdLib, posix.Stdio, posix.SysUio
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    , Winapi.ShellAPI
  {$ENDIF}
    , System.NetEncoding;

{$R *.FMX}

function IntToBoolStr(const Value: Integer): string;
begin
  Result := if Value = 0 then Cst_False else Cst_True;
end;

function BoolStr(const Value: Boolean): string;
begin
  Result := if Value then Cst_True else Cst_False;
end;

function SelCount(ListBox: TListBox): Integer;
begin
  Result := 0;
  for var i := 0 to ListBox.Count - 1 do
    if ListBox.ListItems[i].IsSelected then
      Inc(Result);
end;

function TFormMain.MyMessageDlg(const Title, Text: string; Buttons: TArray<string>): Integer;
begin
  var Data: TDialogTextParams;
  Data.Title := Title;
  Data.Body := Text;
  Data.Buttons := Buttons;
  Data.AccentId := 0;
  Result := TWinUIDialog.Show(Self, Data).Result;
end;

procedure TFormMain.LoadFromIni;
begin
  var FileIni := TIniFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath));
  try
    FRootPath := FileIni.ReadString(Cst_IniOptions, Cst_IniLastPath, '');

    GodMode := FileIni.ReadBool(Cst_IniOptions, Cst_IniGodMode, False);
    AutoHash := FileIni.ReadBool(Cst_IniOptions, Cst_IniAutoHash, False);
    DelWoPrompt := FileIni.ReadBool(Cst_IniOptions, Cst_IniDelWoPrompt, False);
    PiPrompts := FileIni.ReadBool(Cst_IniOptions, Cst_IniPiPrompts, False);
    GenesisLogo := FileIni.ReadBool(Cst_IniOptions, Cst_IniGenesisLogo, False);
    ShowTips := FileIni.ReadBool(Cst_IniOptions, Cst_ShowTips, True);
    OpenLastFolder := FileIni.ReadBool(Cst_IniOptions, Cst_OpenLastFolder, True);
    FLanguage := FileIni.ReadInteger(Cst_IniOptions, Cst_IniLanguage, 0);

    RecalLogin := FileIni.ReadString(Cst_IniOptions, Cst_IniRecalLogin, Cst_RecalLogin);
    RecalPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniRecalPwd, Cst_RecalPwd);
    RetroLogin := FileIni.ReadString(Cst_IniOptions, Cst_IniRetroLogin, Cst_RetroLogin);
    RetroPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniRetroPwd, Cst_RetroPwd);

    SSLogin := FileIni.ReadString(Cst_IniOptions, Cst_IniSSUser, '');
    SSPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniSSPwd, '');
    EditProxyUser.Text := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyUser, '');
    EditProxyPwd.Text := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyPwd, '');
    EditProxyServer.Text := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyServer, '');
    NumberBoxProxyPort.Value := FileIni.ReadInteger(Cst_IniOptions, Cst_IniProxyPort, 0);
    ExpanderSetProxy.IsChecked := FileIni.ReadBool(Cst_IniOptions, Cst_IniProxyUse, False);
  finally
    FileIni.Free;
  end;
end;

procedure TFormMain.SaveToIni;
begin
  if not TDirectory.Exists(ExtractFilePath(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath))) then
    TDirectory.CreateDirectory(ExtractFilePath(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath)));

  if not TFile.Exists(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath)) then
    TFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath)).Free;

  var FileIni := TIniFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath));
  try
    FileIni.WriteString(Cst_IniOptions, Cst_IniLastPath, FRootPath);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniGodMode, GodMode);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniAutoHash, AutoHash);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniDelWoPrompt, DelWoPrompt);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniGenesisLogo, GenesisLogo);
    FileIni.WriteBool(Cst_IniOptions, Cst_ShowTips, ShowTips);
    FileIni.WriteBool(Cst_IniOptions, Cst_OpenLastFolder, OpenLastFolder);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniPiPrompts, PiPrompts);
    FileIni.WriteInteger(Cst_IniOptions, Cst_IniLanguage, FLanguage);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRecalLogin, RecalLogin);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRecalPwd, RecalPwd);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRetroLogin, RetroLogin);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRetroPwd, RetroPwd);
    FileIni.WriteString(Cst_IniOptions, Cst_IniSSUser, SSLogin);
    FileIni.WriteString(Cst_IniOptions, Cst_IniSSPwd, SSPwd);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyUser, EditProxyUser.Text);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyPwd, EditProxyPwd.Text);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyServer, EditProxyServer.Text);
    FileIni.WriteInteger(Cst_IniOptions, Cst_IniProxyPort, Trunc(NumberBoxProxyPort.Value));
    FileIni.WriteBool(Cst_IniOptions, Cst_IniProxyUse, ExpanderSetProxy.IsChecked);
  finally
    FileIni.Free;
  end;
end;

function TFormMain.GetLangEnum(ANumber: Integer): TLangName;
begin
  Result := TLangName.English;
  for var LangName := Low(TLangName) to High(TLangName) do
  begin
    if ANumber = Ord(LangName) then
    begin
      Result := LangName;
      Break;
    end;
  end;
end;

function TFormMain.GetOpenLastFolder: Boolean;
begin
  Result := CheckBoxSetOpenLastFolder.IsChecked;
end;

function TFormMain.GetAutoHash: Boolean;
begin
  Result := CheckBoxSetAutohash.IsChecked;
end;

function TFormMain.GetCountryEnum(const AShortName: string): TCountryName;
begin
  Result := TCountryName.Und;
  for var CountryName := Low(TCountryName) to High(TCountryName) do
    if AShortName = CountryName.ShortName then
      Exit(CountryName);
end;

function TFormMain.CreateHTTPClient: THTTPClient;
begin
  Result := THTTPClient.Create;
  Result.ProxySettings := CreateProxySettings;
end;

procedure TFormMain.CreatePdfViewer;
begin
  FPdfViewer := TPdfViewer.Create(Self);
  FPdfViewer.Parent := PanelManual;
  FPdfViewer.Align := TAlignLayout.Client;
  FPdfViewer.BackgroundColor := TAlphaColors.White;
  //FPdfViewer.OnPageChanged := OnPdfViewerPageChanged;
  FPdfViewer.LoadingPanel.StyleLookup := 'panelstyle_dialog';
  FPdfViewer.SendToBack;
end;

function TFormMain.CreateProxySettings: TProxySettings;
begin
  if ExpanderSetProxy.IsChecked then
    Result := TProxySettings.Create(EditProxyServer.Text, Trunc(NumberBoxProxyPort.Value), EditProxyUser.Text, EditProxyPwd.Text)
  else
    Result := TProxySettings.Create('', 0, '', '');
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  ExpanderSetAccent.StylesData['details'] := 'Adjust the accent color';
  ExpanderSetAccent.StylesData['icon.Data.Data'] := 'M9.75,6.5 C10.164213180542,6.5 10.5,6.16421365737915 10.5,5.75 C10.5,5.33578634262085 10.1642141342163,5 9.75,5 C9.33578681945801,5 9,5.33578634262085 9,5.75 C9,6.16421365737915 9.33578586578369,6.5 9.75,' +
    '6.5 M12.75,7.5 C13.164213180542,7.5 13.5,7.16421365737915 13.5,6.75 C13.5,6.33578634262085 13.1642141342163,6 12.75,6 C12.335786819458,6 12,6.33578634262085 12,6.75 C12,7.16421365737915 12.3357858657837,' +
    '7.5 12.75,7.5 M15.25,9 C15.25,9.41421318054199 14.914213180542,9.75 14.5,9.75 C14.085786819458,9.75 13.75,9.41421318054199 13.75,9 C13.75,8.58578586578369 14.085786819458,8.25 14.5,8.25 C14.914213180542,' +
    '8.25 15.25,8.58578586578369 15.25,9 M14.5,12.75 C14.914213180542,12.75 15.25,12.414213180542 15.25,12 C15.25,11.585786819458 14.9142141342163,11.25 14.5,11.25 C14.085786819458,11.25 13.75,11.585786819458 ' +
    '13.75,12 C13.75,12.414213180542 14.0857858657837,12.75 14.5,12.75 M13.25,14 C13.25,14.414213180542 12.914213180542,14.75 12.5,14.75 C12.085786819458,14.75 11.75,14.414213180542 11.75,14 C11.75,13.5857858657837 ' +
    '12.085786819458,13.25 12.5,13.25 C12.914213180542,13.25 13.25,13.5857858657837 13.25,14 M13.6969995498657,2.99199962615967 C10.9429998397827,1.57699966430664 8.14299964904785,1.7119996547699 5.76999950408936,' +
    '3.1659996509552 C4.55999946594238,3.90799951553345 3.25299954414368,5.4689998626709 2.51599955558777,7.05899953842163 C2.14599943161011,7.85899972915649 1.89899957180023,8.70499992370605 1.90199947357178,' +
    '9.49300003051758 C1.90599942207336,10.293999671936 2.16999959945679,11.0590000152588 2.83999943733215,11.6049995422363 C3.44999933242798,12.1029996871948 3.98199939727783,12.3529996871948 4.49599933624268,' +
    '12.3779993057251 C5.01399946212769,12.4039993286133 5.41799926757813,12.1939992904663 5.73399925231934,12.007999420166 L5.93099927902222,11.8889989852905 C6.17299938201904,11.7419986724854 6.37199926376343,' +
    '11.6209993362427 6.62099933624268,11.5429992675781 C6.90099954605103,11.4529991149902 7.25799942016602,11.4209995269775 7.77599906921387,11.5789995193481 C7.96599912643433,11.636999130249 8.08199882507324,' +
    '11.7229995727539 8.1619987487793,11.8229999542236 C8.24799919128418,11.9289999008179 8.31699848175049,12.0769996643066 8.36799907684326,12.2889995574951 C8.41999912261963,12.5019998550415 8.44799900054932,' +
    '12.7529993057251 8.46799945831299,13.048999786377 C8.47699928283691,13.1589994430542 8.48399925231934,13.28600025177 8.49099922180176,13.4180002212524 C8.5029993057251,13.6100006103516 8.51399898529053,' +
    '13.8150005340576 8.52999877929688,14.0040006637573 C8.58399868011475,14.6740007400513 8.69999885559082,15.4400005340576 9.10399913787842,16.1360015869141 C9.51799869537354,16.8490009307861 10.2039995193481,' +
    '17.439001083374 11.306999206543,17.8160018920898 C12.9089994430542,18.3640022277832 14.3729991912842,17.919002532959 15.5129985809326,17.0160026550293 C16.6389980316162,16.1250019073486 17.4689979553223,' +
    '14.7760028839111 17.8839988708496,13.4270029067993 C19.1989994049072,9.15400314331055 17.6729984283447,5.03400325775146 13.6969985961914,2.99200248718262 M6.29199981689453,4.01900005340576 C8.35700035095215,' +
    '2.75400018692017 10.7840003967285,2.61899995803833 13.2399997711182,3.88100004196167 C16.7469997406006,5.68300008773804 18.1129989624023,9.2810001373291 16.92799949646,13.132999420166 C16.5620002746582,' +
    '14.3229999542236 15.8339996337891,15.4869995117188 14.8919992446899,16.2329998016357 C13.9629993438721,16.9680004119873 12.8489990234375,17.2859992980957 11.6309995651245,16.8699989318848 C10.7269992828369,' +
    '16.5599994659424 10.2469997406006,16.1129989624023 9.96799945831299,15.6339988708496 C9.67999935150146,15.136999130249 9.57799911499023,14.5559988021851 9.52599906921387,13.9219989776611 C9.51099872589111,' +
    '13.7329988479614 9.50099945068359,13.5619993209839 9.49099922180176,13.3879985809326 L9.46599960327148,12.9779987335205 C9.44808673858643,12.6668615341187 9.40596008300781,12.3575983047485 9.34000015258789,' +
    '12.0530033111572 C9.27078247070313,11.7406625747681 9.13427734375,11.4471759796143 8.94000053405762,11.1930027008057 C8.71393775939941,10.9188861846924 8.40979194641113,10.7200746536255 8.06800079345703,' +
    '10.6230030059814 C7.36600065231323,10.4080028533936 6.80300092697144,10.4360027313232 6.31800079345703,10.5890026092529 C5.94300079345703,10.709002494812 5.6200008392334,10.9060029983521 5.3720006942749,' +
    '11.0590028762817 L5.22600078582764,11.1460027694702 C4.94100093841553,11.3150024414063 4.75400066375732,11.3900032043457 4.54600095748901,11.3800029754639 C4.33300113677979,11.370002746582 4.00300121307373,' +
    '11.2620029449463 3.47200107574463,10.830002784729 C3.08700108528137,10.5160026550293 2.90500116348267,10.0670032501221 2.90200114250183,9.49000263214111 C2.90000104904175,8.89900302886963 3.0880012512207,' +
    '8.20200252532959 3.42300128936768,7.48000240325928 C4.09700107574463,6.02700233459473 5.28500127792358,4.63600254058838 6.29300117492676,4.01900243759155 ';

  ExpanderSetBG.StylesData['details'] := 'Window background (color, gradient, style)';
  ExpanderSetBG.StylesData['icon.Data.Data'] := 'M5.498 3.001a2.5 2.5 0 0 0-2.5 2.5v9a2.5 2.5 0 0 0 2.5 2.5h9a2.5 2.5 0 0 0 2.5-2.5V8h.003V6.5h-.003v-.999a2.5 2.5 0 0 0-2.5-2.5zM15.501 6v.5H14.21l1.145-1.145c.093.195.146.414.146.645m-.852-1.353L12.795 6.5H9.967l2-2H14c.232 0 .451.053.648.147M10.553 4.5l-2 2H5.724l2-2zm-4.243 0L4.5 6.31V6A1.5 1.5 0 0 1 6 4.5zM7.053 8L4.5 10.552V8zM4.5 11.966L8.467 8h2.828l-6.648 6.648A1.5 1.5 0 0 1 4.5 14zM12.71 8h2.79v.037L8.039 15.5H6c-.23 0-.45-.052-.645-.146zm2.79 1.452v2.828l-3.22 3.22H9.453zm0 4.242V14a1.5 1.5 0 0 1-1.5 1.5h-.305z';

  ExpanderSetProxy.StylesData['details'] := 'Use a proxy server when connecting to the network';
  ExpanderSetProxy.StylesData['icon.Data.Data'] := 'M12 6.25a.75.75 0 0 1 .75.75v10a.75.75 0 1 1-1.5 0V7a.75.75 0 0 1 .75-.75M6.065 8.399a.75.75 0 0 1 1.06.02l2.953 3.06c.28.29.28.751 0 1.042l-2.953 3.06a.75.75 0 1 1-1.08-1.04l1.728-1.79H4a.75.75 0 1 1 ' +
    '0-1.5h3.773L6.046 9.458a.75.75 0 0 1 .019-1.06m10.461.001a.75.75 0 0 1 1.06.02l2.954 3.06c.28.29.28.751 0 1.042l-2.953 3.06a.75.75 0 1 1-1.08-1.04l1.727-1.79l-3.772-.001a.75.75 0 0 1 0-1.5h3.773l-1.728-1.79a.75.75 ' +
    '0 0 1 .02-1.061';

  ExpanderSetScraper.StylesData['details'] := 'Authorization data in Screen Scraper';
  ExpanderSetScraper.StylesData['icon.Data.Data'] := 'M15 2.25a.75.75 0 0 1 .75.75v1A1.75 1.75 0 0 1 14 5.75h-1a.25.25 0 0 0-.25.25v.25h.533c1.313 0 2.354 0 3.194.083c.863.085 1.583.262 2.234.66q.465.285.854.66c.55.53.895 1.178 1.179 1.981c.275.78.512 1.768.81 ' +
    '3.01l1.095 4.557c.483 2.011-.805 3.994-2.827 4.453c-1.702.386-3.468-.419-4.248-1.97l-.129-.255a2.66 2.66 0 0 0-2.381-1.44h-2.128c-1.021 0-1.942.567-2.381 1.44l-.128.255c-.781 1.551-2.547 2.356-4.249 1.97c-2.022-.46-3.31-2.442-2.827-4.453l1.095-4.556c.298-1.242.536-2.231.81-3.01c.284-.804.628-1.452 ' +
    '1.179-1.982q.391-.375.854-.66c.651-.398 1.372-.575 2.234-.66c.84-.083 1.88-.083 3.194-.083h.533V6c0-.966.784-1.75 1.75-1.75h1a.25.25 0 0 0 .25-.25V3a.75.75 0 0 1 .75-.75m-4.243 5.5c-1.362 0-2.329 0-3.087.076c-.743.073-1.214.212-1.598.447a3.5 ' +
    '3.5 0 0 0-.597.461c-.32.308-.563.717-.804 1.4c-.246.697-.466 1.61-.777 2.902L2.81 17.552c-.28 1.164.46 2.357 1.7 2.64c1.05.238 2.115-.265 2.577-1.183l.128-.254c.701-1.394 2.149-2.265 3.721-2.265h2.128c1.572 ' +
    '0 3.02.871 3.721 2.265l.128.254c.462.918 1.527 1.42 2.577 1.182c1.241-.282 1.98-1.475 1.7-2.64l-1.084-4.515c-.31-1.292-.53-2.205-.777-2.903c-.24-.682-.484-1.091-.804-1.399a3.5 3.5 0 0 0-.597-.46c-.384-.236-.855-.375-1.598-.448c-.758-.075-1.725-.076-3.087-.076zM8.5 ' +
    '10.25a.75.75 0 0 1 .75.75v.75H10a.75.75 0 0 1 0 1.5h-.75V14a.75.75 0 0 1-1.5 0v-.75H7a.75.75 0 0 1 0-1.5h.75V11a.75.75 0 0 1 .75-.75' +
    'M16 11a1 1 0 1 1-2 0a1 1 0 0 1 2 0m2 3a1 1 0 1 1-2 0a1 1 0 0 1 2 0';

  ExpanderSetPrompts.StylesData['details'] := 'Enabling/Disabling confirmation dialog boxes';
  ExpanderSetPrompts.StylesData['icon.Data.Data'] := 'M19 5.5a4.5 4.5 0 1 1-9 0a4.5 4.5 0 0 1 9 0m-3.793 0l1.147-1.146a.5.5 0 0 0-.708-.708L14.5 4.793l-1.146-1.147a.5.5 0 0 0-.708.708L13.793 5.5l-1.147 1.146a.5.5 0 0 0 .708.708L14.5 6.207l1.146 1.147a.5.5 ' +
    '0 0 0 .708-.708zM17 12.276V10.4a5.5 5.5 0 0 0 1-.657v2.533c0 1.418-1.164 2.566-2.6 2.566h-4.59l-4.011 2.961a1.01 1.01 0 0 1-1.4-.199a.98.98 0 0 1-.199-.59v-2.172h-.6c-1.436 0-2.6-1.149-2.6-2.566v-6.71C2 ' +
    '4.149 3.164 3 4.6 3h5a5.5 5.5 0 0 0-.393 1H4.6C3.704 4 3 4.713 3 5.566v6.71c0 .853.704 1.566 1.6 1.566h1.6V17h.003l.002-.001l4.276-3.157H15.4c.896 0 1.6-.713 1.6-1.566';

  ExpanderSetRetropie.StylesData['details'] := 'Authorization data for Retropie';
  ExpanderSetRetropie.StylesData['icon.Data.Data'] := 'M10 3a2 2 0 1 1 0 4a2 2 0 0 1 0-4m.5 4.959a3 3 0 1 0-1 0V11h-2A1.5 1.5 0 0 0 6 12.5v.5H5a2 2 0 0 0-2 2v2.5a.5.5 0 0 0 .5.5h13a.5.5 0 0 0 .5-.5V15a2 2 0 0 0-2-2h-1v-.5a1.5 1.5 0 0 0-1.5-1.5h-2zM7.5 12h5a.5.5 ' +
    '0 0 1 .5.5v.5H7v-.5a.5.5 0 0 1 .5-.5M5 14h10a1 1 0 0 1 1 1v2H4v-2a1 1 0 0 1 1-1';

  ExpanderSetRecalbox.StylesData['details'] := 'Authorization data for Recalbox';
  ExpanderSetRecalbox.StylesData['icon.Data.Data'] := 'M9.125 7.184A.75.75 0 0 0 8 7.834v4.333a.75.75 0 0 0 1.125.65l4.125-2.384a.5.5 0 0 0 0-.866zM2 10a8 8 0 1 1 16 0a8 8 0 0 1-16 0m8-7a7 7 0 1 0 0 14a7 7 0 0 0 0-14';

  // Theme and style
  OverAccentColor := SystemAccentColor;
  BeginUpdate;
  ComboColorBoxAccentColor.Color := OverAccentColor;
  EndUpdate;
  SetSystemWindowControls(ButtonWinClose, ButtonWinMax, ButtonWinMin);
  CaptionControls := [LayoutCaption, LayoutHead];
  OffsetControls := [LayoutHead];
  TitleControls := [LabelTitle];
  SystemButtonsContainer := LayoutCaption;
  IconControl := ImageIcon;
  {$IFDEF MSWINDOWS}
  HideTitleBar := True;
  {$ELSE}
  HideTitleBar := False;
  LayoutCaption.Visible := False;
  LabelTitle.Visible := False;
  LayoutHeadIcon.Visible := False;
  {$ENDIF}
  // Defaults
  MemoGameDescription.ScrollAnimation := TBehaviorBoolean.True;
  MemoScrapeDescription.ScrollAnimation := TBehaviorBoolean.True;
  TabControlEditor.TabPosition := TTabPosition.None;
  TabControlMedia.TabPosition := TTabPosition.None;
  TabControlSettings.TabPosition := TTabPosition.None;
  TabControlMain.TabPosition := TTabPosition.None;
  LabelGamesCount.Text := '';
  ListBoxGames.Clear;
  ListBoxSystems.Clear;
  TabControlSettingsChange(nil);
  // Pdf
  CreatePdfViewer;
  // Create
  FImgList := TObjectList<TImage>.Create;
  FInfosList := TStringList.Create(True);
  FPictureLinks := TObjectList<TMediaInfo>.Create;
  FSystemList := TObjectDictionary<string, TObjectList<TGame>>.Create([doOwnsValues]);
  FPiLoadedOnce := False;
  FTempXmlPath := TPath.Combine(TPath.GetLibraryPath, Cst_TempXml);
  CounterGuard := TCriticalSection.Create;
  // Load settings
  LoadFromIni;
  // Start
  TabControlMain.ActiveTab := TabItemMainWelcome;
  TabControlMedia.ActiveTab := TabItemMediaPicture;
  TabControlMediaChange(nil);
  if OpenLastFolder and TDirectory.Exists(FRootPath) then
    BuildSystemsList(True)
  else
    TabControlMain.ActiveTab := TabItemMainWelcome;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  if ShowTips then
  begin
    var FormHelp := TFormHelp.Create(Self);
    try
      ShowTips := FormHelp.Execute(not ShowTips);
    finally
      FormHelp.Free;
    end;
  end;
end;

//permet d'йxecuter la ligne de commande qui stop/start Emulation Station
//utilisй si on accиde aux gamelist directement sur le Pi sinon les modifs ne
//sont pas prises en compte. Utilise le petit utilitaire plink.exe
procedure TFormMain.StopOrStartES(AStop, ARecal: Boolean);
begin
  var PathToPlink := TPath.Combine(TPath.GetLibraryPath, Cst_ResourcesFolder);
  {$IFDEF MSWINDOWS}
  if AStop then
  begin
    if ARecal then
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + RecalLogin +
          Cst_PlinkCommandRecal + RecalPwd +
          Cst_PlinkCommandStop), PChar(PathToPlink), 0)
    else
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + RetroLogin +
          Cst_PlinkCommandRetro + RetroPwd +
          Cst_PlinkCommandStop), PChar(PathToPlink), 0);
  end
  else
  begin
    if ARecal then
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + RecalLogin +
          Cst_PlinkCommandRecal + RecalPwd +
          Cst_PlinkCommandStart), PChar(PathToPlink), 0)
    else
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + RetroLogin +
          Cst_PlinkCommandRetro + RetroPwd +
          Cst_PlinkCommandStart), PChar(PathToPlink), 0)
  end;
  {$ENDIF}
end;

procedure TFormMain.BuildSystemsList(AReload: Boolean);
begin
  if not AReload then
  begin
    var Dir: string := FRootPath;
    if SelectDirectory(Translate('Select dir'), '', Dir) then
      FRootPath := Dir
    else
      Exit;
  end;

  EnableControls(False);
  ClearAllFields;
  ListBoxGames.Clear;
  ListBoxSystems.Clear;
  ListBoxSystems.Enabled := False;
  ImageSystemLogo.Bitmap := nil;
  ComboBoxGamesFilter.Enabled := False;
  LabelGamesCount.Text := '';
  MenuItemGameDelete.Enabled := False;
  FSystemList.Clear;

  var Dirs := TDirectory.GetDirectories(FRootPath);
  var IsFound := Length(Dirs) > 0;
  if not IsFound then
  begin
    ShowUIMessage(Self, Rst_WrongFolder + #13#10'not IsFound');
    Exit;
  end;

  var ValidFolderCount := 0;
  ListBoxSystems.BeginUpdate;
  try
    for var Dir in Dirs do
    begin
      if Dir.StartsWith('.') then
        Continue;
      if not TFile.Exists(TPath.Combine(FRootPath, Dir, Cst_GameListFileName)) then
        Continue;

      FCurrentFolder := TPath.GetFileName(Dir);

      var TmpList := BuildGamesList(TPath.Combine(FRootPath, FCurrentFolder, Cst_GameListFileName));
      if Assigned(TmpList) then
      begin
        FSystemList.Add(FCurrentFolder, TmpList);

        var Item := TListBoxItemSystem.Create(ListBoxSystems);
        ListBoxSystems.AddObject(Item);
        Item.ItemData.Detail := TmpList.Count.ToString;
        Item.SystemKind := TSystemKind.Create(FCurrentFolder);

        if Item.SystemKind = TSystemKind.Other then
          Item.Text := FCurrentFolder
        else if (Item.SystemKind = TSystemKind.MegaDrive) and GenesisLogo then
          Item.Text := Cst_SystemKindStr[TSystemKind.Genesis]
        else
          Item.Text := Cst_SystemKindStr[Item.SystemKind];

        Inc(ValidFolderCount);
      end;
    end;
  finally
    ListBoxSystems.EndUpdate;
  end;

  if ValidFolderCount = 0 then
  begin
    ShowUIMessage(Self, Rst_WrongFolder + #13#10'ValidFolderCount is 0');
    Exit;
  end;

  FFolderIsOnPi := FRootPath.StartsWith(Cst_Recalbox) or FRootPath.StartsWith(Cst_Retropie);

  if FFolderIsOnPi and not FPiLoadedOnce then
  begin
    FPiLoadedOnce := True;
    if not PiPrompts then
      MyMessageDlg(Rst_Info, Rst_StopES, [Rst_Ok]);
    if FRootPath.StartsWith(Cst_Recalbox) then
    begin
      StopOrStartES(True, True);
      FSysIsRecal := True;
    end
    else
    begin
      StopOrStartES(True, False);
      FSysIsRecal := False;
    end;
  end;

  ListBoxSystems.Enabled := True;
  ComboBoxGamesFilter.Enabled := ListBoxSystems.Enabled;
  ListBoxSystems.ItemIndex := 0;
  EnableControls(True);
  ComboBoxGamesFilter.ItemIndex := 0;
  LoadGamesList(GetCurrentFolderName);
  TabControlMain.ActiveTab := TabItemMainGameList;
end;

procedure TFormMain.ButtonGameMainTabClick(Sender: TObject);
begin
  TabControlEditor.ActiveTab := TabItemEditGame;
end;

procedure TFormMain.ButtonGamesOptionsClick(Sender: TObject);
begin
  PopupGamesOptions.PlacementTarget := ButtonGamesOptions;
  PopupGamesOptions.Placement := TPlacement.Bottom;
  PopupGamesOptions.Popup;
end;

procedure TFormMain.ButtonHelpBackClick(Sender: TObject);
begin
  TabControlMain.ActiveTab := TabItemMainGameList;
end;

procedure TFormMain.ButtonScrapeClick(Sender: TObject);
begin
  TabControlEditor.ActiveTab := TabItemEditScrape;
end;

function TFormMain.BuildGamesList(const aPathToFile: string): TObjectList<TGame>;

  function GetNodeValue(aNode: IXMLNode; const aNodeName: string): string;
  begin
    Result := '';
    if Assigned(aNode.ChildNodes.FindNode(aNodeName)) then
      Result := aNode.ChildNodes.Nodes[aNodeName].Text;
  end;

begin
  Result := nil;

  XMLDoc.FileName := aPathToFile;
  XMLDoc.Active := True;

  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

  if not Assigned(Node) then
    Exit;

  Result := TObjectList<TGame>.Create(True);
  repeat
    if Node.HasChildNodes then
      Result.Add(TGame.CreateFrom(Node, TPath.Combine(FRootPath, FCurrentFolder)));
    Node := Node.NextSibling;
  until Node = nil;

  XMLDoc.Active := False;
end;

//Action а la sйlection d'un filtre
procedure TFormMain.ComboBoxGamesFilterChange(Sender: TObject);
begin
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.ComboBoxThemeChange(Sender: TObject);
begin
  if FUpdating > 0 then
    Exit;
  DoOnSettingChange;
end;

procedure TFormMain.ComboColorBoxAccentColorChange(Sender: TObject);
begin
  if FUpdating > 0 then
    Exit;
  DoOnSettingChange;
end;

procedure TFormMain.EnableControls(AValue: Boolean);
begin
  CheckBoxGameKids.Enabled := AValue;
  CheckBoxGameHidden.Enabled := AValue;
  CheckBoxGameFavorite.Enabled := AValue;

  ButtonChangeImage.Enabled := AValue;
  ButtonChangeVideo.Enabled := AValue;
  ButtonStartScrape.Enabled := AValue;
  ButtonRemovePicture.Enabled := AValue;
  ButtonRemoveVideo.Enabled := AValue;
  ButtonSetDefaultPicture.Enabled := AValue;
  MenuItemGameDelete.Enabled := AValue;
  ButtonGameDelete.Enabled := AValue;

  MenuItemSystem.Enabled := AValue or not (FSystemList.Count = 0);
  MenuItemGame.Enabled := AValue and not (ListBoxGames.Items.Count = 0);

  EditGameName.Enabled := AValue;
  EditGameGenre.Enabled := AValue;
  EditGameRating.Enabled := AValue;
  EditGameRegion.Enabled := AValue;
  EditGameDeveloper.Enabled := AValue;
  EditGamePublisher.Enabled := AValue;
  EditGameReleaseDate.Enabled := AValue;
  EditGamePlayers.Enabled := AValue;
  EditGameRomPath.Enabled := AValue;
  MemoGameDescription.Enabled := AValue;

  CheckBoxGameKids.Enabled := AValue;
  CheckBoxGameHidden.Enabled := AValue;
  CheckBoxGameFavorite.Enabled := AValue;
  CheckBoxGamesListByRom.Enabled := AValue;
  CheckBoxManualCRC.Enabled := ButtonStartScrape.Enabled;

  if not AValue then
    StopGameVideo;
end;

procedure TFormMain.FieldChange(Sender: TObject);
begin
  CheckIfChangesToSave;
end;

procedure TFormMain.CheckIfChangesToSave;
begin
  if FIsLoading then
    Exit;

  if SelCount(ListBoxGames) > 1 then
    ButtonSaveChanges.Enabled := not (EditGameName.Text = '') or
      not (EditGameGenre.Text = '') or
      not (EditGameRating.Text = '') or
      not (EditGamePlayers.Text = '') or
      not (EditGameDeveloper.Text = '') or
      not (EditGamePublisher.Text = '') or
      not (EditGameReleaseDate.Text = '') or
      not (MemoGameDescription.Text = '') or
      not (EditGameRegion.Text = '') or
      not (CheckBoxGameKids.IsChecked = False) or
      not (CheckBoxGameHidden.IsChecked = False) or
      not (CheckBoxGameFavorite.IsChecked = False)
  else
  begin
    var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;
    ButtonSaveChanges.Enabled :=
      not (Game.Name.Equals(EditGameName.Text)) or
      not (Game.Genre.Equals(EditGameGenre.Text)) or
      not (Game.Rating.Equals(EditGameRating.Text)) or
      not (Game.Players.Equals(EditGamePlayers.Text)) or
      not (Game.Developer.Equals(EditGameDeveloper.Text)) or
      not (Game.Publisher.Equals(EditGamePublisher.Text)) or
      not (Game.ReleaseDate.Equals(EditGameReleaseDate.Text)) or
      not (Game.Description.Equals(MemoGameDescription.Text)) or
      not (Game.Region.Equals(EditGameRegion.Text)) or
      not (Game.KidGame = CheckBoxGameKids.IsChecked) or
      not (Game.Hidden = CheckBoxGameHidden.IsChecked) or
      not (Game.Favorite = CheckBoxGameFavorite.IsChecked);
  end;
end;

procedure TFormMain.FillGameItem(Item: TListBoxItemGame; Game: TGame);
begin
  var GameName: string := '';
  if CheckBoxGamesListByRom.IsChecked then
  begin
    if CheckBoxGamesFullRomName.IsChecked then
      GameName := Game.RomName
    else
      GameName := Game.RomNameWoExt;
  end
  else
    GameName := Game.Name;
  try
    if TFile.Exists(Game.PhysicalBoxPath) then
      Item.ItemData.Bitmap.LoadThumbnailFromFile(Game.PhysicalBoxPath, 64, 64)
    else
      Item.ItemData.Bitmap := nil;
  except
    Item.ItemData.Bitmap := nil;
  end;
  if Item.ItemData.Bitmap.IsEmpty then
    Item.ItemData.Bitmap := ImageNoBox.Bitmap;

  Item.ItemData.Detail := Game.Genre;
  Item.StylesData['info'] := Game.Developer + ' ● ' + Game.Year;
  Item.StylesData['rating'] := Game.Rating;
  Item.StylesData['warn.Visible'] := Game.IsOrphan;
  Item.StylesData['favorite.Visible'] := Game.Favorite;
  Item.Text := GameName;
  Item.Game := Game;
end;

procedure TFormMain.LoadGamesList(const ASystem: string);

  function CheckIfFileMissing(const ALink: string): Boolean;
  begin
    Result := ALink.IsEmpty or not (TFile.Exists(ALink));
  end;

  function AdjustDecimalSeparator(const Value: string): string;
  begin
    Result := Value.Replace(',', '.', [rfReplaceAll]);
  end;

  function FlexibleDateParse(const ADateStr: string): TDate;
  begin
    if ADateStr.Length = 4 then // Only year provided
    begin
      Result := EncodeDate(StrToIntDef(ADateStr, 0), 1, 1);
    end
    else if (ADateStr.CountChar('-') = 1) or (ADateStr.CountChar(PathDelim) = 1) then // Year and month provided
    begin
      var Year := StrToIntDef(Copy(ADateStr, 1, 4), 0);
      var Month := StrToIntDef(Copy(ADateStr, 6, 2), 0);
      Result := EncodeDate(Year, Month, 1);
    end
    else
    begin // Assume full date
      Result := StrToDateDef(ADateStr, Now);
    end;
  end;

  function SameFolder(Path1, Path2: string): Boolean;
  begin
    try
      Result := AnsiSameText(ExtractFilePath(Path1), ExtractFilePath(Path2));
    except
      Result := False;
    end;
  end;

  procedure InitializeDuplicateDictionaries(const GameList: TObjectList<TGame>; const FilterIndex: Integer; out NameCountMap: TDictionary<string, Integer>; out ROMPathCountMap: TDictionary<string, Integer>);
  begin
    NameCountMap := nil;
    ROMPathCountMap := nil;

     // Create dictionaries only for relevant filters
    if (FilterIndex = 29) then
      NameCountMap := TDictionary<string, Integer>.Create;
    if (FilterIndex = 30) then
      ROMPathCountMap := TDictionary<string, Integer>.Create;

    try
      for var Game in GameList do
      begin
         // Count game names for filter 29 (All with duplicate name)
        if (FilterIndex = 29) and Assigned(NameCountMap) then
        begin
          if NameCountMap.ContainsKey(Game.Name) then
            NameCountMap[Game.Name] := NameCountMap[Game.Name] + 1
          else
            NameCountMap.Add(Game.Name, 1);
        end;

         // Count ROM paths for filter 30 (All with duplicate roms)
        if (FilterIndex = 30) and Assigned(ROMPathCountMap) then
        begin
          var ROMFileName := ExtractFileName(Game.PhysicalRomPath);
          if ROMPathCountMap.ContainsKey(ROMFileName) then
            ROMPathCountMap[ROMFileName] := ROMPathCountMap[ROMFileName] + 1
          else
            ROMPathCountMap.Add(ROMFileName, 1);
        end;
      end;
    except
      on E: Exception do
      begin
         // Make sure dictionaries are still initialized with empty values
        if (FilterIndex = 29) and not Assigned(NameCountMap) then
          NameCountMap := TDictionary<string, Integer>.Create;
        if (FilterIndex = 30) and not Assigned(ROMPathCountMap) then
          ROMPathCountMap := TDictionary<string, Integer>.Create;
         // Handle catastrophic failure in the counting process
        WarnUser('Error while searching for duplicates: ' + E.Message);
      end;
    end;
  end;

var
  ReferenceGame: TGame;
  TmpList: TObjectList<TGame>;
  FilterIndex: Integer;
  ParsedReferenceRating, ParsedGameRating: Double;
  ParsedReferenceDate: TDate;
  NameCountMap: TDictionary<string, Integer>;
  ROMPathCountMap: TDictionary<string, Integer>;
begin
  FilterIndex := ComboBoxGamesFilter.ItemIndex;
  ParsedGameRating := 0;
  StopGameVideo;

  if FSystemList.TryGetValue(ASystem, TmpList) then
  begin
    FormatSettings := TFormatSettings.Create;
    FormatSettings.DecimalSeparator := '.';

    if Assigned(ListBoxGames.Selected) then
      ReferenceGame := (ListBoxGames.Selected as TListBoxItemGame).Game
    else
      ReferenceGame := nil;

    if Assigned(ReferenceGame) then
    begin
      ParsedReferenceRating := StrToFloatDef(AdjustDecimalSeparator(ReferenceGame.Rating), 0, FormatSettings);
      ParsedReferenceDate := FlexibleDateParse(ReferenceGame.ReleaseDate);
    end
    else
    begin
      ParsedReferenceRating := 0;
      ParsedReferenceDate := Now;
    end;

    if (GetCurrentLogoName = Cst_SystemKindImageNames[TSystemKind.MegaDrive]) and GenesisLogo then
      LoadSystemLogo(Cst_SystemKindImageNames[TSystemKind.Genesis])
    else
      LoadSystemLogo(GetCurrentLogoName);

    FCurrentFolder := GetCurrentFolderName;

    FIsLoading := True;

    if (FilterIndex = 29) or (FilterIndex = 30) then
    begin
      InitializeDuplicateDictionaries(TmpList, FilterIndex, NameCountMap, ROMPathCountMap);
    end;

    ListBoxGames.BeginUpdate;
    try
      ListBoxGames.Clear;
      for var TmpGame in TmpList do
      begin
        if (FilterIndex = 21) or (FilterIndex = 22) then
        begin
          ParsedGameRating := StrToFloatDef(AdjustDecimalSeparator(TmpGame.Rating), 0, FormatSettings);
        end;

        if (FilterIndex = 0) or
          ((FilterIndex = 1) and (CheckIfFileMissing(TmpGame.PhysicalImagePath))) or
          ((FilterIndex = 2) and (CheckIfFileMissing(TmpGame.PhysicalVideoPath))) or
          ((FilterIndex = 3) and (TmpGame.ReleaseDate.IsEmpty)) or
          ((FilterIndex = 4) and (TmpGame.Players.IsEmpty)) or
          ((FilterIndex = 5) and (TmpGame.Rating.IsEmpty)) or
          ((FilterIndex = 6) and (TmpGame.Developer.IsEmpty)) or
          ((FilterIndex = 7) and (TmpGame.Publisher.IsEmpty)) or
          ((FilterIndex = 8) and (TmpGame.Description.IsEmpty)) or
          ((FilterIndex = 9) and (TmpGame.Genre.IsEmpty)) or
          ((FilterIndex = 10) and (TmpGame.Region.IsEmpty)) or
          ((FilterIndex = 11) and (TmpGame.KidGame)) or
          ((FilterIndex = 12) and (TmpGame.Hidden)) or
          ((FilterIndex = 13) and (TmpGame.Favorite)) or
          ((FilterIndex = 14) and (TmpGame.IsOrphan)) or
          ((FilterIndex = 15) and Assigned(ReferenceGame) and (TmpGame.Region = ReferenceGame.Region)) or
          ((FilterIndex = 16) and Assigned(ReferenceGame) and (TmpGame.ReleaseDate = ReferenceGame.ReleaseDate)) or
          ((FilterIndex = 17) and Assigned(ReferenceGame) and (not TmpGame.ReleaseDate.IsEmpty) and (FlexibleDateParse(TmpGame.ReleaseDate) <= ParsedReferenceDate)) or
          ((FilterIndex = 18) and Assigned(ReferenceGame) and (not TmpGame.ReleaseDate.IsEmpty) and (FlexibleDateParse(TmpGame.ReleaseDate) >= ParsedReferenceDate)) or
          ((FilterIndex = 19) and Assigned(ReferenceGame) and (TmpGame.Players = ReferenceGame.Players)) or
          ((FilterIndex = 20) and Assigned(ReferenceGame) and (TmpGame.Rating = ReferenceGame.Rating)) or
          ((FilterIndex = 21) and Assigned(ReferenceGame) and (not TmpGame.Rating.IsEmpty) and (ParsedGameRating <= ParsedReferenceRating)) or
          ((FilterIndex = 22) and Assigned(ReferenceGame) and (not TmpGame.Rating.IsEmpty) and (ParsedGameRating >= ParsedReferenceRating)) or
          ((FilterIndex = 23) and Assigned(ReferenceGame) and (TmpGame.Publisher = ReferenceGame.Publisher)) or
          ((FilterIndex = 24) and Assigned(ReferenceGame) and (TmpGame.Developer = ReferenceGame.Developer)) or
          ((FilterIndex = 25) and Assigned(ReferenceGame) and (TmpGame.Genre = ReferenceGame.Genre)) or
          ((FilterIndex = 26) and Assigned(ReferenceGame) and (SameFolder(TmpGame.PhysicalRomPath, ReferenceGame.PhysicalRomPath))) or
          ((FilterIndex = 27) and Assigned(ReferenceGame) and (TmpGame.Name = ReferenceGame.Name)) or
          ((FilterIndex = 28) and Assigned(ReferenceGame) and (ExtractFileName(TmpGame.PhysicalRomPath) = ExtractFileName(ReferenceGame.PhysicalRomPath))) or
          ((FilterIndex = 29) and NameCountMap.ContainsKey(TmpGame.Name) and (NameCountMap[TmpGame.Name] > 1)) or
          ((FilterIndex = 30) and ROMPathCountMap.ContainsKey(ExtractFileName(TmpGame.PhysicalRomPath)) and
          (ROMPathCountMap[ExtractFileName(TmpGame.PhysicalRomPath)] > 1)) then
        begin
          var Item := TListBoxItemGame.Create(ListBoxGames);
          ListBoxGames.AddObject(Item);
          FillGameItem(Item, TmpGame);
        end
      end;
    finally
      ListBoxGames.EndUpdate;
    end;

      // Free the dictionaries if they were created
    if (FilterIndex = 29) or (FilterIndex = 30) then
    begin
      if Assigned(NameCountMap) then
        NameCountMap.Free;
      if Assigned(ROMPathCountMap) then
        ROMPathCountMap.Free;
    end;

    if ComboBoxGamesFilter.ItemIndex = 0 then
      LabelGamesCount.Text := Format('Count: %d', [ListBoxGames.Items.Count])
    else
      LabelGamesCount.Text := Format('Count: %d/%d', [ListBoxGames.Items.Count, TmpList.Count]);

    ClearAllFields;

    if (ListBoxGames.Items.Count > 0) then
    begin
      EnableControls(True);
      ListBoxGames.ItemIndex := 0;
      LoadGame(TListBoxItemGame(ListBoxGames.Selected).Game);
    end
    else
    begin
      MenuItemChangeAll.Enabled := False;
      EnableControls(False);
    end;

    FIsLoading := False;
  end;
end;

procedure TFormMain.LoadSystemLogo(const aPictureName: string);
begin
  try
    ImageSystemLogo.Bitmap.LoadFromFile(TPath.Combine(TPath.GetLibraryPath, Cst_LogoPicsFolder, aPictureName));
  except
  end;
end;

procedure TFormMain.LabelSetCaption1Click(Sender: TObject);
begin
  TabControlSettings.ActiveTab := TabItemSettingsMain;
end;

procedure TFormMain.ListBoxGamesChange(Sender: TObject);
begin
  ClearAllFields;
  EmptyScrapeFields;
  {selcount}
  if SelCount(ListBoxGames) > 1 then
  begin
    EnableComponents(False);
  end
  else
  begin
    EnableComponents(True);
    TThread.ForceQueue(nil,
      procedure
      begin
        if Assigned(ListBoxGames.Selected) then
          LoadGame((ListBoxGames.Selected as TListBoxItemGame).Game);
      end);
  end;
end;

procedure TFormMain.ListBoxMediaChange(Sender: TObject);
begin
  if not Assigned(ListBoxMedia.Selected) then
    Exit;
  if ListBoxMedia.Selected.ItemData.Bitmap.IsEmpty then
    Exit;
  CheckBoxScrapePicture.Enabled := True;
  CheckBoxScrapePicture.IsChecked := True;
end;

//Click sur un jeu dans la liste
procedure TFormMain.ListBoxSystemsChange(Sender: TObject);
begin
  EmptyScrapeFields;
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.EnableComponents(AValue: Boolean);
begin
  EditGameName.Enabled := AValue;
  EditGameGenre.Enabled := True;
  EditGameRating.Enabled := True;
  EditGameRegion.Enabled := True;
  EditGameDeveloper.Enabled := True;
  EditGamePublisher.Enabled := True;
  EditGamePlayers.Enabled := True;
  EditGameReleaseDate.Enabled := True;
  EditGameRomPath.Enabled := AValue;

  MemoGameDescription.Enabled := True;

  CheckBoxGameKids.Enabled := True;
  CheckBoxGameHidden.Enabled := True;
  CheckBoxGameFavorite.Enabled := True;
  CheckBoxGamesListByRom.Enabled := AValue;

  MenuItemGameDelete.Enabled := True;
  ButtonGameDelete.Enabled := True;
  ButtonStartScrape.Enabled := AValue;
  ButtonChangeImage.Enabled := AValue;
  ButtonChangeVideo.Enabled := AValue;
  ButtonRemovePicture.Enabled := AValue;
  ButtonRemoveVideo.Enabled := AValue;
  ButtonSetDefaultPicture.Enabled := AValue;
  MenuItemChangeAll.Enabled := AValue and (ComboBoxGamesFilter.ItemIndex = 1) and (ListBoxGames.Items.Count > 0);

  MenuItemGame.Enabled := AValue;
  MenuItemSystem.Enabled := AValue;
  MenuItemSelection.Enabled := not AValue;

  CheckBoxManualCRC.Enabled := ButtonStartScrape.Enabled;

  if not AValue then
    StopGameVideo;
end;

procedure TFormMain.StartGameVideo(const APath: string);
begin
  ImageGameBackgroundVideo.Visible := False;
  LayoutPlayer.Visible := True;
  VlcPlayer.Play(APath);
end;

procedure TFormMain.StopGameVideo;
begin
  ImageGameBackgroundVideo.Visible := True;
  LayoutPlayer.Visible := False;
  VlcPlayer.Stop;
end;

procedure TFormMain.UpdateManual(AGame: TGame);
begin
  FPdfViewer.LoadFromFile(AGame.PhysicalManualPath);
  TabControlEditor.ActiveTab := TabItemEditManual;
end;

procedure TFormMain.UpdateVideo(AGame: TGame);
begin
  if (TabControlMedia.ActiveTab = TabItemMediaVideo) and (TabControlEditor.ActiveTab = TabItemEditGame) and
    (not AGame.VideoPath.IsEmpty) and TFile.Exists(AGame.PhysicalVideoPath) then
  begin
    StartGameVideo(AGame.PhysicalVideoPath);
  end
  else
  begin
    StopGameVideo;
  end;
  ButtonRemoveVideo.Enabled := (not AGame.VideoPath.IsEmpty) and TFile.Exists(AGame.PhysicalVideoPath);
end;

procedure TFormMain.UpdateImage(AGame: TGame);
begin
  if not AGame.ImagePath.IsEmpty and TFile.Exists(AGame.PhysicalImagePath) then
  begin
    try
      ImageGame.Bitmap.LoadFromFile(AGame.PhysicalImagePath);
    except
      ImageGame.Bitmap := nil;
    end;

    ButtonRemovePicture.Enabled := True;
    ImageGameBackground.Visible := ImageGame.Bitmap.IsEmpty;
    ImageGame.Visible := not ImageGame.Bitmap.IsEmpty;
  end
  else
  begin
    ImageGame.Bitmap := nil;
    ButtonRemovePicture.Enabled := False;
    ImageGameBackground.Visible := True;
    ImageGame.Visible := False;
  end;
end;

procedure TFormMain.TabControlMediaChange(Sender: TObject);
begin
  RadioButtonPreviewPicture.IsChecked := (TabControlEditor.ActiveTab = TabItemEditGame) and (TabControlMedia.ActiveTab = TabItemMediaPicture);
  RadioButtonPreviewVideo.IsChecked := (TabControlEditor.ActiveTab = TabItemEditGame) and (TabControlMedia.ActiveTab = TabItemMediaVideo);
  RadioButtonPreviewManual.IsChecked := (TabControlEditor.ActiveTab = TabItemEditManual);
  RadioButtonPreviewHash.IsChecked := (TabControlEditor.ActiveTab = TabItemEditGame) and (TabControlMedia.ActiveTab = TabItemMediaHash);
  if Assigned(ListBoxGames.Selected) then
  begin
    UpdateVideo((ListBoxGames.Selected as TListBoxItemGame).Game);
    if RadioButtonPreviewManual.IsChecked then
      UpdateManual((ListBoxGames.Selected as TListBoxItemGame).Game);
  end;
  if (TabControlEditor.ActiveTab = TabItemEditGame) and (TabControlMedia.ActiveTab = TabItemMediaHash) and Assigned(ListBoxGames.Selected) then
  begin
    ButtonCalsHash.Enabled := False;
    var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;

    if Game.Md5.IsEmpty or Game.Sha1.IsEmpty or Game.Crc32.IsEmpty then
    begin
      ButtonCalsHash.Enabled := True;
      if AutoHash or (MyMessageDlg(Rst_Info, Rst_HashWarning, [Rst_Yes, Rst_No]) = 0) then
      begin
        Game.Md5 := Game.CalculateMd5(Game.PhysicalRomPath);
        Game.Sha1 := Game.CalculateSha1(Game.PhysicalRomPath);
        Game.Crc32 := Game.CalculateCrc32(Game.PhysicalRomPath);
        ButtonCalsHash.Enabled := False;
      end;
    end;
    EditGameHashCRC32.Text := Game.Crc32;
    EditGameHashMD5.Text := Game.Md5;
    EditGameHashSHA1.Text := Game.Sha1;
  end;
end;

procedure TFormMain.TabControlSettingsChange(Sender: TObject);
begin
  if TabControlSettings.ActiveTab = TabItemSettingsMain then
  begin
    LabelSetCaption2.Visible := False;
    PathLabelSet1.Visible := False;
  end
  else if TabControlSettings.ActiveTab = TabItemSettingsNetwork then
  begin
    LabelSetCaption2.Visible := True;
    PathLabelSet1.Visible := True;
    LabelSetCaption2.Text := Translate('Network');
  end
  else if TabControlSettings.ActiveTab = TabItemSettingsView then
  begin
    LabelSetCaption2.Visible := True;
    PathLabelSet1.Visible := True;
    LabelSetCaption2.Text := Translate('View');
  end
  else if TabControlSettings.ActiveTab = TabItemSettingsSSH then
  begin
    LabelSetCaption2.Visible := True;
    PathLabelSet1.Visible := True;
    LabelSetCaption2.Text := Translate('SSH');
  end;
end;

procedure TFormMain.LoadGame(AGame: TGame);
begin
  if not Assigned(AGame) then
  begin
    ClearAllFields;
    EmptyScrapeFields;
    StopGameVideo;
    Exit;
  end;

  FIsLoading := True;

  ImageGameBackground.Visible := True;

  EditGameName.Text := AGame.Name;
  EditGameRating.Text := AGame.Rating;
  EditGameReleaseDate.Text := AGame.ReleaseDate;
  EditGamePublisher.Text := AGame.Publisher;
  EditGameDeveloper.Text := AGame.Developer;
  EditGamePlayers.Text := AGame.Players;
  EditGameGenre.Text := AGame.Genre;
  EditGameRegion.Text := AGame.Region;
  MemoGameDescription.Text := AGame.Description;
  EditGameHashCRC32.Text := AGame.Crc32;
  EditGameHashMD5.Text := AGame.Md5;
  EditGameHashSHA1.Text := AGame.Sha1;
  ButtonCalsHash.Enabled := AGame.Md5.IsEmpty or AGame.Sha1.IsEmpty or AGame.Crc32.IsEmpty;
  EditGamePlayCount.Text := AGame.Playcount;
  if not AGame.Lastplayed.IsEmpty then
    EditGameLastPlayed.Text := FormatDateTime('dd/mm/yyyy hh:mm:ss', ISO8601ToDate(AGame.Lastplayed))
  else
    EditGameLastPlayed.Text := '';

  EditOldName.Text := AGame.Name;
  EditOldRating.Text := AGame.Rating;
  EditOldDate.Text := AGame.ReleaseDate;
  EditOldPublisher.Text := AGame.Publisher;
  EditOldDeveloper.Text := AGame.Developer;
  EditOldPlayers.Text := AGame.Players;
  EditOldGenre.Text := AGame.Genre;
  EditOldRegion.Text := AGame.Region;
  MemoOldDescription.Text := AGame.Description;

  CheckBoxGameKids.IsChecked := AGame.KidGame;
  CheckBoxGameHidden.IsChecked := AGame.Hidden;
  CheckBoxGameFavorite.IsChecked := AGame.Favorite;
  EditGameRomPath.Text := AGame.RomPath;
  TabControlEditor.ActiveTab := TabItemEditGame;
  UpdateVideo(AGame);
  UpdateImage(AGame);
  RadioButtonPreviewManual.Enabled := TFile.Exists(AGame.PhysicalManualPath);
  ButtonStartScrape.Enabled := TFile.Exists(AGame.PhysicalRomPath);
  CheckBoxManualCRC.Enabled := ButtonStartScrape.Enabled;
  FIsLoading := False;
end;

procedure TFormMain.ButtonCalsHashClick(Sender: TObject);
begin
  if not Assigned(ListBoxGames.Selected) then
    Exit;

  var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;

  Game.Md5 := Game.CalculateMd5(Game.PhysicalRomPath);
  Game.Sha1 := Game.CalculateSha1(Game.PhysicalRomPath);
  Game.Crc32 := Game.CalculateCrc32(Game.PhysicalRomPath);

  EditGameHashCRC32.Text := Game.Crc32;
  EditGameHashMD5.Text := Game.Md5;
  EditGameHashSHA1.Text := Game.Sha1;
end;

procedure TFormMain.ButtonChangeImageClick(Sender: TObject);
begin
  OpenFile.Filter := 'Images|*.png;*.jpg;*.jpeg';
  if OpenFile.Execute and (OpenFile.FileName <> '') then
  begin
    var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;
    ChangeImage(OpenFile.FileName, Game);
    UpdateImage(Game);
  end;
end;

procedure TFormMain.ButtonChangeVideoClick(Sender: TObject);
begin
  StopGameVideo;
  OpenFile.Filter := 'Videos|*.mp4';
  if OpenFile.Execute and (OpenFile.FileName <> '') then
  begin
    var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;
    ChangeVideo(OpenFile.FileName, Game);
    UpdateVideo(Game);
  end;
end;

procedure TFormMain.ButtonChooseFolderClick(Sender: TObject);
begin
  BuildSystemsList;
end;

procedure TFormMain.ButtonSetDefaultPictureClick(Sender: TObject);
begin
  var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;

  var PathToDefault := TPath.Combine(TPath.GetLibraryPath, Cst_DefaultPicsFolderPath, GetCurrentFolderName + Cst_DefaultImageNameSuffix);

  if not TFile.Exists(PathToDefault) then
    PathToDefault := TPath.Combine(TPath.GetLibraryPath, Cst_DefaultPicsFolderPath, Cst_DefaultImageName);

  ChangeImage(PathToDefault, Game);
  LoadGame(Game);
end;

procedure TFormMain.ButtonSetNetworkClick(Sender: TObject);
begin
  TabControlSettings.ActiveTab := TabItemSettingsNetwork;
end;

procedure TFormMain.ButtonSettingsBackClick(Sender: TObject);
begin
  if TabControlSettings.ActiveTab <> TabItemSettingsMain then
    TabControlSettings.ActiveTab := TabItemSettingsMain
  else
    TabControlMain.ActiveTab := TabItemMainGameList;
end;

procedure TFormMain.ButtonSettingsClick(Sender: TObject);
begin
  TabControlMain.ActiveTab := TabItemMainSettings;
  TabControlSettings.ActiveTab := TabItemSettingsMain;
  TabControlSettingsChange(nil);
end;

procedure TFormMain.ButtonSettingsHelpClick(Sender: TObject);
begin      {
  var Frm_Help := TFrm_Help.Create(nil);
  try
    Frm_Help.Chk_ShowTips.Visible := False;
    FShowTips := Frm_Help.Execute(not FShowTips);
  finally
    Frm_Help.Free;
  end;  }
  TabControlMain.ActiveTab := TabItemMainHelp;
end;

procedure TFormMain.ButtonSettingsSSHClick(Sender: TObject);
begin
  TabControlSettings.ActiveTab := TabItemSettingsSSH;
end;

procedure TFormMain.ButtonSetViewClick(Sender: TObject);
begin
  TabControlSettings.ActiveTab := TabItemSettingsView;
end;

procedure TFormMain.ButtonBtn_ChangeAll1Click(Sender: TObject);
begin
  var PathToDefault := TPath.Combine(TPath.GetLibraryPath, Cst_DefaultPicsFolderPath, GetCurrentFolderName + Cst_DefaultImageNameSuffix);

  if not TFile.Exists(PathToDefault) then
    PathToDefault := TPath.Combine(TPath.GetLibraryPath, Cst_DefaultPicsFolderPath, Cst_DefaultImageName);

  for var i := 0 to Pred(ListBoxGames.Items.Count) do
  begin
    var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
    ChangeImage(PathToDefault, Game);
  end;
  LoadGamesList(GetCurrentFolderName);
end;

function PathToXMLPath(const Value: string): string;
begin
  Result := './' + Value.Replace(PathDelim, '/', [rfReplaceAll]);
end;

function TFormMain.GetCurrentGameListPath: string;
begin
  Result := TPath.Combine(FRootPath, FCurrentFolder, Cst_GameListFileName);
end;

procedure TFormMain.ChangeImage(const APath: string; AGame: TGame);
begin
  var ImagesPath := TPath.Combine(FRootPath, FCurrentFolder, Cst_SystemImagesPath);

  if not TDirectory.Exists(ImagesPath) then
    TDirectory.CreateDirectory(ImagesPath);

  var Bitmap := TBitmap.Create;
  try
    Bitmap.LoadFromFile(APath);
    Bitmap.SaveToFile(TPath.Combine(ImagesPath, AGame.RomNameWoExt + Cst_ImageSuffixPng));
  finally
    Bitmap.Free;
  end;

  XMLDoc.LoadFromFile(GetCurrentGameListPath);

  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

  while Assigned(Node) do
  begin
    if Node.ChildNodes.Nodes[Cst_Path].Text = AGame.RomPath then
      Break;
    Node := Node.NextSibling;
  end;

  if not Assigned(Node) then
    Exit;

  var ImageLink := TPath.Combine(Cst_SystemImagesPath, AGame.RomNameWoExt + Cst_ImageSuffixPng);

  var NodeAdded := False;
  if not Assigned(Node.ChildNodes.FindNode(Cst_ImageLink)) then
  begin
    Node.AddChild(Cst_ImageLink);
    NodeAdded := True;
  end;
  Node.ChildNodes.Nodes[Cst_ImageLink].Text := PathToXMLPath(ImageLink);

  if NodeAdded then
  begin
    XMLDoc.XML.Text := Xml.Xmldoc.FormatXMLData(XMLDoc.XML.Text);
    XMLDoc.Active := True;
  end;
  XMLDoc.SaveToFile(GetCurrentGameListPath);
  XMLDoc.Active := False;

  AGame.ImagePath := PathToXMLPath(ImageLink);
end;

procedure TFormMain.ChangeVideo(const APath: string; AGame: TGame);
begin
  var VideosPath := TPath.Combine(FRootPath, FCurrentFolder, Cst_SystemVideosPath);

  if not TDirectory.Exists(VideosPath) then
    TDirectory.CreateDirectory(VideosPath);

  TFile.Copy(APath, TPath.Combine(VideosPath, AGame.RomNameWoExt + Cst_VideoSuffixMp4), True);

  XMLDoc.LoadFromFile(GetCurrentGameListPath);

  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

  while Assigned(Node) do
  begin
    if Node.ChildNodes.Nodes[Cst_Path].Text = AGame.RomPath then
      Break;
    Node := Node.NextSibling;
  end;

  if not Assigned(Node) then
    Exit;

  var VideoLink := TPath.Combine(Cst_SystemVideosPath, AGame.RomNameWoExt + Cst_VideoSuffixMp4);

  var NodeAdded := False;
  if not Assigned(Node.ChildNodes.FindNode(Cst_VideoLink)) then
  begin
    Node.AddChild(Cst_VideoLink);
    NodeAdded := True;
  end;
  Node.ChildNodes.Nodes[Cst_VideoLink].Text := PathToXMLPath(VideoLink);

  if NodeAdded then
  begin
    XMLDoc.XML.Text := Xml.Xmldoc.FormatXMLData(XMLDoc.XML.Text);
    XMLDoc.Active := True;
  end;
  XMLDoc.SaveToFile(GetCurrentGameListPath);
  XMLDoc.Active := False;

  AGame.VideoPath := PathToXMLPath(VideoLink);
end;

procedure TFormMain.ButtonReloadFolderClick(Sender: TObject);
begin
  ImageGameBackground.Visible := True;
  EnableControls(False);
  ClearAllFields;
  ListBoxGames.Clear;
  BuildSystemsList(True);
  ButtonSaveChanges.Enabled := False;
end;

procedure TFormMain.ButtonRemovePictureClick(Sender: TObject);
begin
  DeleteGamePicture;
end;

procedure TFormMain.ButtonRemoveVideoClick(Sender: TObject);
begin
  DeleteGameVideo;
end;

procedure TFormMain.DeleteGamePicture;
begin
  var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);

  var ImageReused := False;
  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
  repeat
    if not Assigned(Node.ChildNodes.FindNode(Cst_Path)) then
    begin
      Node := Node.NextSibling;
      Continue;
    end;
    if Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath then
    begin
      Node := Node.NextSibling;
      Continue;
    end;
    if not Assigned(Node.ChildNodes.FindNode(Cst_ImageLink)) then
    begin
      Node := Node.NextSibling;
      Continue;
    end;
    if (Node.ChildNodes.Nodes[Cst_ImageLink].Text = Game.ImagePath) then
    begin
      ImageReused := True;
      Break;
    end;
    Node := Node.NextSibling;
  until not Assigned(Node) or ImageReused;

  Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

  while Assigned(Node) do
  begin
    if Assigned(Node.ChildNodes.FindNode(Cst_Path)) then
      if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
        Break;
    Node := Node.NextSibling;
  end;

  if not Assigned(Node) then
    Exit;

  if Assigned(Node.ChildNodes.FindNode(Cst_ImageLink)) then
    Node.ChildNodes.Nodes[Cst_ImageLink].Text := '';

  XMLDoc.Active := True;
  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;

  if not ImageReused then
  try
    TFile.Delete(Game.PhysicalImagePath);
  except
    WarnUser('Can''t remove picture file: ' + Game.PhysicalImagePath);
  end;

  Game.ImagePath := '';

  UpdateImage(Game);
end;

procedure TFormMain.DeleteGameVideo;
begin
  StopGameVideo;

  var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);

  var VideoReused := False;
  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
  repeat
    if not Assigned(Node.ChildNodes.FindNode(Cst_Path)) then
    begin
      Node := Node.NextSibling;
      Continue;
    end;
    if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
    begin
      Node := Node.NextSibling;
      Continue;
    end;
    if not Assigned(Node.ChildNodes.FindNode(Cst_VideoLink)) then
    begin
      Node := Node.NextSibling;
      Continue;
    end;
    if (Node.ChildNodes.Nodes[Cst_VideoLink].Text = Game.VideoPath) then
    begin
      VideoReused := True;
      Break;
    end;
    Node := Node.NextSibling;
  until not Assigned(Node) or VideoReused;

  Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

  while Assigned(Node) do
  begin
    if Assigned(Node.ChildNodes.FindNode(Cst_Path)) then
      if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
        Break;
    Node := Node.NextSibling;
  end;

  if not Assigned(Node) then
    Exit;

  if Assigned(Node.ChildNodes.FindNode(Cst_VideoLink)) then
    Node.ChildNodes.Nodes[Cst_VideoLink].Text := '';
  XMLDoc.Active := True;
  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;

  if not VideoReused then
  try
    TFile.Delete(Game.PhysicalVideoPath);
  except
    WarnUser('Can''t remove video file: ' + Game.PhysicalVideoPath);
  end;

  Game.VideoPath := '';

  UpdateVideo(Game);
end;

function TFormMain.GetShowTips: Boolean;
begin
  Result := CheckBoxSetShowTips.IsChecked;
end;

function TFormMain.GetSSLogin: string;
begin
  Result := EditSetScreenLogin.Text;
end;

function TFormMain.GetSSPwd: string;
begin
  Result := EditSetScreenPwd.Text;
end;

function TFormMain.GetSystemKind: TSystemKind;
begin
  if Assigned(ListBoxSystems.Selected) then
    Result := TListBoxItemSystem(ListBoxSystems.Selected).SystemKind
  else
    Result := TSystemKind.Other;
end;

function TFormMain.GetCurrentFolderName: string;
begin
  if GetSystemKind = TSystemKind.Other then
    Result := if Assigned(ListBoxSystems) then ListBoxSystems.Selected.Text else ''
  else
    Result := Cst_SystemKindFolderNames[GetSystemKind];
end;

function TFormMain.GetCurrentLogoName: string;
begin
  Result := Cst_SystemKindImageNames[GetSystemKind];
end;

function TFormMain.GetCurrentSystemId: string;
begin
  Result := Cst_SystemKindId[GetSystemKind];
end;

function TFormMain.GetDelWoPrompt: Boolean;
begin
  Result := CheckBoxSetDelPrompts.IsChecked;
end;

procedure TFormMain.ButtonSaveChangesClick(Sender: TObject);
begin
  if SelCount(ListBoxGames) > 1 then
    SaveBatchChangesToGamelist()
  else
    SaveChangesToGamelist(False, False, False, True);

  ButtonSaveChanges.Enabled := False;
end;

procedure TFormMain.EmptyScrapeFields;
begin
  EditScrapeGenre.Text := '';
  EditScrapeName.Text := '';
  EditScrapePlayers.Text := '';
  EditScrapeDate.Text := '';
  EditScrapeRegion.Text := '';
  EditScrapeDeveloper.Text := '';
  EditScrapePublisher.Text := '';
  EditScrapeRating.Text := '';
  MemoScrapeDescription.Text := '';
  ListBoxMedia.Clear;

  EnableScrapeComponents(False);

  FInfosList.Clear;
  FPictureLinks.Clear;
  FImgList.Clear;
end;

procedure TFormMain.SaveBatchChangesToGamelist();

  function NodeExists(aNode: IXMLNode; const aNodeName: string): Boolean;
  begin
    Result := Assigned(aNode.ChildNodes.FindNode(aNodeName));
  end;

var
  Node: IXMLNode;
  GameListPath, _Date, Region, Rating, Developer, Players, Description, Publisher, Date, Genre: string;
  NodeAdded: Boolean;
  Index: Integer;
begin
  NodeAdded := False;

  GameListPath := GetCurrentGameListPath;

  Index := ListBoxGames.ItemIndex;

      //On ouvre le fichier xml
  XMLDoc.LoadFromFile(GameListPath);

  Genre := EditGameGenre.Text;
  Rating := EditGameRating.Text;
  Players := EditGamePlayers.Text;
  Developer := EditGameDeveloper.Text;
  Date := EditGameReleaseDate.Text;
  Publisher := EditGamePublisher.Text;
  Description := MemoGameDescription.Text;
  Region := EditGameRegion.Text;
  var KidGame := CheckBoxGameKids.IsChecked;
  var Hidden := CheckBoxGameHidden.IsChecked;
  var Favorite := CheckBoxGameFavorite.IsChecked;

      //on boucle sur les jeux sйlectionnйs
  for var i := 0 to Pred(ListBoxGames.Items.Count) do
  begin
    if (ListBoxGames.ListItems[i].IsSelected) then
    begin
      var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;

      Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
      repeat
        if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
          Break;
        Node := Node.NextSibling;
      until not Assigned(Node);

          //On peut maintenant mettre les infos а jour dans le xml si besoin
      if (Genre <> '') and not (Game.Genre.Equals(Genre)) then
      begin
        if not (NodeExists(Node, Cst_Genre)) then
        begin
          Node.AddChild(Cst_Genre);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Genre].Text := Genre;
        Game.Genre := Genre;
      end;

      if (Rating <> '') and not (Game.Rating.Equals(Rating)) then
      begin
        if not (NodeExists(Node, Cst_Rating)) then
        begin
          Node.AddChild(Cst_Rating);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Rating].Text := Rating;
        Game.Rating := Rating;
      end;

      if (Players <> '') and not (Game.Players.Equals(Players)) then
      begin
        if not (NodeExists(Node, Cst_Players)) then
        begin
          Node.AddChild(Cst_Players);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Players].Text := Players;
        Game.Players := Players;
      end;

      if (Developer <> '') and not (Game.Developer.Equals(Developer)) then
      begin
        if not (NodeExists(Node, Cst_Developer)) then
        begin
          Node.AddChild(Cst_Developer);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Developer].Text := Developer;
        Game.Developer := Developer;
      end;

      if (Date <> '') and not (Game.ReleaseDate.Equals(Date)) then
      begin
        if not (NodeExists(Node, Cst_ReleaseDate)) then
        begin
          Node.AddChild(Cst_ReleaseDate);
          NodeAdded := True;
        end;
        var Year: string;
        _Date := FormatDateFromString(Date, Year, True);
        if not _Date.IsEmpty then
          Game.ReleaseDate := Date
        else
        begin
          Game.ReleaseDate := '';
        end;
        Game.Year := Year;
        Node.ChildNodes.Nodes[Cst_ReleaseDate].Text := _Date;
      end;

      if (Publisher <> '') and not (Game.Publisher.Equals(Publisher)) then
      begin
        if not (NodeExists(Node, Cst_Publisher)) then
        begin
          Node.AddChild(Cst_Publisher);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Publisher].Text := Publisher;
        Game.Publisher := Publisher;
      end;

      if (Description <> '') and not (Game.Description.Equals(Description)) then
      begin
        if not (NodeExists(Node, Cst_Description)) then
        begin
          Node.AddChild(Cst_Description);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Description].Text := Description;
        Game.Description := Description;
      end;

      if (Region <> '') and not (Game.Region.Equals(Region)) then
      begin
        if not (NodeExists(Node, Cst_Region)) then
        begin
          Node.AddChild(Cst_Region);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Region].Text := Region;
        Game.Region := Region;
      end;

      if Game.KidGame <> KidGame then
      begin
        if not NodeExists(Node, Cst_KidGame) then
        begin
          Node.AddChild(Cst_KidGame);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_KidGame].Text := BoolStr(CheckBoxGameKids.IsChecked);
        Game.KidGame := KidGame;
      end;

      if Game.Hidden <> Hidden then
      begin
        if not NodeExists(Node, Cst_Hidden) then
        begin
          Node.AddChild(Cst_Hidden);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Hidden].Text := BoolStr(CheckBoxGameHidden.IsChecked);
        Game.Hidden := Hidden;
      end;

      if Game.Favorite <> Favorite then
      begin
        if not NodeExists(Node, Cst_Favorite) then
        begin
          Node.AddChild(Cst_Favorite);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Favorite].Text := BoolStr(CheckBoxGameFavorite.IsChecked);
        Game.Favorite := Favorite;
      end;
    end;
  end;

  if NodeAdded then
  begin
    XMLDoc.XML.Text := Xml.Xmldoc.FormatXMLData(XMLDoc.XML.Text);
    XMLDoc.Active := True;
  end;
  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;

  LoadGamesList(GetCurrentFolderName);

  if ListBoxGames.Count > 0 then
    ListBoxGames.ListItems[0].IsSelected := False;

  if ListBoxGames.Count = 0 then
    ListBoxGames.ItemIndex := -1
  else if ListBoxGames.Count > 0 then
  begin
    if Index >= ListBoxGames.Count then
      ListBoxGames.ItemIndex := Pred(ListBoxGames.Count)
    else
      ListBoxGames.ItemIndex := Index;
  end;

  if Assigned(ListBoxGames.Selected) then
  begin
    LoadGame((ListBoxGames.Selected as TListBoxItemGame).Game);
  end;
end;

procedure TFormMain.SaveChangesToGamelist(AScrape, ASaveVideo, ASavePic, ASaveInfos: Boolean);
var
  NodeAdded: Boolean;

  procedure CheckOrAddNode(const Node: IXMLNode; const NodeName: string);
  begin
    if not Assigned(Node.ChildNodes.FindNode(NodeName)) then
    begin
      Node.AddChild(NodeName);
      NodeAdded := True;
    end;
  end;

begin
  NodeAdded := False;
  var GameListPath := GetCurrentGameListPath;

  var Game: TGame;
  if AScrape then
    Game := FScrapedGame
  else
    Game := (ListBoxGames.Selected as TListBoxItemGame).Game;

  XMLDoc.LoadFromFile(GameListPath);
  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
  if not Assigned(Node) then
    Exit;

  repeat
    if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
      Break;
    Node := Node.NextSibling;
  until not Assigned(Node);

  if not Assigned(Node) then
    Exit;

  if ASaveInfos then
  begin
    var Name := if AScrape then EditScrapeName.Text else EditGameName.Text;
    if not Game.Name.Equals(Name) then
    begin
      Node.ChildNodes.Nodes[Cst_Name].Text := Name;
      Game.Name := Name;
    end;

    var Genre := if AScrape then EditScrapeGenre.Text else EditGameGenre.Text;
    if not Game.Genre.Equals(Genre) then
    begin
      CheckOrAddNode(Node, Cst_Genre);
      Node.ChildNodes.Nodes[Cst_Genre].Text := Genre;
      Game.Genre := Genre;
    end;

    var Rating := if AScrape then EditScrapeRating.Text else EditGameRating.Text;
    if not Game.Rating.Equals(Rating) then
    begin
      CheckOrAddNode(Node, Cst_Rating);
      Node.ChildNodes.Nodes[Cst_Rating].Text := Rating;
      Game.Rating := Rating;
    end;

    var Players := if AScrape then EditScrapePlayers.Text else EditGamePlayers.Text;
    if not Game.Players.Equals(Players) then
    begin
      CheckOrAddNode(Node, Cst_Players);
      Node.ChildNodes.Nodes[Cst_Players].Text := Players;
      Game.Players := Players;
    end;

    var Developer := if AScrape then EditScrapeDeveloper.Text else EditGameDeveloper.Text;
    if not Game.Developer.Equals(Developer) then
    begin
      CheckOrAddNode(Node, Cst_Developer);
      Node.ChildNodes.Nodes[Cst_Developer].Text := Developer;
      Game.Developer := Developer;
    end;

    var Date := if AScrape then EditScrapeDate.Text else EditGameReleaseDate.Text;
    if not Game.ReleaseDate.Equals(Date) then
    begin
      var Year: string;
      var FormatedDate := FormatDateFromString(Date, Year, True);
      CheckOrAddNode(Node, Cst_ReleaseDate);
      Node.ChildNodes.Nodes[Cst_ReleaseDate].Text := FormatedDate;
      Game.ReleaseDate := Date;
      Game.Year := Year;
    end;

    var Publisher := if AScrape then EditScrapePublisher.Text else EditGamePublisher.Text;
    if not Game.Publisher.Equals(Publisher) then
    begin
      CheckOrAddNode(Node, Cst_Publisher);
      Node.ChildNodes.Nodes[Cst_Publisher].Text := Publisher;
      Game.Publisher := Publisher;
    end;

    var Description := if AScrape then MemoScrapeDescription.Text else MemoGameDescription.Text;
    if not Game.Description.Equals(Description) then
    begin
      CheckOrAddNode(Node, Cst_Description);
      Node.ChildNodes.Nodes[Cst_Description].Text := Description;
      Game.Description := Description;
    end;

    var Region := if AScrape then EditScrapeRegion.Text else EditGameRegion.Text;
    if not Game.Region.Equals(Region) then
    begin
      CheckOrAddNode(Node, Cst_Region);
      Node.ChildNodes.Nodes[Cst_Region].Text := Region;
      Game.Region := Region;
    end;

    if not AScrape then
    begin
      if Game.KidGame <> CheckBoxGameKids.IsChecked then
      begin
        CheckOrAddNode(Node, Cst_KidGame);
        Node.ChildNodes.Nodes[Cst_KidGame].Text := BoolStr(CheckBoxGameKids.IsChecked);
        Game.KidGame := CheckBoxGameKids.IsChecked;
      end;

      if Game.Hidden <> CheckBoxGameHidden.IsChecked then
      begin
        CheckOrAddNode(Node, Cst_Hidden);
        Node.ChildNodes.Nodes[Cst_Hidden].Text := BoolStr(CheckBoxGameHidden.IsChecked);
        Game.Hidden := CheckBoxGameHidden.IsChecked;
      end;

      if Game.Favorite <> CheckBoxGameFavorite.IsChecked then
      begin
        CheckOrAddNode(Node, Cst_Favorite);
        Node.ChildNodes.Nodes[Cst_Favorite].Text := BoolStr(CheckBoxGameFavorite.IsChecked);
        Game.Favorite := CheckBoxGameFavorite.IsChecked;
      end;
    end;
  end;

  if ASavePic and Assigned(ListBoxMedia.Selected) and (not ListBoxMedia.Selected.ItemData.Bitmap.IsEmpty) then
  begin
    ListBoxMedia.Selected.ItemData.Bitmap.SaveToFile(TPath.Combine([FRootPath, FCurrentFolder, Cst_SystemImagesPath, FScrapedGame.RomNameWoExt + Cst_ImageSuffixPng]));
    var ImageLink := TPath.Combine(Cst_SystemImagesPath, FScrapedGame.RomNameWoExt + Cst_ImageSuffixPng);

    CheckOrAddNode(Node, Cst_ImageLink);
    Node.ChildNodes.Nodes[Cst_ImageLink].Text := ImageLink;
    Game.ImagePath := ImageLink;
  end;

  if ASaveVideo and (FVideoScrapeLink <> '') then
  begin
    var VideoPath := TPath.Combine([FRootPath, FCurrentFolder, Cst_SystemVideosPath, FScrapedGame.RomNameWoExt + Cst_VideoSuffixMp4]);
    SaveLinkToFile(FVideoScrapeLink, VideoPath);
    var VideoLink := TPath.Combine(Cst_SystemVideosPath, FScrapedGame.RomNameWoExt + Cst_VideoSuffixMp4);

    CheckOrAddNode(Node, Cst_VideoLink);
    Node.ChildNodes.Nodes[Cst_VideoLink].Text := VideoLink;
    Game.VideoPath := VideoLink;
  end;

  if NodeAdded then
  begin
    XMLDoc.XML.Text := Xml.Xmldoc.FormatXMLData(XMLDoc.XML.Text);
    XMLDoc.Active := True;
  end;
  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;

  if AScrape then
  begin
    TabControlEditor.ActiveTab := TabItemEditGame;
  end;

  if Assigned(ListBoxGames.Selected) then
  begin
    FillGameItem((ListBoxGames.Selected as TListBoxItemGame), (ListBoxGames.Selected as TListBoxItemGame).Game);
    LoadGame((ListBoxGames.Selected as TListBoxItemGame).Game);
  end;
end;

procedure TFormMain.SaveLinkToFile(ALink, APath: string);
begin
  var Stream := TBytesStream.Create;
  try
    try
      var Code := NetHTTPClientScrape.Get(ALink, Stream).StatusCode;
      if (Stream.Size = 0) or (Code <> 200) then
      begin
        WarnUser(Rst_StreamError);
        Exit;
      end;
      Stream.Position := 0;
    except
      on E: Exception do
      begin
        WarnUserWithSafeUrl(Rst_ServerError8, E.Message, ALink);
        Exit;
      end;
    end;

    Stream.SaveToFile(APath);
  finally
    Stream.Free;
  end;
end;

procedure TFormMain.MenuItemSetFavoriteClick(Sender: TObject);
begin
  SetFavoriteOrHidden(True, True);
end;

procedure TFormMain.MenuItemSetHiddenClick(Sender: TObject);
begin
  SetFavoriteOrHidden(False, True);
end;

procedure TFormMain.MenuItemSetNoFavoriteClick(Sender: TObject);
begin
  SetFavoriteOrHidden(True, False);
end;

procedure TFormMain.MenuItemSetNoHiddenClick(Sender: TObject);
begin
  SetFavoriteOrHidden(False, False);
end;

procedure TFormMain.SetAutoHash(const Value: Boolean);
begin
  CheckBoxSetAutohash.IsChecked := Value;
  CheckBoxSetAutohash.Text := if CheckBoxSetAutohash.IsChecked then Translate('On')else Translate('Off');
end;

procedure TFormMain.SetDelWoPrompt(const Value: Boolean);
begin
  CheckBoxSetDelPrompts.IsChecked := Value;
end;

procedure TFormMain.SetFavoriteOrHidden(AFavorite, AValue: Boolean);

  function NodeExists(ANode: IXMLNode; const ANodeName: string): Boolean;
  begin
    Result := Assigned(ANode.ChildNodes.FindNode(ANodeName));
  end;

begin
  var NodeAdded := False;
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);

  for var i := 0 to Pred(ListBoxGames.Items.Count) do
  begin
    if ListBoxGames.ListItems[i].IsSelected then
    begin
      var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
      var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

      repeat
        if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
          Break;
        Node := Node.NextSibling;
      until not Assigned(Node);

      if AFavorite then
      begin
        if not NodeExists(Node, Cst_Favorite) then
        begin
          Node.AddChild(Cst_Favorite);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Favorite].Text := BoolStr(AValue);
        Game.Favorite := AValue;
      end
      else
      begin
        if not NodeExists(Node, Cst_Hidden) then
        begin
          Node.AddChild(Cst_Hidden);
          NodeAdded := True;
        end;
        Node.ChildNodes.Nodes[Cst_Hidden].Text := BoolStr(AValue);
        Game.Hidden := AValue;
      end;
    end;
  end;

  if NodeAdded then
  begin
    XMLDoc.XML.Text := Xml.Xmldoc.FormatXMLData(XMLDoc.XML.Text);
    XMLDoc.Active := True;
  end;
  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;

  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.SetGenesisLogo(const Value: Boolean);
begin
  CheckBoxSetGenesisLogo.BeginUpdate;
  try
    CheckBoxSetGenesisLogo.IsChecked := Value;
    CheckBoxSetGenesisLogo.Text := if CheckBoxSetGenesisLogo.IsChecked then Translate('On')else Translate('Off');
  finally
    CheckBoxSetGenesisLogo.EndUpdate;
  end;
end;

procedure TFormMain.SetGodMode(const Value: Boolean);
begin
  CheckBoxSetGodMode.IsChecked := Value;
  MenuItemGameDelete.Visible := Value;
  ButtonGameDelete.Visible := Value;
  CheckBoxSetGodMode.Text := if CheckBoxSetGodMode.IsChecked then Translate('On')else Translate('Off');
end;

procedure TFormMain.SetOpenLastFolder(const Value: Boolean);
begin
  CheckBoxSetOpenLastFolder.IsChecked := Value;
end;

procedure TFormMain.SetPiPrompts(const Value: Boolean);
begin
  CheckBoxSetPiPrompts.IsChecked := Value;
end;

procedure TFormMain.SetRecalLogin(const Value: string);
begin
  EditSetRecalboxLogin.Text := Value;
end;

procedure TFormMain.SetRecalPwd(const Value: string);
begin
  EditSetRecalboxPwd.Text := Value;
end;

procedure TFormMain.SetRetroLogin(const Value: string);
begin
  EditSetRetropieLogin.Text := Value;
end;

procedure TFormMain.SetRetroPwd(const Value: string);
begin
  EditSetRetropiePwd.Text := Value;
end;

procedure TFormMain.SetShowTips(const Value: Boolean);
begin
  CheckBoxSetShowTips.IsChecked := Value;
  CheckBoxSetShowTips.Text := if CheckBoxSetShowTips.IsChecked then Translate('On')else Translate('Off');
end;

procedure TFormMain.SetSSLogin(const Value: string);
begin
  EditSetScreenLogin.Text := Value;
end;

procedure TFormMain.SetSSPwd(const Value: string);
begin
  EditSetScreenPwd.Text := Value;
end;

procedure TFormMain.ButtonDeleteClick(Sender: TObject);
begin
  if not (GodMode or DelWoPrompt or (MyMessageDlg(Rst_Info, Rst_DeleteWarning, [Rst_Yes, Rst_No]) = 0)) then
    Exit;

  var LastIndex := ListBoxGames.ItemIndex;

  ListBoxGames.BeginUpdate;
  try
    if SelCount(ListBoxGames) > 1 then
    begin
      // Step 1: Capture list of games to delete
      var GamesToDelete := TList<TGame>.Create;
      try
        for var i := Pred(ListBoxGames.Items.Count) downto 0 do
        begin
          if ListBoxGames.ListItems[i].IsSelected then
            GamesToDelete.Add((ListBoxGames.ListItems[i] as TListBoxItemGame).Game);
        end;

        // Step 2: Loop over the list of games to delete and delete them
        for var Game in GamesToDelete do
          DeleteGame(Game, False);
      finally
        GamesToDelete.Free;
      end;
    end
    else if Assigned(ListBoxGames.Selected) then
    begin
      DeleteGame((ListBoxGames.Selected as TListBoxItemGame).Game);
    end;
  finally
    ListBoxGames.EndUpdate;
  end;

  if ListBoxGames.Count > 0 then
  begin
    if LastIndex < ListBoxGames.Count then
      ListBoxGames.ListItems[LastIndex].IsSelected := True
    else
      ListBoxGames.ListItems[ListBoxGames.Count - 1].IsSelected := True;
  end;

  ListBoxGames.SetFocus;
end;

procedure TFormMain.MenuItemDeleteOrphansClick(Sender: TObject);
begin
  var List: TObjectList<TGame>;
  FSystemList.TryGetValue(GetCurrentFolderName, List);
  for var i := Pred(List.Count) downto 0 do
    if List.Items[i].IsOrphan then
      DeleteGame(List.Items[i]);
end;

procedure TFormMain.DeleteGame(AGame: TGame; ReloadGameList: Boolean = True);
begin
  var List: TObjectList<TGame>;
  var GameListPath := GetCurrentGameListPath;
  FSystemList.TryGetValue(GetCurrentFolderName, List);

  XMLDoc.LoadFromFile(GameListPath);

  var ImageReused := False;
  var VideoReused := False;
  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
  while Assigned(Node) do
  begin
    if not (Node.ChildNodes.Nodes[Cst_Path].Text = AGame.RomPath) then
    begin
      if (Assigned(Node.ChildNodes.FindNode(Cst_ImageLink)) and
        (Node.ChildNodes.Nodes[Cst_ImageLink].Text = AGame.ImagePath)) then
        ImageReused := True;
      if (Assigned(Node.ChildNodes.FindNode(Cst_VideoLink)) and
        (Node.ChildNodes.Nodes[Cst_VideoLink].Text = AGame.VideoPath)) then
        VideoReused := True;
    end;
    Node := Node.NextSibling;
  end;

  Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

  while Assigned(Node) do
  begin
    if Assigned(Node.ChildNodes.FindNode(Cst_Path)) then
      if (Node.ChildNodes.Nodes[Cst_Path].Text = AGame.RomPath) then
        Break;
    Node := Node.NextSibling;
  end;

  if not Assigned(Node) then
    Exit;

  XMLDoc.DocumentElement.ChildNodes.Remove(Node);
  XMLDoc.Active := True;
  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;

  if not ImageReused then
  try
    TFile.Delete(AGame.PhysicalImagePath);
  except
    //
  end;

  if not VideoReused then
  try
    TFile.Delete(AGame.PhysicalVideoPath);
  except
    //
  end;

  try
    if (GetSystemKind = TSystemKind.PS) then
    begin
      TFile.Delete(StringReplace(AGame.PhysicalRomPath, '.cue', '.bin', [rfReplaceAll]));
      TFile.Delete(StringReplace(AGame.PhysicalRomPath, '.bin', '.cue', [rfReplaceAll]));
    end
    else
      TFile.Delete(AGame.PhysicalRomPath);
  except
    //
  end;

  for var i := ListBoxGames.Count - 1 downto 0 do
    if (ListBoxGames.ListItems[i] as TListBoxItemGame).Game = AGame then
      ListBoxGames.ListItems[i].Free;

  List.Remove(AGame);
end;

procedure TFormMain.MenuItemDeleteDuplicatesClick(Sender: TObject);
begin
  DeleteDuplicates(GetCurrentFolderName);
end;

procedure TFormMain.DeleteDuplicates(const ASystem: string);
begin
  ListBoxGames.Clear;
  ClearAllFields;

  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);
  XMLDoc.Active := True;

  var NodeList := XMLDoc.DocumentElement.ChildNodes;
  var Count := NodeList.Count;

  for var i := Pred(Count) downto 0 do
  begin
    var Node1 := NodeList.Nodes[i];
    var Node1Path := Node1.ChildNodes.FindNode(Cst_Path);
    if Node1Path <> nil then
    begin
      for var j := 0 to Pred(i) do
      begin
        var Node2 := NodeList.Nodes[j];
        var Node2Path := Node2.ChildNodes.FindNode(Cst_Path);
        if (Node2Path <> nil) and (Node1Path.Text = Node2Path.Text) then
        begin
          NodeList.Remove(Node1);
          Break;
        end;
      end;
    end;
  end;

  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;

  FSystemList.Remove(ASystem);
  FSystemList.Add(ASystem, BuildGamesList(GameListPath));

  LoadGamesList(ASystem);
end;

procedure TFormMain.ClearAllFields;
begin
  FIsLoading := True;

  EditGameName.Text := '';
  EditGameRating.Text := '';
  EditGameReleaseDate.Text := '';
  EditGamePublisher.Text := '';
  EditGameDeveloper.Text := '';
  EditGamePlayers.Text := '';
  EditGameGenre.Text := '';
  EditGameRegion.Text := '';
  EditGameRomPath.Text := '';
  MemoGameDescription.Text := '';
  ImageGame.Bitmap := nil;
  ImageGameBackground.Visible := True;
  CheckBoxGameKids.IsChecked := False;
  CheckBoxGameHidden.IsChecked := False;
  CheckBoxGameFavorite.IsChecked := False;
  ButtonSaveChanges.Enabled := False;

  FIsLoading := False;
end;

procedure TFormMain.CheckBoxCustomAccentChange(Sender: TObject);
begin
  if FUpdating > 0 then
    Exit;
  DoOnSettingChange;
end;

procedure TFormMain.CheckBoxCustomTitleChange(Sender: TObject);
begin
  if FUpdating > 0 then
    Exit;
  HideTitleBar := CheckBoxCustomTitle.IsChecked;
end;

procedure TFormMain.CheckBoxGamesFullRomNameChange(Sender: TObject);
begin
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.CheckBoxGamesListByRomChange(Sender: TObject);
begin
  CheckBoxGamesFullRomName.Enabled := CheckBoxGamesListByRom.IsChecked;
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.MenuItemExportTxtClick(Sender: TObject);
begin
  ExportToTxt;
end;

procedure TFormMain.ExportToTxt;
begin
  var SystemList: TObjectList<TGame>;
  FSystemList.TryGetValue(GetCurrentFolderName, SystemList);

  var SortedList := TStringList.Create;
  var FormatedList := TStringList.Create;
  try
    SortedList.Sorted := True;
    SortedList.Duplicates := dupAccept;
    for var Game in SystemList do
    begin
      if CheckBoxGamesListByRom.IsChecked then
        SortedList.Add(Game.RomName)
      else
        SortedList.Add(Game.Name);
    end;

    var FirstCharRef := SortedList[0][1];
    FormatedList.Add('---------- ' + AnsiUpperCase(FirstCharRef) + ' ----------');
    FormatedList.Add(sLineBreak);

    for var i := 0 to Pred(SortedList.Count) do
    begin
      var FirstCharCurrent := SortedList[i][1];
      if (FirstCharCurrent = FirstCharRef) then
        FormatedList.Add(SortedList[i])
      else
      begin
        FirstCharRef := FirstCharCurrent;
        FormatedList.Add(sLineBreak);
        FormatedList.Add('---------- ' + AnsiUpperCase(FirstCharRef) + ' ----------');
        FormatedList.Add(sLineBreak);
        FormatedList.Add(SortedList[i]);
      end;
    end;

    if SaveDialog.Execute then
      FormatedList.SaveToFile(SaveDialog.FileName + Cst_TxtExtension);
  finally
    SortedList.Free;
    FormatedList.Free;
  end;
end;

procedure TFormMain.GameListViewChange(Sender: TObject);
begin
  if RadioButtonGameListViewFull.IsChecked then
  begin
    ListBoxGames.DefaultItemStyles.ItemStyle := 'listboxitemstyle_game';
    ListBoxGames.ItemHeight := 70;
  end
  else if RadioButtonGameListViewMini.IsChecked then
  begin
    ListBoxGames.DefaultItemStyles.ItemStyle := '';
    ListBoxGames.ItemHeight := 32;
  end;
end;

procedure TFormMain.GameMediaChange(Sender: TObject);
begin
  if RadioButtonPreviewPicture.IsChecked then
    TabControlMedia.ActiveTab := TabItemMediaPicture
  else if RadioButtonPreviewVideo.IsChecked then
    TabControlMedia.ActiveTab := TabItemMediaVideo
  else if RadioButtonPreviewManual.IsChecked then
    TabControlEditor.ActiveTab := TabItemEditManual
  else if RadioButtonPreviewHash.IsChecked then
    TabControlMedia.ActiveTab := TabItemMediaHash;
end;

procedure TFormMain.ChangeCaseClick(Sender: TObject);
begin
  var List: TObjectList<TGame>;
  FSystemList.TryGetValue(GetCurrentFolderName, List);

  for var i := 0 to Pred(List.Count) do
  begin
    var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
    if ((Sender as TMenuItem).Tag = 10) then
      ConvertFieldsCase(Game)
    else if ((Sender as TMenuItem).Tag = 11) then
      ConvertFieldsCase(Game, False, True);
  end;
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.ChangeCaseGameClick(Sender: TObject);
begin
  if not Assigned(ListBoxGames.Selected) then
    Exit;
  var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;
  if ((Sender as TMenuItem).Tag = 12) then
    ConvertFieldsCase(Game, True)
  else if ((Sender as TMenuItem).Tag = 13) then
    ConvertFieldsCase(Game, True, True);
end;

procedure TFormMain.ConvertFieldsCase(AGame: TGame; AUnique: Boolean = False; AUp: Boolean = False);

  procedure RefreshDisplay(AGame: TGame);
  begin
    EditGameName.Text := AGame.Name;
    EditGameGenre.Text := AGame.Genre;
    EditGameRegion.Text := AGame.Region;
    EditGamePublisher.Text := AGame.Publisher;
    EditGameDeveloper.Text := AGame.Developer;
    MemoGameDescription.Text := AGame.Description;
    if Assigned(ListBoxGames.Selected) then
      ListBoxGames.Selected.Text := EditGameName.Text;
  end;

  function ConvertUpOrLow(ANode: IXMLNode; const ANodeName: string; AUp: Boolean; const AField: string): string;
  begin
    if AUp then
      Result := AField.ToUpper
    else
      Result := AField.ToLower;
    if Assigned(ANode.ChildNodes.FindNode(ANodeName)) then
      ANode.ChildNodes.Nodes[ANodeName].Text := Result;
  end;

begin
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);
  XMLDoc.Active := True;

  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
  while Assigned(Node) do
  begin
    if (Node.ChildNodes.Nodes[Cst_Path].Text = AGame.RomPath) then
      Break;
    Node := Node.NextSibling;
  end;

  AGame.Name := ConvertUpOrLow(Node, Cst_Name, AUp, AGame.Name);
  AGame.Region := ConvertUpOrLow(Node, Cst_Region, AUp, AGame.Region);
  AGame.Developer := ConvertUpOrLow(Node, Cst_Developer, AUp, AGame.Developer);
  AGame.Publisher := ConvertUpOrLow(Node, Cst_Publisher, AUp, AGame.Publisher);
  AGame.Genre := ConvertUpOrLow(Node, Cst_Genre, AUp, AGame.Genre);
  AGame.Description := ConvertUpOrLow(Node, Cst_Description, AUp, AGame.Description);

  if AUnique then
    RefreshDisplay(AGame);

  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;
end;

procedure TFormMain.MenuItemDeleteROMNotInListClick(Sender: TObject);
begin
  var Games: TObjectList<TGame>;
  FSystemList.TryGetValue(GetCurrentFolderName, Games);
  var ListToDelete := TStringList.Create;
  try
    var Files := TDirectory.GetFiles(TPath.Combine(FRootPath, GetCurrentFolderName));
    for var ROM in Files do
    begin
      if ROM.ToLower.EndsWith('.xml') then
        Continue;
      var IsFound := False;
      for var Game in Games do
      begin
        if Game.PhysicalRomPath.ToLower = ROM.ToLower then
        begin
          IsFound := True;
          Break;
        end;
      end;
      if IsFound then
        Continue;
      ListToDelete.Add(ROM);
    end;

    ShowUIMessage(Self, ListToDelete.Text);

    for var ROM in ListToDelete do
      TFile.Delete(ROM);
  finally
    ListToDelete.Free;
  end;
end;

procedure TFormMain.MenuItemRemoveRegionClick(Sender: TObject);
var
  List: TObjectList<TGame>;
begin
  FSystemList.TryGetValue(GetCurrentFolderName, List);

  for var i := 0 to Pred(List.Count) do
  begin
    var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
    var CPos := Pos('[', Game.Name);

    if not (CPos = 0) then
      RemoveRegionFromGameName(Game, Pred(CPos));
  end;
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.RemoveRegionFromGameName(AGame: TGame; AStartPos: Integer);
begin
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);
  XMLDoc.Active := True;

  var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
  while Assigned(Node) do
  begin
    if (Node.ChildNodes.Nodes[Cst_Path].Text = AGame.RomPath) then
      Break;
    Node := Node.NextSibling;
  end;

  var GameName := AGame.Name;
  var EndPos := Pos(']', GameName);
  Delete(GameName, AStartPos, Succ(EndPos - AStartPos));
  AGame.Name := GameName;

  Node.ChildNodes.FindNode(Cst_Name).Text := AGame.Name;

  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;
end;

procedure TFormMain.MenuItemNameEditorClick(Sender: TObject);
begin
  var Preview: string := '';
  for var i := 0 to Pred(ListBoxGames.Items.Count) do
    if ListBoxGames.ListItems[i].IsSelected then
    begin
      Preview := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game.Name;
      Break;
    end;

  var FormNameEditor := TFormNameEditor.Create(Self);
  try
    var Func: TFunc<string, string>;
    if FormNameEditor.Execute(Func, Preview) then
    begin
      TransformGamesNames(Func);
      LoadGamesList(GetCurrentFolderName);
    end;
  finally
    FormNameEditor.Free;
  end;
end;

procedure TFormMain.TransformGamesNames(Func: TFunc<string, string>);
begin
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);

  for var i := 0 to Pred(ListBoxGames.Items.Count) do
  begin
    if not ListBoxGames.ListItems[i].IsSelected then
      Continue;

    var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
    Game.Name := Func(Game.Name);

    var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);
    while Assigned(Node) do
    begin
      if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
        Break;
      Node := Node.NextSibling;
    end;

    Node.ChildNodes.Nodes[Cst_Name].Text := Game.Name;
  end;

  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;
end;

procedure TFormMain.ClearScrapeMedia;
begin
  FVideoScrapeLink := '';
  CheckBoxScrapePicture.IsChecked := False;
  CheckBoxScrapePicture.Enabled := False;
  CheckBoxScrapeVideo.IsChecked := False;
  CheckBoxScrapeVideo.Enabled := False;
end;

function TFormMain.GetGameXml(const ASysId: string; AGame: TGame): Boolean;
begin
  Result := False;

  var Crc32: string;
  if CheckBoxManualCRC.IsChecked then
  begin
    if EditScrapeCRC.Text.IsEmpty then
      raise Exception.Create('CRC field is not filled');
    Crc32 := EditScrapeCRC.Text
  end
  else if AGame.Crc32.IsEmpty then
    Crc32 := AGame.CalculateCrc32(AGame.PhysicalRomPath)
  else
    Crc32 := AGame.Crc32;

  var Size := TFile.GetSize(AGame.PhysicalRomPath);

  var Query := Cst_ScraperAddress + Cst_Category + Cst_ScrapeLogin + Cst_ScrapePwd + Cst_DevSoftName + Cst_Output;

  if (not SSLogin.IsEmpty) and (not SSPwd.IsEmpty) then
    Query := Query + Cst_SSId + SSLogin + Cst_SSPwd + SSPwd;

  Query := Query + Cst_Crc + Crc32 + Cst_SystemId + ASysId;

  if not CheckBoxManualCRC.IsChecked then
    Query := Query + Cst_RomName + TNetEncoding.URL.Encode(AGame.RomName) + Cst_RomSize + Size.ToString;

  var Stream := TStringStream.Create;
  try
    try
      var Code := NetHTTPClientScrape.Get(Query, Stream).StatusCode;
      if Code = 404 then
      begin
        WarnUser(Rst_ServerError4);
        Exit;
      end;
      if Code <> 200 then
      begin
        WarnUser(Rst_ServerError9);
        Exit;
      end;
      if (Stream.Size = 0) then
      begin
        WarnUser(Rst_StreamError);
        Exit;
      end;
      Stream.Position := 0;
      var SList := TStringList.Create;
      try
        SList.Text := Stream.DataString;

        // fix xml
        while (SList.Count > 0) and (not SList[SList.Count - 1].ToLower.Contains('</')) do
          SList.Delete(SList.Count - 1);

        XMLDoc.LoadFromXML(SList.Text);
      finally
        SList.Free;
      end;
      XMLDoc.SaveToFile(FTempXmlPath);
    except
      on E: Exception do
      begin
        WarnUserWithSafeUrl(Rst_ServerError8, E.Message, Query);
        Exit;
      end;
    end;
  finally
    Stream.Free;
  end;
  Result := True;
end;

function TFormMain.GetGenesisLogo: Boolean;
begin
  Result := CheckBoxSetGenesisLogo.IsChecked;
end;

function TFormMain.GetGodMode: Boolean;
begin
  Result := CheckBoxSetGodMode.IsChecked;
end;

procedure TFormMain.ParseXml;

  function CreateDict(ANodeList: IXMLNodeList; const AAttName: string): TDictionary<string, string>;
  begin
    Result := TDictionary<string, string>.Create;
    for var i := 0 to Pred(ANodeList.Count) do
    begin
      Result.AddOrSetValue(ANodeList[i].Attributes[AAttName], ANodeList[i].Text);
    end;
  end;

  function CreateGenreDict(ANodeList: IXMLNodeList; const AAttId, AAttLang: string): TObjectDictionary<string, TDictionary<string, string>>;
  begin
    Result := TObjectDictionary<string, TDictionary<string, string>>.Create([doOwnsValues]);
    var List := TDictionary<string, string>.Create;
    var Id := ANodeList[0].Attributes[AAttId];
    for var i := 0 to Pred(ANodeList.Count) do
    begin
      if (ANodeList[i].Attributes[AAttId] = Id) then
        List.AddOrSetValue(ANodeList[i].Attributes[AAttLang], ANodeList[i].Text)
      else
      begin
        Result.Add(Id, List);
        Id := ANodeList[i].Attributes[AAttId];
        List := TDictionary<string, string>.Create;
        List.AddOrSetValue(ANodeList[i].Attributes[AAttLang], ANodeList[i].Text);
      end;
    end;
    Result.Add(Id, List);
  end;

begin
  XMLDoc.LoadFromFile(FTempXmlPath);
  var RootNode := XMLDoc.ChildNodes[Cst_DataNode].ChildNodes[Cst_GameNode];
  var Node := RootNode.ChildNodes.FindNode(Cst_NamesNode);
  if Assigned(Node) then
  begin
    var Nodes := Node.ChildNodes;
    if Assigned(Nodes) then
      FInfosList.AddObject(Cst_NamesNode, CreateDict(Nodes, Cst_AttRegion));
  end
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_RegionsNode);
  if Assigned(Node) then
  begin
    var Nodes := Node.ChildNodes;
    if Assigned(Nodes) then
    begin
      var List := TStringList.Create;
      for var i := 0 to Pred(Nodes.Count) do
      begin
        List.Add(Nodes[i].Text);
      end;
      FInfosList.AddObject(Cst_RegionsNode, List);
    end;
  end
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_SynopNode);
  if Assigned(Node) then
  begin
    var Nodes := Node.ChildNodes;
    if Assigned(Nodes) then
      FInfosList.AddObject(Cst_SynopNode, CreateDict(Nodes, Cst_AttLang));
  end
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_DateNode);
  if Assigned(Node) then
  begin
    var Nodes := Node.ChildNodes;
    if Assigned(Nodes) then
      FInfosList.AddObject(Cst_DateNode, CreateDict(Nodes, Cst_AttRegion));
  end
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_GenreNode);
  if Assigned(Node) then
  begin
    var Nodes := Node.ChildNodes;
    if Assigned(Nodes) then
      FInfosList.AddObject(Cst_GenreNode, CreateGenreDict(Nodes, Cst_AttId, Cst_AttLang));
  end
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_EditNode);
  if Assigned(Node) then
    FInfosList.Add(Node.Text)
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_DevNode);
  if Assigned(Node) then
    FInfosList.Add(Node.Text)
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_PlayersNode);
  if Assigned(Node) then
    FInfosList.Add(Node.Text)
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_NoteNode);
  if Assigned(Node) then
    FInfosList.Add(Node.Text)
  else
    FInfosList.Add('');

  Node := RootNode.ChildNodes.FindNode(Cst_MediaNode);
  if Assigned(Node) then
  begin
    var Nodes := Node.ChildNodes;
    if Assigned(Nodes) and (Nodes.Count > 0) then
    begin
      for var i := 0 to Pred(Nodes.Count) do
      begin
        if (Nodes[i].Attributes[Cst_AttType] = Cst_MediaVideo) and (CheckBoxScrapePicVideo.IsChecked) then
        begin
          FVideoScrapeLink := Nodes[i].Text;
          CheckBoxScrapeVideo.IsChecked := True;
          CheckBoxScrapeVideo.Enabled := True;
        end;
        if ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaBox2d) and (CheckBoxScrapePicBox2D.IsChecked)) or
          ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaScreenShot) and (CheckBoxScrapePicScreenshot.IsChecked)) or
          ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaSsTitle) and (CheckBoxScrapePicTitle.IsChecked)) or
          ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaBox3d) and (CheckBoxScrapePicBox3D.IsChecked)) or
          ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaMix1) and (CheckBoxScrapePicMix1.IsChecked)) or
          ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaMix2) and (CheckBoxScrapePicMix2.IsChecked)) or
          ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaArcadeBox1) and (CheckBoxScrapePicArcadeBox.IsChecked)) or
          ((Nodes[i].Attributes[Cst_AttType] = Cst_MediaWheel) and (CheckBoxScrapePicWheel.IsChecked))
          then
        begin
          var Media := TMediaInfo.Create;
          try
            Media.FileExt := Nodes[i].Attributes[Cst_AttFormat];
            Media.FileLink := Nodes[i].Text;
          except
            Media.Free;
            raise;
          end;
          FPictureLinks.Add(Media);
        end;
      end;
    end;
  end;

  try
    RootNode := XMLDoc.ChildNodes[Cst_DataNode].ChildNodes[Cst_UserNode];
    Node := RootNode.ChildNodes.FindNode(Cst_ThreadNode);
    if Assigned(Node) then
    begin
      if not TryStrToInt(Node.Text, FMaxThreads) then
        FMaxThreads := 1;
    end;
  except
    FMaxThreads := 1;
  end;

  TFile.Delete(FTempXmlPath);
end;

procedure TFormMain.PopupBoxStyleChange(Sender: TObject);
begin
  if FUpdating > 0 then
    Exit;
  DoOnSettingChange;
end;

procedure TFormMain.GetPictures;
begin
  if FPictureLinks.Count = 0 then
  begin
    ImageScrapeLoading.Visible := False;
    FillFields;
    EnableScrapeComponents(True);
    Exit;
  end;

  ProgressBarScrapeMedia.Visible := True;
  ProgressBarScrapeMedia.Value := 0;
  ProgressBarScrapeMedia.Max := FPictureLinks.Count;

  FThreadCount := 0;
  FStartCount := FPictureLinks.Count;
  for var i := 0 to Pred(FMaxthreads) do
  begin
    if FPictureLinks.Count > 0 then
      GetPicture(FPictureLinks.Extract(FPictureLinks[0]))
    else
      Break;
  end;
end;

function TFormMain.GetPiPrompts: Boolean;
begin
  Result := CheckBoxSetPiPrompts.IsChecked;
end;

function TFormMain.GetRecalLogin: string;
begin
  Result := EditSetRecalboxLogin.Text;
end;

function TFormMain.GetRecalPwd: string;
begin
  Result := EditSetRecalboxPwd.Text;
end;

function TFormMain.GetRetroLogin: string;
begin
  Result := EditSetRetropieLogin.Text;
end;

function TFormMain.GetRetroPwd: string;
begin
  Result := EditSetRetropiePwd.Text;
end;

procedure TFormMain.GetPicture(AMedia: TMediaInfo);
begin
  try
    var Thread := TDownloadThread.Create;
    Thread.Url := AMedia.FileLink;
    Thread.Ext := AMedia.FileExt;
    Thread.OnTerminate := ThreadTerminated;
    Thread.Start;
  finally
    AMedia.Free;
  end;
end;

procedure TFormMain.ThreadTerminated(Sender: TObject);
begin
  CounterGuard.Acquire;
  ProgressBarScrapeMedia.Value := ProgressBarScrapeMedia.Value + 1;
  Inc(FThreadCount);
  if (FPictureLinks.Count > 0) then
  begin
    GetPicture(FPictureLinks.Extract(FPictureLinks[0]));
  end
  else if (FThreadCount = FStartCount) then
  begin
    DisplayPictures;
    ImageScrapeLoading.Visible := False;
    ProgressBarScrapeMedia.Visible := False;
    FillFields;
    EnableScrapeComponents(True);
  end;

  CounterGuard.Release;
end;

procedure TFormMain.DisplayPictures;
begin
  ListBoxMedia.Clear;
  var Count := FImgList.Count;
  if (Count = 0) then
    Exit;
  for var Image in FImgList do
  begin
    var Item := TListBoxItem.Create(ListBoxMedia);
    Item.ItemData.Bitmap := Image.Bitmap;
    ListBoxMedia.AddObject(Item);
  end;
end;

procedure TFormMain.DoOnSettingChange;
begin
  //FF2C4361 - FF0B1E39
  if RadioButtonSetAccentAuto.IsChecked then
    OverAccentColor := SystemAccentColor
  else
    OverAccentColor := ComboColorBoxAccentColor.Color;

  // Override theme color
  case ComboBoxTheme.ItemIndex of
    0:
      ThemeKind := TSystemThemeKind.Unspecified;
    1:
      ThemeKind := TSystemThemeKind.Light;
    2:
      ThemeKind := TSystemThemeKind.Dark;
  end;

  // Set stylebook and color for theme
  if IsDark then
  begin
    // Set accent color for stylebook
    ChangeStyleBookColor(StyleBookWinUI3, OverAccentColor);
    StyleBook := StyleBookWinUI3;
    MarkdownViewerHelp.ThemePreset := TMarkdownThemePreset.Dark;
  end
  else
  begin
    // Set accent color for stylebook
    ChangeStyleBookColor(StyleBookWinUI3Light, OverAccentColor);
    StyleBook := StyleBookWinUI3Light;
    MarkdownViewerHelp.ThemePreset := TMarkdownThemePreset.Light;
  end;
  MarkdownViewerHelp.Theme.BackgroundColor := TAlphaColors.Null;

  inherited;

  // Set window type
  if RadioButtonSetBGSystem.IsChecked then
  begin
    case PopupBoxStyle.ItemIndex of
      0: // mica
        SystemBackdropType := TWindowBackdropType.Mica;
      1: // tabbed
        SystemBackdropType := TWindowBackdropType.Tabbed;
      2: // acrilyc
        SystemBackdropType := TWindowBackdropType.Acrylic;
      3: // none
        begin
          SystemBackdropType := TWindowBackdropType.Disable;
          Fill.Kind := TBrushKind.None;
        end;
    end;
  end;

  UpdateSystemBackdropType;

  if RadioButtonSetBGGradient.IsChecked then
  begin
    Fill.Kind := TBrushKind.Gradient;
    //Fill.Gradient.Color := $FF2C4361;
    //Fill.Gradient.Color1 := $FF0B1E39;
    Fill.Gradient.Color := ComboColorBoxSetBGColor1.Color;
    Fill.Gradient.Color1 := ComboColorBoxSetBGColor2.Color;
  end;

  TMessageManager.DefaultManager.SendMessage(Self, TStyleChangedMessage.Create(StyleBook, Self), True);
  TMessageManager.DefaultManager.SendMessage(Self, TInternalSettingChangedMessage.Create(StyleBook, Self), True);
end;

procedure TFormMain.FillFields;

  function GetFormatedDate(const AStr: string): string;
  begin
    if Length(AStr) = 4 then
      Result := AStr;

    if Length(AStr) = 7 then
    begin
      var Month := Copy(AStr, 6, 2);
      var Year := Copy(AStr, 1, 4);
      Result := Month + '/' + Year;
    end;

    if Length(AStr) = 10 then
    begin
      var Day := Copy(AStr, 9, 2);
      var Month := Copy(AStr, 6, 2);
      var Year := Copy(AStr, 1, 4);
      Result := Day + '/' + Month + '/' + Year;
    end;
  end;

var
  LangStr, TmpStr: string;
  ii, Count: Integer;
  Dict: TDictionary<string, string>;
  ObjectDict: TObjectDictionary<string, TDictionary<string, string>>;
  Item: TPair<string, TDictionary<string, string>>;
  List: TStringList;
begin
  LangStr := Copy(Cst_LangNameStr[GetLangEnum(FLanguage)], 1, 2);

  if (FInfosList.Count = 0) then
    Exit;

  if (not FInfosList[0].IsEmpty) then
  begin
    Dict := (FInfosList.Objects[0] as TDictionary<string, string>);
    if Dict.TryGetValue(LangStr, TmpStr) or
      Dict.TryGetValue(TCountryName.Eu.ShortName, TmpStr) or
      Dict.TryGetValue(TCountryName.Wor.ShortName, TmpStr) or
      Dict.TryGetValue('ss', TmpStr) then
      EditScrapeName.Text := TmpStr
    else
      EditScrapeName.Text := '';
  end
  else
    EditScrapeName.Text := '';

  if not FInfosList[1].IsEmpty then
  begin
    List := (FInfosList.Objects[1] as TStringList);
    EditScrapeRegion.Text := '';
    for ii := 0 to Pred(List.Count) do
    begin
      EditScrapeRegion.Text := EditScrapeRegion.Text + Translate(GetCountryEnum(List[ii]).FullName);
      if ii < Pred(List.Count) then
        EditScrapeRegion.Text := EditScrapeRegion.Text + ' - ';
    end;
  end
  else
    EditScrapeRegion.Text := '';

  if not FInfosList[2].IsEmpty then
  begin
    Dict := (FInfosList.Objects[2] as TDictionary<string, string>);
    if Dict.TryGetValue(LangStr, TmpStr) or
      Dict.TryGetValue(Cst_LangNameStr[TLangName.English], TmpStr) or
      Dict.TryGetValue(Cst_LangNameStr[TLangName.German], TmpStr) or
      Dict.TryGetValue(Cst_LangNameStr[TLangName.Spanish], TmpStr) or
      Dict.TryGetValue(Copy(Cst_LangNameStr[TLangName.Portuguese_BR], 1, 2), TmpStr) then
      MemoScrapeDescription.Text := TmpStr
    else
      MemoScrapeDescription.Text := '';
  end
  else
    MemoScrapeDescription.Text := '';

  if not FInfosList[3].IsEmpty then
  begin
    Dict := (FInfosList.Objects[3] as TDictionary<string, string>);
    if Dict.TryGetValue(LangStr, TmpStr) or
      Dict.TryGetValue(TCountryName.Eu.ShortName, TmpStr) or
      Dict.TryGetValue(TCountryName.Wor.ShortName, TmpStr) or
      Dict.TryGetValue(TCountryName.Us.ShortName, TmpStr) or
      Dict.TryGetValue(TCountryName.Jp.ShortName, TmpStr) then
      EditScrapeDate.Text := GetFormatedDate(TmpStr)
    else
      EditScrapeDate.Text := '';
  end
  else
    EditScrapeDate.Text := '';

  if not FInfosList[4].IsEmpty then
  begin
    ObjectDict := (FInfosList.Objects[4] as TObjectDictionary<string, TDictionary<string, string>>);
    EditScrapeGenre.Text := '';
    Count := 0;
    for Item in ObjectDict do
    begin
      Inc(Count);
      if (Item.Value.TryGetValue(LangStr, TmpStr)) or
        (Item.Value.TryGetValue(Cst_LangNameStr[TLangName.English], TmpStr)) or
        (Item.Value.TryGetValue(Cst_LangNameStr[TLangName.German], TmpStr)) or
        (Item.Value.TryGetValue(Cst_LangNameStr[TLangName.Spanish], TmpStr)) or
        (Item.Value.TryGetValue(Copy(Cst_LangNameStr[TLangName.Portuguese_BR], 1, 2), TmpStr)) then
        EditScrapeGenre.Text := EditScrapeGenre.Text + TmpStr
      else
        EditScrapeGenre.Text := EditScrapeGenre.Text + '';
      if (Count < ObjectDict.Count) then
        EditScrapeGenre.Text := EditScrapeGenre.Text + ' - ';
    end;
  end
  else
    EditScrapeGenre.Text := '';

  EditScrapePublisher.Text := FInfosList[5];
  EditScrapeDeveloper.Text := FInfosList[6];
  EditScrapePlayers.Text := FInfosList[7];
  EditScrapeRating.Text := FInfosList[8];
end;

procedure TFormMain.ConvertScrapeToUpOrLow(AUp: Boolean = False);
begin
  EditScrapeGenre.Text := IfThen(AUp, AnsiUpperCase(EditScrapeGenre.Text), AnsiLowerCase(EditScrapeGenre.Text));
  EditScrapeName.Text := IfThen(AUp, AnsiUpperCase(EditScrapeName.Text), AnsiLowerCase(EditScrapeName.Text));
  EditScrapeRegion.Text := IfThen(AUp, AnsiUpperCase(EditScrapeRegion.Text), AnsiLowerCase(EditScrapeRegion.Text));
  EditScrapeDeveloper.Text := IfThen(AUp, AnsiUpperCase(EditScrapeDeveloper.Text), AnsiLowerCase(EditScrapeDeveloper.Text));
  EditScrapeRating.Text := IfThen(AUp, AnsiUpperCase(EditScrapeRating.Text), AnsiLowerCase(EditScrapeRating.Text));
  EditScrapePlayers.Text := IfThen(AUp, AnsiUpperCase(EditScrapePlayers.Text), AnsiLowerCase(EditScrapePlayers.Text));
  EditScrapePublisher.Text := IfThen(AUp, AnsiUpperCase(EditScrapePublisher.Text), AnsiLowerCase(EditScrapePublisher.Text));
  MemoScrapeDescription.Text := IfThen(AUp, AnsiUpperCase(MemoScrapeDescription.Text), AnsiLowerCase(MemoScrapeDescription.Text));
end;

procedure TFormMain.EnableScrapeComponents(AValue: Boolean);
begin
  EditScrapeGenre.Enabled := AValue;
  EditScrapeDate.Enabled := AValue;
  EditScrapeName.Enabled := AValue;
  EditScrapeRegion.Enabled := AValue;
  EditScrapeDeveloper.Enabled := AValue;
  EditScrapeRating.Enabled := AValue;
  EditScrapePlayers.Enabled := AValue;
  EditScrapePublisher.Enabled := AValue;
  MemoScrapeDescription.Enabled := AValue;

  Lbl_ScrapeDate.Enabled := AValue;
  Lbl_ScrapeGenre.Enabled := AValue;
  Lbl_ScrapeName.Enabled := AValue;
  Lbl_ScrapeRegion.Enabled := AValue;
  Lbl_ScrapeDeveloper.Enabled := AValue;
  Lbl_ScrapeRating.Enabled := AValue;
  Lbl_ScrapePlayers.Enabled := AValue;
  Lbl_ScrapePublisher.Enabled := AValue;
  Lbl_ScrapeDescription.Enabled := AValue;

  ButtonScrapeSave.Enabled := AValue;
  ButtonScrapeLowerText.Enabled := AValue;
  ButtonScrapeUpperText.Enabled := AValue;

  CheckBoxScrapeInfos.Enabled := AValue;
end;

procedure TFormMain.WarnUser(const AMessage: string);
begin
  ShowUIMessage(Self, AMessage);
end;

procedure TFormMain.WarnUserWithSafeUrl(const AMessage, AMessage2, AUrl: string);
begin
  var ASafeUrl := AUrl.Replace('&', '&&').Replace(Cst_ScrapePwd, Cst_ScrapePwdSafe);

  if ASafeUrl.Length > 160 then
    ASafeUrl.Insert(120, sLineBreak);

  WarnUser(AMessage + sLineBreak + AMessage2 + sLineBreak + sLineBreak + ASafeUrl);
end;

procedure TFormMain.ButtonStartScrapeClick(Sender: TObject);
begin
  EmptyScrapeFields;
  ClearScrapeMedia;
  StopGameVideo;

  NetHTTPClientScrape.ProxySettings := CreateProxySettings;

  ImageScrapeLoading.Visible := True;
  Application.ProcessMessages;
  if Assigned(ListBoxGames.Selected) then
  begin
    FScrapedGame := (ListBoxGames.Selected as TListBoxItemGame).Game;
    if GetGameXml(GetCurrentSystemId, FScrapedGame) then
    begin
      ParseXml;
      GetPictures;
    end
    else
      ImageScrapeLoading.Visible := False;
  end;
end;

procedure TFormMain.ButtonSystemsOptionsClick(Sender: TObject);
begin
  PopupMenuSystemsOptions.PopupComponent := ButtonSystemsOptions;
  var Pos := ButtonSystemsOptions.LocalToScreen(PointF(0, 0));
  PopupMenuSystemsOptions.Popup(Pos.X, Pos.Y + ButtonSystemsOptions.Height);
end;

procedure TFormMain.ButtonScrapeSaveClick(Sender: TObject);
begin
  SaveChangesToGamelist(True, CheckBoxScrapeVideo.IsChecked, CheckBoxScrapePicture.IsChecked, CheckBoxScrapeInfos.IsChecked);
end;

procedure TFormMain.Chk_ScrapeClick(Sender: TObject);
begin
  ButtonScrapeSave.Enabled := (CheckBoxScrapeInfos.IsChecked) or (CheckBoxScrapePicture.IsChecked) or (CheckBoxScrapeVideo.IsChecked);
end;

procedure TFormMain.ButtonScrapeUpperTextClick(Sender: TObject);
begin
  ConvertScrapeToUpOrLow(True);
end;

procedure TFormMain.ButtonScrapeLowerTextClick(Sender: TObject);
begin
  ConvertScrapeToUpOrLow;
end;

procedure TFormMain.CheckBoxManualCRCChange(Sender: TObject);
begin
  EditScrapeCRC.Enabled := CheckBoxManualCRC.IsChecked;
end;

procedure TFormMain.CheckBoxSetAutohashChange(Sender: TObject);
begin
  AutoHash := CheckBoxSetAutohash.IsChecked;
end;

procedure TFormMain.CheckBoxSetGenesisLogoChange(Sender: TObject);
begin
  GenesisLogo := CheckBoxSetGenesisLogo.IsChecked;
  if not CheckBoxSetGenesisLogo.IsUpdating then
    BuildSystemsList(True);
end;

procedure TFormMain.CheckBoxSetGodModeChange(Sender: TObject);
begin
  GodMode := CheckBoxSetGodMode.IsChecked;
end;

procedure TFormMain.CheckBoxSetOpenLastFolderChange(Sender: TObject);
begin
  OpenLastFolder := CheckBoxSetOpenLastFolder.IsChecked;
end;

procedure TFormMain.CheckBoxSetPiPromptsChange(Sender: TObject);
begin
  PiPrompts := CheckBoxSetPiPrompts.IsChecked;
end;

procedure TFormMain.CheckBoxSetShowTipsChange(Sender: TObject);
begin
  ShowTips := CheckBoxSetShowTips.IsChecked;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopGameVideo;
  SaveToIni;
  if FPiLoadedOnce then
  begin
    if not PiPrompts then
      MyMessageDlg(Rst_Info, Rst_RebootRecal, [Rst_Ok]);
    if FSysIsRecal then
      StopOrStartES(False, True)
    else
      StopOrStartES(False, False);
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FPdfViewer.Free;
  FSystemList.Free;

  FImgList.Free;
  FInfosList.Free;
  FPictureLinks.Free;

  CounterGuard.Free;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.

