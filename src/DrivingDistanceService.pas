unit DrivingDistanceService;

interface 

uses fphttpclient;

type
  HttpGetClient = interface
    function Get (url: String): String;
  end;

  THttpGetClient = class(HttpGetClient)
  private 
    FHttpClient : TFPHttpClient; 
  public
    constructor Create;
    destructor Destroy; override;
    function Get (url: String): String;
  end;
  
  TDrivingDistanceService = class
  private
    FHttpGetClient: HttpGetClient;
  public
    constructor Create(AHttpGetClient: HttpGetClient); overload;
    destructor Destroy; override;
    function DrivingDistance(from: TLatLng; to: TLatLng): Kilometers;
  end;

  TDrivingDistance = Kilometers;

implementation

constructor THttpGetClient.Create;
begin
  FHttpClient := TFPHttpClient.Create(Nil);
end;

destructor THttpGetClient.Destroy;
begin
  FreeAndNil(FHttpClient);
end;

function THttpGetClient.Get (url: String): String;
var 
  Content: String;
begin
  Content := FHttpClient.Get(url);
end;

constructor TDrivingDistanceService.(AHttpGetClient: HttpGetClient);
begin
  Assert(AHttpGetClient <> Nil, 'HttpGetClient is nil');
  FHttpGetClient := AHttpGetClient;
end;

function TDrivingDistanceService.DrivingDistance(from: TLatLng; to: TLatLng): Kilometers;
var 
  DrivingDistance : Kilometers;
begin
  Content := FHttpClient.Get(url);
end;

end.