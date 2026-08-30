unit GLE.Main;

interface

uses
  {$IFDEF MSWINDOWS}
  Winapi.Windows, {$ENDIF} System.SysUtils, System.Variants, System.Classes,
  System.IniFiles, System.Generics.Collections, System.RegularExpressions,
  System.UITypes, System.ImageList, System.StrUtils, System.SyncObjs,
  Xml.omnixmldom, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, GLE.MoreInfos, GLE.About,
  GLE.Help, GLE.ConfigureSSH, GLE.Resources, GLE.Game, GLE.ConfigureNetwork,
  GLE.AdvNameEditor, GLE.DownloadThread, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.Types, FMX.Types,
  FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Layouts, FMX.StdCtrls, FMX.Memo,
  FMX.Edit, Data.Bind.Components, FMX.Menus, FMX.ScrollBox, FMX.Memo.Types,
  FMX.Dialogs, FMX.ImgList, FMX.ListBox, FMX.Objects, FMX.TabControl,
  FMX.Filter.Effects, FMX.Controls.Presentation, FmxPasLibVlcPlayerUnit,
  FMX.SearchBox, DX.Pdf.Viewer.FMX, WinUI3.Form, FMX.Colors, FMX.ExtCtrls;

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
    MenuItemFile: TMenuItem;
    MenuItemChoosefolder: TMenuItem;
    MenuItemQuit: TMenuItem;
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
    MenuItemOptions: TMenuItem;
    MenuItemOptionGeneral: TMenuItem;
    MenuItemOptGodMode: TMenuItem;
    MenuItemOptDeleteWoPrompt: TMenuItem;
    MenuItemOptAutoHash: TMenuItem;
    MenuItemOptPiPrompts: TMenuItem;
    MenuItemOptShowTips: TMenuItem;
    MenuItemOptGenesis: TMenuItem;
    MenuItemOptionNetWork: TMenuItem;
    MenuItemOptConfigureNetwork: TMenuItem;
    MenuItemOptSSH: TMenuItem;
    MenuItemOptionLanguage: TMenuItem;
    MenuItemLang1: TMenuItem;
    MenuItemLang2: TMenuItem;
    MenuItemLang3: TMenuItem;
    MenuItemLang4: TMenuItem;
    MenuItemLang5: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemAbout: TMenuItem;
    OpenFile: TOpenDialog;
    SaveDialog: TSaveDialog;
    MenuItemReload: TMenuItem;
    NetHTTPClientScrape: TNetHTTPClient;
    Layout1: TLayout;
    Layout2: TLayout;
    RadioButtonScraper: TRadioButton;
    RadioButtonLib: TRadioButton;
    LayoutGameList: TLayout;
    ListBoxGames: TListBox;
    SearchBoxGames: TSearchBox;
    Layout4: TLayout;
    StyleBookWinUI3: TStyleBook;
    CheckBoxGamesListByRom: TCheckBox;
    Lbl_Filter: TLabel;
    ComboBoxGamesFilter: TComboBox;
    CheckBoxGamesFullRomName: TCheckBox;
    LayoutClient: TLayout;
    PanelSystems: TPanel;
    Label1: TLabel;
    ListBoxSystems: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    SearchBoxSystems: TSearchBox;
    ListBoxItem3: TListBoxItem;
    Layout6: TLayout;
    LabelGamesCount: TLabel;
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
    ButtonMoreInfos: TButton;
    MenuItemChangeAll: TMenuItem;
    Layout3: TLayout;
    TabControlMedia: TTabControl;
    TabItemPicture: TTabItem;
    ImageGame: TImage;
    ImageGameBackground: TImage;
    TabItemVideo: TTabItem;
    ImageGameBackgroundVideo: TImage;
    LayoutPlayer: TLayout;
    Rectangle1: TRectangle;
    VlcPlayer: TFmxPasLibVlcPlayer;
    MemoGameDescription: TMemo;
    Panel3: TPanel;
    Layout7: TLayout;
    Layout8: TLayout;
    Lbl_Description: TLabel;
    EditGameRomPath: TEdit;
    Label2: TLabel;
    MenuItemGameDelete: TMenuItem;
    ImageSystemLogo: TImage;
    RadioButtonPreviewPicture: TRadioButton;
    RadioButtonPreviewVideo: TRadioButton;
    MenuItemContent: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
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
    CheckBoxGameFavorite: TCheckBox;
    CheckBoxGameHidden: TCheckBox;
    CheckBoxGameKids: TCheckBox;
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
    PopupTheme: TPopup;
    Panel61: TPanel;
    PopupBoxStyle: TPopupBox;
    ComboColorBoxAccentColor: TComboColorBox;
    Layout5: TLayout;
    Button309: TButton;
    Label124: TLabel;
    CheckBoxCustomTitle: TCheckBox;
    CheckBoxCustomAccent: TCheckBox;
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

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemQuitClick(Sender: TObject);
    procedure MenuItemChoosefolderClick(Sender: TObject);
    procedure ButtonSaveChangesClick(Sender: TObject);
    procedure FieldChange(Sender: TObject);
    procedure ButtonSetDefaultPictureClick(Sender: TObject);
    procedure ComboBoxGamesFilterChange(Sender: TObject);
    procedure ButtonBtn_ChangeAll1Click(Sender: TObject);
    procedure ButtonMoreInfosClick(Sender: TObject);
    procedure MenuItemOptGodModeClick(Sender: TObject);
    procedure MenuItemOptAutoHashClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure MenuItemOptDeleteWoPromptClick(Sender: TObject);
    procedure ChangeCaseClick(Sender: TObject);
    procedure ChangeCaseGameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonRemovePictureClick(Sender: TObject);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItemRemoveRegionClick(Sender: TObject);
    procedure MenuItemOptGenesisClick(Sender: TObject);
    procedure MenuItemHelpClick(Sender: TObject);
    procedure MenuItemOptShowTipsClick(Sender: TObject);
    procedure MenuItemOptPiPromptsClick(Sender: TObject);
    procedure MenuItemConfigSSHClick(Sender: TObject);
    procedure MenuItemDeleteOrphansClick(Sender: TObject);
    procedure MenuItemDeleteDuplicatesClick(Sender: TObject);
    procedure ButtonStartScrapeClick(Sender: TObject);
    procedure MenuItemOptConfigureNetworkClick(Sender: TObject);
    procedure MenuItemSetHiddenClick(Sender: TObject);
    procedure MenuItemSetNoHiddenClick(Sender: TObject);
    procedure MenuItemSetFavoriteClick(Sender: TObject);
    procedure MenuItemSetNoFavoriteClick(Sender: TObject);
    procedure CheckBoxGamesListByRomClick(Sender: TObject);
    procedure MenuItemNameEditorClick(Sender: TObject);
    procedure MenuItemExportTxtClick(Sender: TObject);
    procedure CheckBoxGamesFullRomNameClick(Sender: TObject);
    procedure ButtonScrapeSaveClick(Sender: TObject);
    procedure ButtonScrapeUpperTextClick(Sender: TObject);
    procedure ButtonScrapeLowerTextClick(Sender: TObject);
    procedure Chk_ScrapeClick(Sender: TObject);
    procedure MenuItemReloadClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabControlMediaChange(Sender: TObject);
    procedure ButtonChangeVideoClick(Sender: TObject);
    procedure ButtonRemoveVideoClick(Sender: TObject);
    procedure ChangeMainTab(Sender: TObject);
    procedure ListBoxGamesChange(Sender: TObject);
    procedure ListBoxSystemsItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure ButtonScrapeClick(Sender: TObject);
    procedure ButtonGameMainTabClick(Sender: TObject);
    procedure ButtonChangeImageClick(Sender: TObject);
    procedure RadioButtonPreviewVideoChange(Sender: TObject);
    procedure ListBoxMediaChange(Sender: TObject);
    procedure CheckBoxManualCRCChange(Sender: TObject);
    procedure MenuItemDeleteROMNotInListClick(Sender: TObject);
    procedure ButtonSettingsClick(Sender: TObject);
    procedure Button309Click(Sender: TObject);
    procedure PopupBoxStyleChange(Sender: TObject);
    procedure CheckBoxCustomAccentChange(Sender: TObject);
    procedure ComboColorBoxAccentColorChange(Sender: TObject);
    procedure CheckBoxCustomTitleChange(Sender: TObject);

  private
    FLanguage: Integer;
    FRootPath: string;
    FCurrentFolder: string;
    FVideoScrapeLink: string;
    FIsLoading: Boolean;
    FGodMode, FAutoHash, FDelWoPrompt, FGenesisLogo, FShowTips, FFolderIsOnPi, FPiPrompts, FSysIsRecal, FPiLoadedOnce: Boolean;
    FRecalLogin, FRecalPwd, FRetroLogin, FRetroPwd: string;
    FSSLogin, FSSPwd: string;
    FScrapedGame: TGame;
    GSystemList: TObjectDictionary<string, TObjectList<TGame>>;
    FPdfViewer: TPdfViewer;
      //Pour le scrape
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
    procedure CheckMenuItem(ANumber: Integer);
    procedure RemoveRegionFromGameName(aGame: TGame; aStartPos: Integer);
    procedure ConvertFieldsCase(aGame: TGame; aUnique: Boolean = False; aUp: Boolean = False);
    procedure StopOrStartES(AStop, ARecal: Boolean);
    procedure DeleteDuplicates(const aSystem: string);
    procedure ReloadIni;
    procedure SetFavOrHidden(aFav, AValue: Boolean);
    procedure TransformGamesNames(aRemChars, aAddChars, aChangecase: Boolean; aNbStart, aNbEnd, aCaseIndex: Integer; const aStringStart, aStringEnd: string);
    procedure ExportToTxt;
    //procedure CreateWindowsMediaPlayer;
    function GetSystemKind: TSystemKind;
    function GetCurrentFolderName: string;
    function GetCurrentLogoName: string;
    function GetCurrentSystemId: string;
    function GetCountryEnum(const aShortName: string): TCountryName;
    function BuildGamesList(const aPathToFile: string): TObjectList<TGame>;
    function FormatDateFromString(const aDate: string; out Year: string; aIso: Boolean = False): string;
    function GetLangEnum(aNumber: Integer): TLangName;
    function GetPhysicalPath(const APath: string): string;
    function MyMessageDlg(const Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons; Caption: array of string; dlgcaption: string): Integer;

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
    OverTheme: integer;
    OverAccentColor: TAlphaColor;
  protected
    procedure DoOnSettingChange; override;
  public
    FProxyServer, FProxyUser, FProxyPwd, FProxyPort: string;
    FProxyUse: Boolean;
    FImgList: TObjectList<TImage>;
    procedure WarnUser(const aMessage: string);
    procedure WarnUserWithSafeUrl(const aMessage, aMessage2, aUrl: string);
  end;

