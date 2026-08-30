unit GLE.DownloadThread;

interface

uses
  System.Classes, System.SysUtils, FMx.Graphics, GLE.Resources, FMX.Objects,
  System.Net.HttpClientComponent, System.Net.URLClient, System.Net.HttpClient;

type
  TDOwnThread = class(TThread)
  private
    Net_HTTPClient: TNetHTTPClient;
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

constructor TDOwnThread.Create;
begin
  inherited Create(True);
  Net_HTTPClient := TNetHTTPClient.Create(Net_HTTPClient);
  if FormMain.FProxyUse then
  begin
    Net_HTTPClient.ProxySettings := TProxySettings.Create(
      FormMain.FProxyServer,
      StrToInt(FormMain.FProxyPort),
      FormMain.FProxyUser,
      FormMain.FProxyPwd);
  end
  else
  begin
    Net_HTTPClient.ProxySettings := TProxySettings.Create('', 0, '', '');
  end;

  FreeOnTerminate := True;
  Img := nil;
end;

destructor TDOwnThread.Destroy;
begin
  Net_HTTPClient.Free;
  inherited;
end;

procedure TDOwnThread.Execute;
var
  Stream: TBytesStream;
begin
  Stream := TBytesStream.Create;
  try
    try
      Net_HTTPClient.Get(Url, Stream);
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

procedure TDOwnThread.AddPicture;
begin
  FormMain.FImgList.Add(Img);
end;

end.

