unit GLE.DownloadThread;

interface

uses
  System.Classes, System.SysUtils, FMX.Graphics, GLE.Resources, FMX.Objects,
  System.Net.URLClient, System.Net.HttpClient;

type
  TDownloadThread = class(TThread)
  private
    HTTPClient: THTTPClient;
    Img: TImage;
    procedure AddPicture;
  protected
    procedure Execute; override;
  public
    Url: string;
    Ext: string;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  GLE.Main;

constructor TDownloadThread.Create;
begin
  inherited Create(True);
  HTTPClient := FormMain.CreateHTTPClient;

  FreeOnTerminate := True;
  Img := nil;
end;

destructor TDownloadThread.Destroy;
begin
  HTTPClient.Free;
  inherited;
end;

procedure TDownloadThread.Execute;
var
  Stream: TBytesStream;
begin
  Stream := TBytesStream.Create;
  try
    try
      HTTPClient.Get(Url, Stream);
      if (Stream.Size = 0) then
      begin
        FormMain.WarnUser(Rst_StreamError);
        Exit;
      end;
      Stream.Position := 0;
      Img := TImage.Create(nil);
      Img.Bitmap.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  except
    on E: Exception do
    begin
      // Legacy errors
      //   400: WarnUser( Rst_ServerError1 );
      //   401: WarnUser( Rst_ServerError2 );
      //   403: WarnUser( Rst_ServerError3 );
      //   404: WarnUser( Rst_ServerError4 );
      //   423: WarnUser( Rst_ServerError5 );
      //   426: WarnUser( Rst_ServerError6 );
      //   429: WarnUser( Rst_ServerError7 );
      Img.Free;
      Img := nil;
      FormMain.WarnUserWithSafeUrl(Rst_ServerError8, E.Message, Url);
      Exit;
    end;
  end;
  Synchronize(AddPicture);
end;

procedure TDownloadThread.AddPicture;
begin
  FormMain.FImgList.Add(Img);
end;

end.