var
  FormMain: TFormMain;
  CounterGuard: TCriticalSection;

implementation

uses
  System.IOUtils, FMX.BehaviorManager, WinUI3.Style, System.Messaging
  {$IFDEF POSIX}
    , Posix.StdLib, posix.Stdio, posix.SysUio
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    , Winapi.ShellAPI
  {$ENDIF}
    , System.NetEncoding;

{$R *.FMX}

function SelCount(ListBox: TListBox): Integer;
begin
  Result := 0;
  for var i := 0 to ListBox.Count - 1 do
    if ListBox.ListItems[i].IsSelected then
      Inc(Result);
end;

function TFormMain.GetPhysicalPath(const APath: string): string;
begin
  if APath.IsEmpty then
    Result := ''
  else
  begin
    Result := TPath.Combine(FRootPath, FCurrentFolder, APath.Replace('./', ''));
  end;
end;

function TFormMain.FormatDateFromString(const ADate: string; out Year: string; AIso: Boolean = False): string;
var
  FullStr, Day, Month: string;
  DayInt, MonthInt, YearInt: Integer;
begin
  FullStr := ADate;
  Result := '';

  //si on formate pour affichage et que la chaine passйe
  //rйpond au critиre
  if (not AIso) and (FullStr.Contains(Cst_DateSuffix)) then
  begin
    SetLength(FullStr, 8);
    Day := Copy(FullStr, 7, 2);
    Month := Copy(FullStr, 5, 2);
    Year := Copy(FullStr, 1, 4);
    if (TryStrToInt(Day, DayInt)) and (DayInt > 0) then
      Result := Result + Day + '/';
    if (TryStrToInt(Month, MonthInt)) and (MonthInt > 0) then
      Result := Result + Month + '/';
    if (TryStrToInt(Year, YearInt)) and (YearInt > 0) then
      Result := Result + Year;

      //sinon si on formate pour enregistrement dans le .xml
      //et que la chaine ne contient que des chiffres ou /
  end
  else if AIso and (TRegEx.IsMatch(FullStr, '^[0-9]')) then
  begin
    if (Length(FullStr) = 4) then
      Result := FullStr + Cst_DateLongFill + Cst_DateSuffix;

    if (Length(FullStr) = 7) then
    begin
      Month := Copy(FullStr, 1, 2);
      Year := Copy(FullStr, 4, 4);
      Result := Year + Month + Cst_DateShortFill + Cst_DateSuffix;
    end;

    if (Length(FullStr) = 10) then
    begin
      Day := Copy(FullStr, 1, 2);
      Month := Copy(FullStr, 4, 2);
      Year := Copy(FullStr, 7, 4);
      Result := Year + Month + Day + Cst_DateSuffix;
    end;
  end;
end;

function TFormMain.MyMessageDlg(const Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons; Caption: array of string; dlgcaption: string): Integer;
{var
  aMsgdlg: TForm;
  ii: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;   }
begin         {
  aMsgdlg := CreateMessageDialog(Msg, DlgTypt, button);
  aMsgdlg.Caption := dlgcaption;
  aMsgdlg.BiDiMode := bdLeftToRight;
  Captionindex := 0;
  for ii := 0 to Pred(aMsgdlg.ComponentCount) do
  begin
    if (aMsgdlg.components[ii] is Tbutton) then
    begin
      Dlgbutton := Tbutton(aMsgdlg.Components[ii]);
      if (Captionindex <= High(Caption)) then
        Dlgbutton.Caption := Caption[Captionindex];
      Inc(Captionindex);
    end;
  end;
  Result := aMsgdlg.Showmodal;   }
end;

procedure TFormMain.LoadFromIni;
var
  FileIni: TIniFile;
