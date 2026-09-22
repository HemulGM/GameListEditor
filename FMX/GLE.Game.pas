unit GLE.Game;

interface

uses
  System.StrUtils, System.Classes, System.SysUtils, IdHashCRC, Xml.XMLIntf,
  GLE.Resources;

type
  TGame = class
  private
    FRootFolder: string;
    FRomPath: string;
    FImagePath: string;
    FBoxPath: string;
    FVideoPath: string;
    FName: string;
    FDescription: string;
    FRating: string;
    FReleaseDate: string;
    FDeveloper: string;
    FPublisher: string;
    FGenre: string;
    FPlayers: string;
    FRegion: string;
    FPlaycount: string;
    FLastplayed: string;
    FCrc32: string;
    FMd5: string;
    FSha1: string;
    FKidGame: Boolean;
    FHidden: Boolean;
    FFavorite: Boolean;
    FYear: string;
    FManualPath: string;
    function GetRomNameWoExt: string;
    function GetRomName: string;
    function GetIsOrphan: Boolean;
    function GetPhysicalBoxPath: string;
    function GetPhysicalImagePath: string;
    function GetPhysicalManualPath: string;
    function GetPhysicalRomPath: string;
    function GetPhysicalVideoPath: string;
    function GetPhysicalPath(const APath: string): string;
  public
    constructor Create;
    class function CreateFrom(const Node: IXMLNode; const ARootFolder: string): TGame;
    property RomPath: string read FRomPath write FRomPath;
    property RomName: string read GetRomName;
    property RomNameWoExt: string read GetRomNameWoExt;
    property ImagePath: string read FImagePath write FImagePath;
    property BoxPath: string read FBoxPath write FBoxPath;
    property VideoPath: string read FVideoPath write FVideoPath;
    property Name: string read FName write FName;
    property Description: string read FDescription write FDescription;
    property Rating: string read FRating write FRating;
    property ReleaseDate: string read FReleaseDate write FReleaseDate;
    property Year: string read FYear write FYear;
    property Developer: string read FDeveloper write FDeveloper;
    property Publisher: string read FPublisher write FPublisher;
    property Genre: string read FGenre write FGenre;
    property Players: string read FPlayers write FPlayers;
    property Region: string read FRegion write FRegion;
    property Playcount: string read FPlaycount write FPlaycount;
    property Lastplayed: string read FLastplayed write FLastplayed;
    property Crc32: string read FCrc32 write FCrc32;
    property Md5: string read FMd5 write FMd5;
    property Sha1: string read FSha1 write FSha1;
    property KidGame: Boolean read FKidGame write FKidGame;
    property Hidden: Boolean read FHidden write FHidden;
    property Favorite: Boolean read FFavorite write FFavorite;
    property IsOrphan: Boolean read GetIsOrphan;
    property ManualPath: string read FManualPath write FManualPath;
    property PhysicalRomPath: string read GetPhysicalRomPath;
    property PhysicalImagePath: string read GetPhysicalImagePath;
    property PhysicalVideoPath: string read GetPhysicalVideoPath;
    property PhysicalBoxPath: string read GetPhysicalBoxPath;
    property PhysicalManualPath: string read GetPhysicalManualPath;

    function CalculateMd5(const aFileName: string): string;
    function CalculateSha1(const aFileName: string): string;
    function CalculateCrc32(const aFileName: string): string;
  end;

function FormatDateFromString(const aDate: string; out Year: string; aIso: Boolean = False): string;

implementation

uses
  System.Hash, System.IOUtils, System.RegularExpressions;

function FormatDateFromString(const ADate: string; out Year: string; AIso: Boolean = False): string;
begin
  var FullStr := ADate;
  Result := '';

  if (not AIso) and (FullStr.Contains(Cst_DateSuffix)) then
  begin
    SetLength(FullStr, 8);
    var Day := Copy(FullStr, 7, 2);
    var Month := Copy(FullStr, 5, 2);
    Year := Copy(FullStr, 1, 4);
    var DayInt, MonthInt, YearInt: Integer;
    if (TryStrToInt(Day, DayInt)) and (DayInt > 0) then
      Result := Result + Day + '/';
    if (TryStrToInt(Month, MonthInt)) and (MonthInt > 0) then
      Result := Result + Month + '/';
    if (TryStrToInt(Year, YearInt)) and (YearInt > 0) then
      Result := Result + Year;
  end
  else if AIso and (TRegEx.IsMatch(FullStr, '^[0-9]')) then
  begin
    if (Length(FullStr) = 4) then
      Result := FullStr + Cst_DateLongFill + Cst_DateSuffix;

    if (Length(FullStr) = 7) then
    begin
      var Month := Copy(FullStr, 1, 2);
      Year := Copy(FullStr, 4, 4);
      Result := Year + Month + Cst_DateShortFill + Cst_DateSuffix;
    end;

    if (Length(FullStr) = 10) then
    begin
      var Day := Copy(FullStr, 1, 2);
      var Month := Copy(FullStr, 4, 2);
      Year := Copy(FullStr, 7, 4);
      Result := Year + Month + Day + Cst_DateSuffix;
    end;
  end;
