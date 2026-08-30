unit GLE.Game;

interface

uses
  System.StrUtils, System.Classes, System.SysUtils, IdHashCRC, GLE.Resources;

type
   //Objet stockant uniquement le type système (enum) pour
   //combobox systems, permet de retrouver facile l'image et le nom du systeme
  TSystemKindHelper = record helper for TSystemKind
    class function Create(const Name: string): TSystemKind; static;
  end;

  TGame = class
  private
    FRomPath: string;
    FRomName: string;
    FRomNameWoExt: string;
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
    FIsOrphan: Boolean;
    FPhysicalRomPath: string;
    FPhysicalImagePath: string;
    FPhysicalVideoPath: string;
    FPhysicalBoxPath: string;
    FYear: string;
    FManualPath: string;
    FPhysicalManualPath: string;
    procedure Load(aPath, aName, aDescription, aImagePath, aVideoPath, aRating, aDeveloper, aPublisher, aGenre, aPlayers, aDate, aRegion, aPlaycount, aLastplayed, aKidGame, aHidden, aFavorite, aBox, aManual: string);
    function GetRomName(const aRomPath: string): string;
  public
    constructor Create(aPath, aName, aDescription, aImagePath, aVideoPath, aRating, aDeveloper, aPublisher, aGenre, aPlayers, aDate, aRegion, aPlaycount, aLastplayed, aKidGame, aHidden, aFavorite, aBox, aManual: string); reintroduce;

    property RomPath: string read FRomPath write FRomPath;
    property RomName: string read FRomName write FRomName;
    property RomNameWoExt: string read FRomNameWoExt write FRomNameWoExt;
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
    property IsOrphan: Boolean read FIsOrphan write FIsOrphan;
    property ManualPath: string read FManualPath write FManualPath;
    property PhysicalRomPath: string read FPhysicalRomPath write FPhysicalRomPath;
    property PhysicalImagePath: string read FPhysicalImagePath write FPhysicalImagePath;
    property PhysicalVideoPath: string read FPhysicalVideoPath write FPhysicalVideoPath;
    property PhysicalBoxPath: string read FPhysicalBoxPath write FPhysicalBoxPath;
    property PhysicalManualPath: string read FPhysicalManualPath write FPhysicalManualPath;

    function CalculateMd5(const aFileName: string): string;
    function CalculateSha1(const aFileName: string): string;
    function CalculateCrc32(const aFileName: string): string;
  end;

implementation

uses
  System.Hash;

constructor TGame.Create(aPath, aName, aDescription, aImagePath, aVideoPath, aRating, aDeveloper, aPublisher, aGenre, aPlayers, aDate, aRegion, aPlaycount, aLastplayed, aKidGame, aHidden, aFavorite, aBox, aManual: string);
begin
  Load(aPath, aName, aDescription, aImagePath, aVideoPath, aRating,
    aDeveloper, aPublisher, aGenre, aPlayers, aDate, aRegion, aPlaycount,
    aLastplayed, aKidGame, aHidden, aFavorite, aBox, aManual);
end;

procedure TGame.Load(aPath, aName, aDescription, aImagePath, aVideoPath, aRating, aDeveloper, aPublisher, aGenre, aPlayers, aDate, aRegion, aPlaycount, aLastplayed, aKidGame, aHidden, aFavorite, aBox, aManual: string);
begin
  FRomPath := aPath;
  FRomName := GetRomName(aPath);
  FRomNameWoExt := ChangeFileExt(FRomName, '');
  FImagePath := aImagePath;
  FBoxPath := aBox;
  FVideoPath := aVideoPath;
  FName := aName;
  FDescription := aDescription;
  FRating := aRating;
  FReleaseDate := aDate;
  FDeveloper := aDeveloper;
  FPublisher := aPublisher;
  FGenre := aGenre;
  FPlayers := aPlayers;
  FRegion := aRegion;
  FPlaycount := aPlaycount;
  FLastplayed := aLastplayed;
  FKidGame := aKidGame = Cst_True;
  FHidden := aHidden = Cst_True;
  FFavorite := aFavorite = Cst_True;
  FManualPath := aManual;
end;

function TGame.GetRomName(const aRomPath: string): string;
begin
  var Delim := LastDelimiter('/', aRomPath);
  Result := Copy(aRomPath, Succ(Delim), (aRomPath.Length - Delim));
end;

function TGame.CalculateMd5(const aFileName: string): string;
begin
  if FileExists(aFileName) then
    Result := THashMD5.GetHashStringFromFile(aFileName)
  else
    Result := '';
end;

function TGame.CalculateSha1(const aFileName: string): string;
begin
  if FileExists(aFileName) then
    Result := THashSHA1.GetHashStringFromFile(aFileName)
  else
    Result := '';
end;

function TGame.CalculateCrc32(const aFileName: string): string;
var
  IdCRC32: TIdHashCRC32;
  FS: TFileStream;
begin
  if FileExists(aFileName) then
  begin
    IdCRC32 := TIdHashCRC32.Create;
    FS := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
    try
      Result := IdCRC32.HashStreamAsHex(FS)
    finally
      FS.Free;
      IdCRC32.Free;
    end;
  end;
end;

{ TSystemKindHelper }

class function TSystemKindHelper.Create(const Name: string): TSystemKind;
begin
  Result := skOther;
  for var SystemKind := Low(TSystemKind) to High(TSystemKind) do
    if (Cst_SystemKindFolderNames[SystemKind] = Name.ToLower) then
    begin
      Result := SystemKind;
      Break;
    end;
end;

end.