begin
  FileIni := TIniFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath));
  try
    FRootPath := FileIni.ReadString(Cst_IniOptions, Cst_IniLastPath, '');
    FGodMode := FileIni.ReadBool(Cst_IniOptions, Cst_IniGodMode, False);
    MenuItemOptGodMode.IsChecked := FGodMode;
    MenuItemOptDeleteWoPrompt.Enabled := FGodMode;
    MenuItemGameDelete.Visible := FGodMode;
    ButtonGameDelete.Visible := FGodMode;

    FAutoHash := FileIni.ReadBool(Cst_IniOptions, Cst_IniAutoHash, False);
    MenuItemOptAutoHash.IsChecked := FAutoHash;

    FDelWoPrompt := FileIni.ReadBool(Cst_IniOptions, Cst_IniDelWoPrompt, False);
    MenuItemOptDeleteWoPrompt.IsChecked := FDelWoPrompt;

    FPiPrompts := FileIni.ReadBool(Cst_IniOptions, Cst_IniPiPrompts, False);
    MenuItemOptPiPrompts.IsChecked := FPiPrompts;

    FGenesisLogo := FileIni.ReadBool(Cst_IniOptions, Cst_IniGenesisLogo, False);
    MenuItemOptGenesis.IsChecked := FGenesisLogo;

    FShowTips := FileIni.ReadBool(Cst_IniOptions, Cst_ShowTips, True);
    MenuItemOptShowTips.IsChecked := FShowTips;

    FLanguage := FileIni.ReadInteger(Cst_IniOptions, Cst_IniLanguage, 0);

    FRecalLogin := FileIni.ReadString(Cst_IniOptions, Cst_IniRecalLogin, Cst_RecalLogin);
    FRecalPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniRecalPwd, Cst_RecalPwd);
    FRetroLogin := FileIni.ReadString(Cst_IniOptions, Cst_IniRetroLogin, Cst_RetroLogin);
    FRetroPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniRetroPwd, Cst_RetroPwd);

    FSSLogin := FileIni.ReadString(Cst_IniOptions, Cst_IniSSUser, '');
    FSSPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniSSPwd, '');
    FProxyUser := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyUser, '');
    FProxyPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyPwd, '');
    FProxyServer := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyServer, '');
    FProxyPort := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyPort, '0');
    FProxyUse := FileIni.ReadBool(Cst_IniOptions, Cst_IniProxyUse, False);
  finally
    FileIni.Free;
  end;
end;

procedure TFormMain.SaveToIni;
var
  FileIni: TIniFile;
begin
  if not TDirectory.Exists(ExtractFilePath(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath))) then
    TDirectory.CreateDirectory(ExtractFilePath(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath)));
  if not TFile.Exists(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath)) then
    TFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath)).Free;
  FileIni := TIniFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath));
  try
    FileIni.WriteString(Cst_IniOptions, Cst_IniLastPath, FRootPath);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniGodMode, FGodMode);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniAutoHash, FAutoHash);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniDelWoPrompt, (FGodMode and FDelWoPrompt));
    FileIni.WriteBool(Cst_IniOptions, Cst_IniGenesisLogo, FGenesisLogo);
    FileIni.WriteBool(Cst_IniOptions, Cst_ShowTips, FShowTips);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniPiPrompts, FPiPrompts);
    FileIni.WriteInteger(Cst_IniOptions, Cst_IniLanguage, FLanguage);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRecalLogin, FRecalLogin);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRecalPwd, FRecalPwd);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRetroLogin, FRetroLogin);
    FileIni.WriteString(Cst_IniOptions, Cst_IniRetroPwd, FRetroPwd);
    FileIni.WriteString(Cst_IniOptions, Cst_IniSSUser, FSSLogin);
    FileIni.WriteString(Cst_IniOptions, Cst_IniSSPwd, FSSPwd);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyUser, FProxyUser);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyPwd, FProxyPwd);
    FileIni.WriteString(Cst_IniOptions, Cst_IniProxyServer, FProxyServer);
    if (FProxyPort.IsEmpty) then
      FileIni.WriteString(Cst_IniOptions, Cst_IniProxyPort, '0')
    else
      FileIni.WriteString(Cst_IniOptions, Cst_IniProxyPort, FProxyPort);
    FileIni.WriteBool(Cst_IniOptions, Cst_IniProxyUse, FProxyUse);
  finally
    FileIni.Free;
  end;
end;

function TFormMain.GetLangEnum(aNumber: Integer): TLangName;
begin
  Result := lnEnglish;
  for var LangName := Low(TLangName) to High(TLangName) do
  begin
    if (aNumber = Ord(LangName)) then
    begin
      Result := LangName;
      Break;
    end;
  end;
end;

function TFormMain.GetCountryEnum(const AShortName: string): TCountryName;
begin
  Result := cnUnd;
  for var CountryName := Low(TCountryName) to High(TCountryName) do
    if AShortName = Cst_CountryName[CountryName] then
      Exit(CountryName);
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

procedure TFormMain.FormCreate(Sender: TObject);
begin
  OverAccentColor := SystemAccentColor;
  BeginUpdate;
  ComboColorBoxAccentColor.Color := OverAccentColor;
  EndUpdate;
  OverTheme := 2;
  SetSystemWindowControls(ButtonWinClose, ButtonWinMax, ButtonWinMin);
  CaptionControls := [LayoutCaption, LayoutHead];
  OffsetControls := [LayoutHead];
  TitleControls := [LabelTitle];
  IconControl := ImageIcon;
  {$IFDEF MSWINDOWS}
  HideTitleBar := True;
  {$ELSE}
  HideTitleBar := False;
  LayoutCaption.Visible := False;
  LabelTitle.Visible := False;
  LayoutHeadIcon.Visible := False;
  {$ENDIF}
  CreatePdfViewer;
  MemoGameDescription.ScrollAnimation := TBehaviorBoolean.True;
  MemoScrapeDescription.ScrollAnimation := TBehaviorBoolean.True;
  TabControlEditor.TabPosition := TTabPosition.None;
  TabControlMedia.TabPosition := TTabPosition.None;
  FImgList := TObjectList<TImage>.Create;
  FInfosList := TStringList.Create(True);
  FPictureLinks := TObjectList<TMediaInfo>.Create;
  LabelGamesCount.Text := 'Games';
  GSystemList := TObjectDictionary<string, TObjectList<TGame>>.Create([doOwnsValues]);
  ListBoxGames.Clear;
  ListBoxSystems.Clear;
  LoadFromIni;
  FPiLoadedOnce := False;
  FTempXmlPath := TPath.Combine(TPath.GetLibraryPath, Cst_TempXml);
  CounterGuard := TCriticalSection.Create;

  if TDirectory.Exists(FRootPath) then
    BuildSystemsList(True);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  CheckMenuItem(Succ(FLanguage));
  if FShowTips then
  begin
    var Frm_Help := TFrm_Help.Create(nil);
    try
      FShowTips := Frm_Help.Execute(not FShowTips);
    finally
      Frm_Help.Free;
    end;
  end;
  MenuItemOptShowTips.IsChecked := FShowTips;
end;

procedure TFormMain.CheckMenuItem(aNumber: Integer);
begin
  var CompName := Cst_MenuLang + IntToStr(aNumber);
  var Comp := FindComponent(CompName);
  if not Assigned(Comp) then
    Exit;
  var MenuItem := Comp as TMenuItem;
  MenuItem.IsChecked := True;
end;

procedure TFormMain.MenuItemChoosefolderClick(Sender: TObject);
begin
  ImageGameBackground.Visible := True;
  EnableControls(False);
  ClearAllFields;
  ListBoxGames.Clear;
  BuildSystemsList;
  ButtonSaveChanges.Enabled := False;
end;

procedure TFormMain.MenuItemReloadClick(Sender: TObject);
begin
  ImageGameBackground.Visible := True;
  EnableControls(False);
  ClearAllFields;
  ListBoxGames.Clear;
  BuildSystemsList(True);
  ButtonSaveChanges.Enabled := False;
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
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + FRecalLogin +
          Cst_PlinkCommandRecal + FRecalPwd +
          Cst_PlinkCommandStop), PChar(PathToPlink), 0)
    else
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + FRetroLogin +
          Cst_PlinkCommandRetro + FRetroPwd +
          Cst_PlinkCommandStop), PChar(PathToPlink), 0);
  end
  else
  begin
    if ARecal then
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + FRecalLogin +
          Cst_PlinkCommandRecal + FRecalPwd +
          Cst_PlinkCommandStart), PChar(PathToPlink), 0)
    else
      ShellExecute(0, nil, 'cmd.exe', PChar(Cst_PlinkCommand + FRetroLogin +
          Cst_PlinkCommandRetro + FRetroPwd +
          Cst_PlinkCommandStart), PChar(PathToPlink), 0)
  end;
  {$ENDIF}