end;

constructor TGame.Create;
begin
  inherited;
end;

function TGame.GetPhysicalPath(const APath: string): string;
begin
  if APath.IsEmpty then
    Result := ''
  else
  begin
    Result := TPath.Combine(FRootFolder, APath.Replace('./', ''));
  end;
end;

class function TGame.CreateFrom(const Node: IXMLNode; const ARootFolder: string): TGame;

  function GetNodeValue(ANode: IXMLNode; const ANodeName: string): string;
  begin
    if Assigned(ANode.ChildNodes.FindNode(ANodeName)) then
      Result := ANode.ChildNodes.Nodes[ANodeName].Text
    else
      Result := '';
  end;

begin
  var Year: string;
  Result := TGame.Create;
  Result.FRootFolder := ARootFolder;
  Result.FRomPath := GetNodeValue(Node, Cst_Path);
  Result.FName := GetNodeValue(Node, Cst_Name);
  Result.FDescription := GetNodeValue(Node, Cst_Description);
  Result.FImagePath := GetNodeValue(Node, Cst_ImageLink);
  Result.FVideoPath := GetNodeValue(Node, Cst_VideoLink);
  Result.FRating := GetNodeValue(Node, Cst_Rating);
  Result.FDeveloper := GetNodeValue(Node, Cst_Developer);
  Result.FPublisher := GetNodeValue(Node, Cst_Publisher);
  Result.FGenre := GetNodeValue(Node, Cst_Genre);
  Result.FPlayers := GetNodeValue(Node, Cst_Players);
  Result.FReleaseDate := FormatDateFromString(GetNodeValue(Node, Cst_ReleaseDate), Year);
  Result.FRegion := GetNodeValue(Node, Cst_Region);
  Result.FPlaycount := GetNodeValue(Node, Cst_Playcount);
  Result.FLastplayed := GetNodeValue(Node, Cst_LastPlayed);
  Result.FKidGame := GetNodeValue(Node, Cst_KidGame) = Cst_True;
  Result.FHidden := GetNodeValue(Node, Cst_Hidden) = Cst_True;
  Result.FFavorite := GetNodeValue(Node, Cst_Favorite) = Cst_True;
  Result.FBoxPath := GetNodeValue(Node, Cst_BoxLink);
  Result.FManualPath := GetNodeValue(Node, Cst_ManualLink);
  Result.Year := Year;
end;

function TGame.GetIsOrphan: Boolean;
begin
  Result := not TFile.Exists(PhysicalRomPath);
end;

function TGame.GetPhysicalBoxPath: string;
begin
  Result := GetPhysicalPath(BoxPath);
end;

function TGame.GetPhysicalImagePath: string;
begin
  Result := GetPhysicalPath(ImagePath);
end;

function TGame.GetPhysicalManualPath: string;
begin
  Result := GetPhysicalPath(ManualPath);
end;

function TGame.GetPhysicalRomPath: string;
begin
  Result := GetPhysicalPath(RomPath);
end;

function TGame.GetPhysicalVideoPath: string;
begin
  Result := GetPhysicalPath(VideoPath);
end;

function TGame.GetRomName: string;
begin
  Result := TPath.GetFileName(FRomPath);
end;

function TGame.GetRomNameWoExt: string;
begin
  Result := TPath.GetFileNameWithoutExtension(FRomPath);
end;

function TGame.CalculateMd5(const aFileName: string): string;
begin
  if TFile.Exists(aFileName) then
    Result := THashMD5.GetHashStringFromFile(aFileName)
  else
    Result := '';
end;

function TGame.CalculateSha1(const aFileName: string): string;
begin
  if TFile.Exists(aFileName) then
    Result := THashSHA1.GetHashStringFromFile(aFileName)
  else
    Result := '';
end;

function TGame.CalculateCrc32(const aFileName: string): string;
begin
  if TFile.Exists(aFileName) then
  begin
    var CRC32 := TIdHashCRC32.Create;
    var FS := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
    try
      Result := CRC32.HashStreamAsHex(FS)
    finally
      FS.Free;
      CRC32.Free;
    end;
  end;
end;

end.