end;

procedure TFormMain.BuildSystemsList(AReload: Boolean);
begin
  ImageSystemLogo.Bitmap := nil;
  ListBoxSystems.Clear;
  ListBoxSystems.Enabled := False;
  ComboBoxGamesFilter.Enabled := False;
  Lbl_Filter.Enabled := False;
  LabelGamesCount.Text := 'Games';
  MenuItemGameDelete.Enabled := False;
  CheckBoxGameKids.IsChecked := False;
  CheckBoxGameHidden.IsChecked := False;
  CheckBoxGameFavorite.IsChecked := False;
  GSystemList.Clear;
  var ValidFolderCount := 0;

  if (not AReload) then
  begin
    MenuItemReload.Enabled := False;
    var Dir: string := FRootPath;
    if SelectDirectory('Select dir', '', Dir) then
      FRootPath := Dir
    else
      Exit;
  end;

  var Dirs := TDirectory.GetDirectories(FRootPath);
  var IsFound := Length(Dirs) > 0;
  if not IsFound then
  begin
    ShowMessage('not IsFound'#13#10 + Rst_WrongFolder);
    Exit;
  end;

  ListBoxSystems.BeginUpdate;
  try
    for var Dir in Dirs do
    begin
      if (Dir[1] <> '.') and TFile.Exists(TPath.Combine([FRootPath, Dir, Cst_GameListFileName])) then
      begin
        FCurrentFolder := TPath.GetFileName(Dir);

        var GameListPath := TPath.Combine([FRootPath, FCurrentFolder, Cst_GameListFileName]);
        var TmpList := BuildGamesList(GameListPath);

        if Assigned(TmpList) then
        begin
          GSystemList.Add(FCurrentFolder, TmpList);

          var System := TSystemKind.Create(FCurrentFolder);
          if (System = skOther) then
          begin
            var Item := TListBoxItemSystem.Create(ListBoxSystems);
            ListBoxSystems.AddObject(Item);
            Item.Text := FCurrentFolder;
            Item.ItemData.Detail := TmpList.Count.ToString;
            Item.SystemKind := System;
          end
          else if (System = skMegaDrive) and FGenesisLogo then
          begin
            var Item := TListBoxItemSystem.Create(ListBoxSystems);
            ListBoxSystems.AddObject(Item);
            Item.Text := Cst_SystemKindStr[skGenesis];
            Item.ItemData.Detail := TmpList.Count.ToString;
            Item.SystemKind := System;
          end
          else
          begin
            var Item := TListBoxItemSystem.Create(ListBoxSystems);
            ListBoxSystems.AddObject(Item);
            Item.Text := Cst_SystemKindStr[System];
            Item.ItemData.Detail := TmpList.Count.ToString;
            Item.SystemKind := System;
          end;

          Inc(ValidFolderCount);
        end;
      end;
    end;
  finally
    ListBoxSystems.EndUpdate;
  end;

  if (ValidFolderCount = 0) then
  begin
    ShowMessage('ValidFolderCount 0'#13#10 + Rst_WrongFolder);
    Exit;
  end
  else
  begin
    FFolderIsOnPi := FRootPath.StartsWith(Cst_Recalbox) or FRootPath.StartsWith(Cst_Retropie);

    if FFolderIsOnPi and not FPiLoadedOnce then
    begin
      FPiLoadedOnce := True;
      if not FPiPrompts then
        MyMessageDlg(Rst_StopES, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], [Rst_Ok], Rst_Info);
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
    Lbl_Filter.Enabled := ListBoxSystems.Enabled;
    ListBoxSystems.ItemIndex := 0;
    EnableControls(True);
    ComboBoxGamesFilter.ItemIndex := 0;
    LoadGamesList(GetCurrentFolderName);
    MenuItemReload.Enabled := True;
  end;
end;

procedure TFormMain.ButtonGameMainTabClick(Sender: TObject);
begin
  TabControlEditor.ActiveTab := TabItemEditGame;
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
    begin
      var Year: string;
      var Game := TGame.Create(
        GetNodeValue(Node, Cst_Path),
        GetNodeValue(Node, Cst_Name),
        GetNodeValue(Node, Cst_Description),
        GetNodeValue(Node, Cst_ImageLink),
        GetNodeValue(Node, Cst_VideoLink),
        GetNodeValue(Node, Cst_Rating),
        GetNodeValue(Node, Cst_Developer),
        GetNodeValue(Node, Cst_Publisher),
        GetNodeValue(Node, Cst_Genre),
        GetNodeValue(Node, Cst_Players),
        FormatDateFromString(GetNodeValue(Node, Cst_ReleaseDate), Year),
        GetNodeValue(Node, Cst_Region),
        GetNodeValue(Node, Cst_Playcount),
        GetNodeValue(Node, Cst_LastPlayed),
        GetNodeValue(Node, Cst_KidGame),
        GetNodeValue(Node, Cst_Hidden),
        GetNodeValue(Node, Cst_Favorite),
        GetNodeValue(Node, Cst_BoxLink),
        GetNodeValue(Node, Cst_ManualLink)
      );

      Game.Year := Year;
      Game.PhysicalRomPath := GetPhysicalPath(Game.RomPath);
      Game.PhysicalImagePath := GetPhysicalPath(Game.ImagePath);
      Game.PhysicalVideoPath := GetPhysicalPath(Game.VideoPath);
      Game.PhysicalBoxPath := GetPhysicalPath(Game.BoxPath);
      Game.PhysicalManualPath := GetPhysicalPath(Game.ManualPath);
      Game.IsOrphan := not TFile.Exists(Game.PhysicalRomPath);

      Result.Add(Game);
    end;
    Node := Node.NextSibling;
  until (Node = nil);

  XMLDoc.Active := False;
end;

//Action а la sйlection d'un filtre
procedure TFormMain.ComboBoxGamesFilterChange(Sender: TObject);
begin
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.ComboColorBoxAccentColorChange(Sender: TObject);
begin
  if FUpdating > 0 then
    Exit;
  BeginUpdate;
  CheckBoxCustomAccent.IsChecked := True;
  EndUpdate;
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
  ButtonMoreInfos.Enabled := AValue;
  MenuItemGameDelete.Enabled := AValue;
  ButtonGameDelete.Enabled := AValue;

  MenuItemSystem.Enabled := AValue or not (GSystemList.Count = 0);
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
  if not CheckBoxGamesListByRom.IsChecked then
  begin
    GameName := Game.Name;
  end
  else if CheckBoxGamesListByRom.IsChecked then
  begin
    if CheckBoxGamesFullRomName.IsChecked then
      GameName := StringReplace(Game.RomPath, './', '', [])
    else
      GameName := Game.RomName;
  end;
  try
    if TFile.Exists(Game.PhysicalBoxPath) then
      Item.ItemData.Bitmap.LoadThumbnailFromFile(Game.PhysicalBoxPath, 64, 64)
    else
      Item.ItemData.Bitmap := nil;
  except
    Item.ItemData.Bitmap := nil;
  end;
  if Item.ItemData.Bitmap.IsEmpty then
  begin
    Item.ItemData.Bitmap := ImageNoBox.Bitmap;
  end;
  Item.ItemData.Detail := Game.Genre;
  Item.StylesData['info'] := Game.Developer + ' ● ' + Game.Year;
  Item.StylesData['rating'] := Game.Rating;
  Item.StylesData['warn.Visible'] := Game.IsOrphan;
  Item.StylesData['favorite.Visible'] := Game.Favorite;
  Item.Text := GameName;
  Item.Game := Game;
end;

procedure TFormMain.LoadGamesList(const ASystem: string);

  function CheckIfFileMissing(const aLink: string): Boolean;
  begin
    Result := aLink.IsEmpty or not (FileExists(aLink));
  end;

  function AdjustDecimalSeparator(const Value: string): string;
  begin
    Result := StringReplace(Value, ',', '.', [rfReplaceAll]);
  end;

  function CountChar(const S: string; const Ch: Char): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to Length(S) do
      if S[i] = Ch then
        Inc(Result);
  end;

  function FlexibleDateParse(const ADateStr: string): TDate;
  var
    Year, Month: Word;
  begin
    if Length(ADateStr) = 4 then // Only year provided
    begin
      Result := EncodeDate(StrToIntDef(ADateStr, 0), 1, 1);
    end
    else if (CountChar(ADateStr, '-') = 1) or (CountChar(ADateStr, PathDelim) = 1) then // Year and month provided
    begin
      Year := StrToIntDef(Copy(ADateStr, 1, 4), 0);
      Month := StrToIntDef(Copy(ADateStr, 6, 2), 0);
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
  var
    Game: TGame;
    ROMFileName: string;
  begin
    NameCountMap := nil;
    ROMPathCountMap := nil;

     // Create dictionaries only for relevant filters
    if (FilterIndex = 29) then
      NameCountMap := TDictionary<string, Integer>.Create;
    if (FilterIndex = 30) then
      ROMPathCountMap := TDictionary<string, Integer>.Create;

    try
      for Game in GameList do
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
          ROMFileName := ExtractFileName(Game.PhysicalRomPath);
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
        ShowMessage('Error while searching for duplicates: ' + E.Message);
      end;
    end;
  end;

var
  ReferenceGame: TGame;
  TmpList: TObjectList<TGame>;
  TmpGame: TGame;
  FilterIndex: Integer;
  ParsedReferenceRating, ParsedGameRating: Double;
  ParsedReferenceDate: TDate;
  NameCountMap: TDictionary<string, Integer>;
  ROMPathCountMap: TDictionary<string, Integer>;
begin
  FilterIndex := ComboBoxGamesFilter.ItemIndex;
  ParsedGameRating := 0;
  StopGameVideo;

  if GSystemList.TryGetValue(ASystem, TmpList) then
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

    if (GetCurrentLogoName = Cst_SystemKindImageNames[skMegaDrive]) and FGenesisLogo then
      LoadSystemLogo(Cst_SystemKindImageNames[skGenesis])
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
      for TmpGame in TmpList do
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

    //On indique le nombre de jeux trouvйs
    if ComboBoxGamesFilter.ItemIndex = 0 then
      LabelGamesCount.Text := Format('Games (%d)', [ListBoxGames.Items.Count])
    else
      LabelGamesCount.Text := Format('Games (%d/%d)', [ListBoxGames.Items.Count, TmpList.Count]);

      //On met le focus sur le premier jeu de la liste
    ClearAllFields;

      //Si il y a des jeux dans la liste on affiche auto le premier
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

      //on remet les йvиnements sur les champs
    FIsLoading := False;
  end;
end;

//Charge le logo du systиme sйlectionnй dans le TImage prйvu
procedure TFormMain.LoadSystemLogo(const aPictureName: string);
begin
  try
    ImageSystemLogo.Bitmap.LoadFromFile(TPath.Combine(TPath.GetLibraryPath, Cst_LogoPicsFolder, aPictureName));
  except
  end;
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
procedure TFormMain.ListBoxSystemsItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
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

  ButtonMoreInfos.Enabled := AValue;
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
  if (TabControlMedia.ActiveTab = TabItemVideo) and (TabControlEditor.ActiveTab = TabItemEditGame) and
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
  RadioButtonPreviewPicture.IsChecked := (TabControlEditor.ActiveTab = TabItemEditGame) and (TabControlMedia.ActiveTab = TabItemPicture);
  RadioButtonPreviewVideo.IsChecked := (TabControlEditor.ActiveTab = TabItemEditGame) and (TabControlMedia.ActiveTab = TabItemVideo);
  RadioButtonPreviewManual.IsChecked := (TabControlEditor.ActiveTab = TabItemEditManual);
  if Assigned(ListBoxGames.Selected) then
  begin
    UpdateVideo((ListBoxGames.Selected as TListBoxItemGame).Game);
    if RadioButtonPreviewManual.IsChecked then
      UpdateManual((ListBoxGames.Selected as TListBoxItemGame).Game);
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
  MemoGameDescription.Text := AGame.Description;
  EditGameRegion.Text := AGame.Region;
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

procedure TFormMain.ButtonSetDefaultPictureClick(Sender: TObject);
begin
  var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;

  var PathToDefault := TPath.Combine(TPath.GetLibraryPath, Cst_DefaultPicsFolderPath, GetCurrentFolderName + Cst_DefaultImageNameSuffix);

  if not TFile.Exists(PathToDefault) then
    PathToDefault := TPath.Combine(TPath.GetLibraryPath, Cst_DefaultPicsFolderPath, Cst_DefaultImageName);

  ChangeImage(PathToDefault, Game);
  LoadGame(Game);
end;

procedure TFormMain.ButtonSettingsClick(Sender: TObject);
begin
  PopupTheme.PlacementTarget := ButtonSettings;
  PopupTheme.Popup;
end;

procedure TFormMain.Button309Click(Sender: TObject);
begin
  Inc(OverTheme);
  if OverTheme > 2 then
    OverTheme := 1;
  DoOnSettingChange;
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
  AGame.PhysicalImagePath := TPath.Combine(ImagesPath, AGame.RomNameWoExt + Cst_ImageSuffixPng);
end;

procedure TFormMain.ChangeMainTab(Sender: TObject);
begin
  if RadioButtonLib.IsChecked then
    TabControlEditor.ActiveTab := TabItemEditGame
  else if RadioButtonScraper.IsChecked then
    TabControlEditor.ActiveTab := TabItemEditScrape;
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
  AGame.PhysicalVideoPath := TPath.Combine(VideosPath, AGame.RomNameWoExt + Cst_VideoSuffixMp4);
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
    ShowMessage('Can''t remove picture file: ' + Game.PhysicalImagePath)
  end;

  Game.ImagePath := '';
  Game.PhysicalImagePath := '';

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
    ShowMessage('Can''t remove video file: ' + Game.PhysicalVideoPath)
  end;

  Game.VideoPath := '';
  Game.PhysicalVideoPath := '';

  UpdateVideo(Game);
end;

function TFormMain.GetSystemKind: TSystemKind;
begin
  if Assigned(ListBoxSystems.Selected) then
    Result := TListBoxItemSystem(ListBoxSystems.Selected).SystemKind
  else
    Result := TSystemKind.skOther;
end;

function TFormMain.GetCurrentFolderName: string;
begin
  if GetSystemKind = skOther then
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
    Result := False;
    if Assigned(aNode.ChildNodes.FindNode(aNodeName)) then
      Result := True;
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
        if CheckBoxGameKids.IsChecked then
          Node.ChildNodes.Nodes[Cst_KidGame].Text := Cst_True
        else
          Node.ChildNodes.Nodes[Cst_KidGame].Text := Cst_False;
        Game.KidGame := KidGame;
      end;

      if Game.Hidden <> Hidden then
      begin
        if not NodeExists(Node, Cst_Hidden) then
        begin
          Node.AddChild(Cst_Hidden);
          NodeAdded := True;
        end;
        if CheckBoxGameHidden.IsChecked then
          Node.ChildNodes.Nodes[Cst_Hidden].Text := Cst_True
        else
          Node.ChildNodes.Nodes[Cst_Hidden].Text := Cst_False;
        Game.Hidden := Hidden;
      end;

      if Game.Favorite <> Favorite then
      begin
        if not NodeExists(Node, Cst_Favorite) then
        begin
          Node.AddChild(Cst_Favorite);
          NodeAdded := True;
        end;
        if CheckBoxGameFavorite.IsChecked then
          Node.ChildNodes.Nodes[Cst_Favorite].Text := Cst_True
        else
          Node.ChildNodes.Nodes[Cst_Favorite].Text := Cst_False;
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

  function IntToBoolStr(const Value: Integer): string;
  begin
    Result := if Value = 0 then Cst_False else Cst_True;
  end;

  function BoolStr(const Value: Boolean): string;
  begin
    Result := if Value then Cst_True else Cst_False;
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
    Game.PhysicalImagePath := GetPhysicalPath(ImageLink);
  end;

  if ASaveVideo and (FVideoScrapeLink <> '') then
  begin
    var VideoPath := TPath.Combine([FRootPath, FCurrentFolder, Cst_SystemVideosPath, FScrapedGame.RomNameWoExt + Cst_VideoSuffixMp4]);
    SaveLinkToFile(FVideoScrapeLink, VideoPath);
    var VideoLink := TPath.Combine(Cst_SystemVideosPath, FScrapedGame.RomNameWoExt + Cst_VideoSuffixMp4);

    CheckOrAddNode(Node, Cst_VideoLink);
    Node.ChildNodes.Nodes[Cst_VideoLink].Text := VideoLink;
    Game.VideoPath := VideoLink;
    Game.PhysicalVideoPath := GetPhysicalPath(VideoLink);
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
  SetFavOrHidden(True, True);
end;

procedure TFormMain.MenuItemSetHiddenClick(Sender: TObject);
begin
  SetFavOrHidden(False, True);
end;

procedure TFormMain.MenuItemSetNoFavoriteClick(Sender: TObject);
begin
  SetFavOrHidden(True, False);
end;

procedure TFormMain.MenuItemSetNoHiddenClick(Sender: TObject);
begin
  SetFavOrHidden(False, False);
end;

procedure TFormMain.SetFavOrHidden(aFav, AValue: Boolean);

  function NodeExists(aNode: IXMLNode; const aNodeName: string): Boolean;
  begin
    Result := False;
    if Assigned(aNode.ChildNodes.FindNode(aNodeName)) then
      Result := True;
  end;

begin
  var NodeAdded := False;
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);

  for var i := 0 to Pred(ListBoxGames.Items.Count) do
  begin
    if (ListBoxGames.ListItems[i].IsSelected) then
    begin
      var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
      var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

      repeat
        if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
          Break;
        Node := Node.NextSibling;
      until not Assigned(Node);

      if aFav then
      begin
        if not (NodeExists(Node, Cst_Favorite)) then
        begin
          Node.AddChild(Cst_Favorite);
          NodeAdded := True;
        end;
        if AValue then
          Node.ChildNodes.Nodes[Cst_Favorite].Text := Cst_True
        else
          Node.ChildNodes.Nodes[Cst_Favorite].Text := Cst_False;
        Game.Favorite := AValue;
      end
      else
      begin
        if not (NodeExists(Node, Cst_Hidden)) then
        begin
          Node.AddChild(Cst_Hidden);
          NodeAdded := True;
        end;
        if AValue then
          Node.ChildNodes.Nodes[Cst_Hidden].Text := Cst_True
        else
          Node.ChildNodes.Nodes[Cst_Hidden].Text := Cst_False;
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

procedure TFormMain.ButtonDeleteClick(Sender: TObject);
begin
  if not (FDelWoPrompt or
    (MyMessageDlg(Rst_DeleteWarning, TMsgDlgType.mtInformation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], [Rst_Yes, Rst_No], Rst_Info) = mrYes)) then
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
var
  List: TObjectList<TGame>;
begin
  GSystemList.TryGetValue(GetCurrentFolderName, List);
  for var i := Pred(List.Count) downto 0 do
  begin
    if List.Items[i].IsOrphan then
      DeleteGame(List.Items[i]);
  end;
end;

procedure TFormMain.DeleteGame(AGame: TGame; ReloadGameList: Boolean = True);
var
  List: TObjectList<TGame>;
begin
  var GameListPath := GetCurrentGameListPath;
  GSystemList.TryGetValue(GetCurrentFolderName, List);

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
  end;

  if not VideoReused then
  try
    TFile.Delete(AGame.PhysicalVideoPath);
  except
  end;

  try
    if (GetSystemKind = skPS) then
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

  GSystemList.Remove(ASystem);
  GSystemList.Add(ASystem, BuildGamesList(GameListPath));

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
  CheckBoxGameKids.IsChecked := False;
  CheckBoxGameHidden.IsChecked := False;
  CheckBoxGameFavorite.IsChecked := False;

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
  HideTitleBar := CheckBoxCustomTitle.IsChecked;
end;

procedure TFormMain.CheckBoxGamesFullRomNameClick(Sender: TObject);
begin
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.CheckBoxGamesListByRomClick(Sender: TObject);
begin
  CheckBoxGamesFullRomName.Enabled := CheckBoxGamesListByRom.IsChecked;
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.MenuItemOptGodModeClick(Sender: TObject);
begin
  MenuItemGameDelete.Visible := MenuItemOptGodMode.IsChecked;
  ButtonGameDelete.Visible := MenuItemOptGodMode.IsChecked;
  FGodMode := MenuItemOptGodMode.IsChecked;
  MenuItemOptDeleteWoPrompt.Enabled := FGodMode;
  if not FGodMode then
  begin
    MenuItemOptDeleteWoPrompt.IsChecked := False;
    FDelWoPrompt := False;
  end;
end;

procedure TFormMain.MenuItemOptGenesisClick(Sender: TObject);
begin
  FGenesisLogo := MenuItemOptGenesis.IsChecked;

  for var i := 0 to Pred(ListBoxSystems.Items.Count) do
  begin
    if ((ListBoxSystems.ListItems[i] as TListBoxItemSystem).SystemKind = skMegadrive) then
    begin
      if FGenesisLogo then
        ListBoxSystems.ListItems[i].Text := Cst_SystemKindStr[skGenesis]
      else if not FGenesisLogo then
        ListBoxSystems.ListItems[i].Text := Cst_SystemKindStr[skMegaDrive];
      ListBoxSystems.ItemIndex := i;
      Break;
    end;
  end;

  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.MenuItemOptAutoHashClick(Sender: TObject);
begin
  FAutoHash := MenuItemOptAutoHash.IsChecked;
end;

procedure TFormMain.MenuItemOptDeleteWoPromptClick(Sender: TObject);
begin
  FDelWoPrompt := MenuItemOptDeleteWoPrompt.IsChecked;
end;

procedure TFormMain.MenuItemExportTxtClick(Sender: TObject);
begin
  ExportToTxt;
end;

procedure TFormMain.ExportToTxt;
var
  FirstCharRef, FirstCharCurrent: string;
  SortedList, FormatedList: TStringList;
  SystemList: TObjectList<TGame>;
  Game: TGame;
begin
  GSystemList.TryGetValue(GetCurrentFolderName, SystemList);

  SortedList := TStringList.Create;
  FormatedList := TStringList.Create;
  try
    SortedList.Sorted := True;
    SortedList.Duplicates := dupAccept;
    for Game in SystemList do
    begin
      if CheckBoxGamesListByRom.IsChecked then
        SortedList.Add(Game.RomName)
      else
        SortedList.Add(Game.Name);
    end;

    FirstCharRef := SortedList[0][1];
    FormatedList.Add('---------- ' + AnsiUpperCase(FirstCharRef) + ' ----------');
    FormatedList.Add(sLineBreak);

    for var i := 0 to Pred(SortedList.Count) do
    begin
      FirstCharCurrent := SortedList[i][1];
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

procedure TFormMain.MenuItemConfigSSHClick(Sender: TObject);
begin
  var Frm_ConfigSSH := TFrm_ConfigureSSH.Create(nil);
  try
    Frm_ConfigSSH.Execute(FRecalLogin, FRecalPwd, FRetroLogin, FRetroPwd);
  finally
    Frm_ConfigSSH.Free;
  end;
end;

procedure TFormMain.MenuItemOptConfigureNetworkClick(Sender: TObject);
begin
  var Frm_Network := TFrm_Network.Create(nil);
  try
    Frm_Network.Execute(FSSLogin, FSSPwd, FProxyUser, FProxyPwd, FProxyServer, FProxyPort, FProxyUse);
  finally
    Frm_Network.Free;
  end;
  ReloadIni;
end;

procedure TFormMain.RadioButtonPreviewVideoChange(Sender: TObject);
begin
  if RadioButtonPreviewPicture.IsChecked then
    TabControlMedia.ActiveTab := TabItemPicture
  else if RadioButtonPreviewVideo.IsChecked then
    TabControlMedia.ActiveTab := TabItemVideo
  else if RadioButtonPreviewManual.IsChecked then
    TabControlEditor.ActiveTab := TabItemEditManual;
end;

procedure TFormMain.ReloadIni;
begin
  var FileIni := TIniFile.Create(TPath.Combine(TPath.GetLibraryPath, Cst_IniFilePath));
  try
    FSSLogin := FileIni.ReadString(Cst_IniOptions, Cst_IniSSUser, '');
    FSSPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniSSPwd, '');
    FProxyUser := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyUser, '');
    FProxyPwd := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyPwd, '');
    FProxyServer := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyServer, '');
    FProxyPort := FileIni.ReadString(Cst_IniOptions, Cst_IniProxyPort, '');
    FProxyUse := FileIni.ReadBool(Cst_IniOptions, Cst_IniProxyUse, False);
  finally
    FileIni.Free;
  end;
end;

procedure TFormMain.ChangeCaseClick(Sender: TObject);
var
  List: TObjectList<TGame>;
begin
  GSystemList.TryGetValue(GetCurrentFolderName, List);

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

  function ConvertUpOrLow(ANode: IXMLNode; const aNodeName: string; AUp: Boolean; const AField: string): string;
  begin
    if AUp then
    begin
      Result := AnsiUpperCase(AField);
    end
    else
    begin
      Result := AnsiLowerCase(AField);
    end;
    if Assigned(ANode.ChildNodes.FindNode(aNodeName)) then
      ANode.ChildNodes.Nodes[aNodeName].Text := Result;
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
  GSystemList.TryGetValue(GetCurrentFolderName, Games);
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

    ShowMessage(ListToDelete.Text);

    for var ROM in ListToDelete do
      TFile.Delete(ROM);
  finally
    ListToDelete.Free;
  end;
end;

procedure TFormMain.MenuItemAboutClick(Sender: TObject);
begin
  var Frm_About := TFrm_About.Create(nil);
  try
    Frm_About.Execute;
  finally
    Frm_About.Free;
  end;
end;

procedure TFormMain.MenuItemHelpClick(Sender: TObject);
begin
  var Frm_Help := TFrm_Help.Create(nil);
  try
    Frm_Help.Chk_ShowTips.Visible := False;
    FShowTips := Frm_Help.Execute(not FShowTips);
  finally
    Frm_Help.Free;
  end;
end;

procedure TFormMain.MenuItemOptPiPromptsClick(Sender: TObject);
begin
  FPiPrompts := MenuItemOptPiPrompts.IsChecked;
end;

procedure TFormMain.ButtonMoreInfosClick(Sender: TObject);
begin
  if not Assigned(ListBoxGames.Selected) then
    Exit;
  var Game := (ListBoxGames.Selected as TListBoxItemGame).Game;

  if ((Game.Md5.IsEmpty) or (Game.Sha1.IsEmpty) or (Game.Crc32.IsEmpty)) then
  begin
    if FAutoHash or ((not FAutoHash) and
      (MyMessageDlg(Rst_HashWarning, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], [Rst_Yes, Rst_No], Rst_Info) = mrYes))
      then
    begin
      Game.Md5 := Game.CalculateMd5(Game.PhysicalRomPath);
      Game.Sha1 := Game.CalculateSha1(Game.PhysicalRomPath);
      Game.Crc32 := Game.CalculateCrc32(Game.PhysicalRomPath);
    end;
  end;

  var FormMorInfos := TFormMorInfos.Create(nil);
  try
    FormMorInfos.Execute(Game);
  finally
    FormMorInfos.Free;
  end;
end;

procedure TFormMain.MenuItemRemoveRegionClick(Sender: TObject);
var
  List: TObjectList<TGame>;
begin
  GSystemList.TryGetValue(GetCurrentFolderName, List);

  for var i := 0 to Pred(List.Count) do
  begin
    var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
    var CPos := Pos('[', Game.Name);

    if not (CPos = 0) then
      RemoveRegionFromGameName(Game, Pred(CPos));
  end;
  LoadGamesList(GetCurrentFolderName);
end;

procedure TFormMain.MenuItemOptShowTipsClick(Sender: TObject);
begin
  FShowTips := MenuItemOptShowTips.IsChecked;
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
var
  RemChars, AddChars, ChangeCase: Boolean;
  NbStart, NbEnd, CaseIndex: Integer;
  StringStart, StringEnd, Preview: string;
begin
  for var i := 0 to Pred(ListBoxGames.Items.Count) do
  begin
    if (ListBoxGames.ListItems[i].IsSelected) then
    begin
      Preview := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game.Name;
      Break;
    end;
  end;

  var FrmNameEditor := TFormAdvNameEditor.Create(nil);
  try
    if FrmNameEditor.Execute(RemChars, AddChars, ChangeCase, NbStart, NbEnd,
      CaseIndex, StringStart, StringEnd, Preview) then
    begin
      TransformGamesNames(RemChars, AddChars, ChangeCase, NbStart,
        NbEnd, CaseIndex, StringStart, StringEnd);
      LoadGamesList(GetCurrentFolderName);
    end;
  finally
    FrmNameEditor.Free;
  end;
end;

procedure TFormMain.TransformGamesNames(ARemChars, AAddChars, AChangecase: Boolean; ANbStart, ANbEnd, ACaseIndex: Integer; const AStringStart, AStringEnd: string);
begin
  var GameListPath := GetCurrentGameListPath;

  XMLDoc.LoadFromFile(GameListPath);

  for var i := 0 to Pred(ListBoxGames.Items.Count) do
  begin
    if (ListBoxGames.ListItems[i].IsSelected) then
    begin
      var Game := (ListBoxGames.ListItems[i] as TListBoxItemGame).Game;
      var TmpStr := Game.Name;

      if ARemChars then
      begin
        if (ANbStart > 0) then
          TmpStr := Copy(TmpStr, Succ(ANbStart), (TmpStr.Length - ANbStart));
        if (ANbEnd > 0) then
          SetLength(TmpStr, TmpStr.Length - ANbEnd);
      end;

      if AChangecase then
      begin
        case ACaseIndex of
          0:
            TmpStr[1] := UpCase(TmpStr[1]);
          1:
            TmpStr := UpperCase(TmpStr);
          2:
            TmpStr := LowerCase(TmpStr);
        end;
      end;

      if AAddChars then
      begin
        if not (AStringStart.IsEmpty) then
          TmpStr := AStringStart + TmpStr;
        if not (AStringEnd.IsEmpty) then
          TmpStr := TmpStr + AStringEnd;
      end;

      Game.Name := TmpStr;
      var Node := XMLDoc.DocumentElement.ChildNodes.FindNode(Cst_Game);

      while Assigned(Node) do
      begin
        if (Node.ChildNodes.Nodes[Cst_Path].Text = Game.RomPath) then
          Break;
        Node := Node.NextSibling;
      end;

      Node.ChildNodes.Nodes[Cst_Name].Text := TmpStr;
    end;
  end;

  XMLDoc.SaveToFile(GameListPath);
  XMLDoc.Active := False;
end;

procedure TFormMain.MenuItemQuitClick(Sender: TObject);
begin
  SaveToIni;

  if FPiLoadedOnce then
  begin
    if not FPiPrompts then
      MyMessageDlg(Rst_RebootRecal, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], [Rst_Ok], Rst_Info);
    if FSysIsRecal then
      StopOrStartES(False, True)
    else
      StopOrStartES(False, False);
  end;
  Application.Terminate;
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
  else
    Crc32 := AGame.CalculateCrc32(AGame.PhysicalRomPath);

  var Size := TFile.GetSize(AGame.PhysicalRomPath);

  var Query := Cst_ScraperAddress + Cst_Category + Cst_ScrapeLogin + Cst_ScrapePwd +
    Cst_DevSoftName + Cst_Output;

  if (not FSSLogin.IsEmpty) and (not FSSPwd.IsEmpty) then
    Query := Query + Cst_SSId + FSSLogin + Cst_SSPwd + FSSPwd;

  Query := Query + Cst_Crc + Crc32 + Cst_SystemId + ASysId;

  if not (CheckBoxManualCRC.IsChecked) then
    Query := Query + Cst_RomName + TNetEncoding.URL.Encode(AGame.RomName) + Cst_RomSize + Size.ToString;

  //ShowMessage(Query);
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
  // Set window type
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
  UpdateSystemBackdropType;
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

procedure TFormMain.GetPicture(AMedia: TMediaInfo);
begin
  var Thread := TDownThread.Create;
  Thread.Url := AMedia.FileLink;
  Thread.Ext := AMedia.FileExt;
  Thread.OnTerminate := ThreadTerminated;
  Thread.Start;
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
begin//FF2C4361 - FF0B1E39
  if CheckBoxCustomAccent.IsChecked then
    OverAccentColor := ComboColorBoxAccentColor.Color
  else
    OverAccentColor := SystemAccentColor;

  // Override theme color
  case OverTheme of
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
  end
  else
  begin
    // Set accent color for stylebook
    ChangeStyleBookColor(StyleBookWinUI3Light, OverAccentColor);
    StyleBook := StyleBookWinUI3Light;
  end;

  inherited;
  if IsDark then
  begin
    //Fill.Kind := TBrushKind.None;
    Fill.Kind := TBrushKind.Gradient;
    Fill.Gradient.Color := $FF2C4361;
    Fill.Gradient.Color1 := $FF0B1E39;
  end;
  TMessageManager.DefaultManager.SendMessage(Self, TStyleChangedMessage.Create(StyleBook, Self), True);
  TMessageManager.DefaultManager.SendMessage(Self, TInternalSettingChangedMessage.Create(StyleBook, Self), True);
end;

procedure TFormMain.FillFields;

  function GetFormatedDate(const aStr: string): string;
  var
    Day, Month, Year: string;
  begin
    if (Length(aStr) = 4) then
      Result := aStr;

    if (Length(aStr) = 7) then
    begin
      Month := Copy(aStr, 6, 2);
      Year := Copy(aStr, 1, 4);
      Result := Month + '/' + Year;
    end;

    if (Length(aStr) = 10) then
    begin
      Day := Copy(aStr, 9, 2);
      Month := Copy(aStr, 6, 2);
      Year := Copy(aStr, 1, 4);
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
      Dict.TryGetValue(Cst_CountryName[cnEu], TmpStr) or
      Dict.TryGetValue(Cst_CountryName[cnWor], TmpStr) or
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
      EditScrapeRegion.Text := EditScrapeRegion.Text +
        Cst_CountryNameFull[GetCountryEnum(List[ii])][Succ(FLanguage)];
      if (ii < Pred(List.Count)) then
        EditScrapeRegion.Text := EditScrapeRegion.Text + ' - ';
    end;
  end
  else
    EditScrapeRegion.Text := '';

  if not FInfosList[2].IsEmpty then
  begin
    Dict := (FInfosList.Objects[2] as TDictionary<string, string>);
    if Dict.TryGetValue(LangStr, TmpStr) or
      Dict.TryGetValue(Cst_LangNameStr[lnEnglish], TmpStr) or
      Dict.TryGetValue(Cst_LangNameStr[lnGerman], TmpStr) or
      Dict.TryGetValue(Cst_LangNameStr[lnSpanish], TmpStr) or
      Dict.TryGetValue(Copy(Cst_LangNameStr[lnPortuguese_BR], 1, 2), TmpStr) then
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
      Dict.TryGetValue(Cst_CountryName[cnEu], TmpStr) or
      Dict.TryGetValue(Cst_CountryName[cnWor], TmpStr) or
      Dict.TryGetValue(Cst_CountryName[cnUs], TmpStr) or
      Dict.TryGetValue(Cst_CountryName[cnJp], TmpStr) then
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
        (Item.Value.TryGetValue(Cst_LangNameStr[lnEnglish], TmpStr)) or
        (Item.Value.TryGetValue(Cst_LangNameStr[lnGerman], TmpStr)) or
        (Item.Value.TryGetValue(Cst_LangNameStr[lnSpanish], TmpStr)) or
        (Item.Value.TryGetValue(Copy(Cst_LangNameStr[lnPortuguese_BR], 1, 2), TmpStr)) then
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
  ShowMessage(AMessage);
end;

procedure TFormMain.WarnUserWithSafeUrl(const AMessage, AMessage2, AUrl: string);
begin
  var ASafeUrl := AUrl.Replace('&', '&&').Replace(Cst_ScrapePwd, Cst_ScrapePwdSafe);

  if ASafeUrl.Length > 160 then
    ASafeUrl.Insert(120, sLineBreak);

  WarnUser(AMessage + sLineBreak +
    AMessage2 + sLineBreak + sLineBreak +
    ASafeUrl);
end;

procedure TFormMain.ButtonStartScrapeClick(Sender: TObject);
begin
  EmptyScrapeFields;
  ClearScrapeMedia;
  StopGameVideo;

  if FProxyUse then
  begin
    NetHTTPClientScrape.ProxySettings := TProxySettings.Create(
      FProxyServer,
      StrToInt(FProxyPort),
      FProxyUser,
      FProxyPwd);
  end
  else
  begin
    NetHTTPClientScrape.ProxySettings := TProxySettings.Create('', 0, '', '');
  end;

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

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveToIni;
  if FPiLoadedOnce then
  begin
    if not FPiPrompts then
      MyMessageDlg(Rst_RebootRecal, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], [Rst_Ok], Rst_Info);
    if FSysIsRecal then
      StopOrStartES(False, True)
    else
      StopOrStartES(False, False);
  end;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  StopGameVideo;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FPdfViewer.Free;
  GSystemList.Free;

  FImgList.Free;
  FInfosList.Free;
  FPictureLinks.Free;

  CounterGuard.Free;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.

