unit DrivingDistanceService;

{$mode objfpc}{$H+}

interface 

uses SysUtils, FPHttpClient, LatLng, FPJSON;

type
  TDrivingDistanceService = class
  public
    constructor Create;
    destructor Destroy; override;
    function DrivingDistance(from: TLatLng; destination: TLatLng): Kilometers;
  end;

  TDrivingDistance = Kilometers;
  EDrivingDistanceNotFoundException = Class(Exception);

implementation


constructor TDrivingDistanceService.Create; 
begin
end;

destructor TDrivingDistanceService.Destroy;
begin
end;

function TDrivingDistanceService.DrivingDistance(from: TLatLng; destination: TLatLng): Kilometers;
var 
  Protocol, Domain, Path, PathParams, Url,Content : String;
  Data: TJSONData;
  DistanceData: TJSONData;
begin
  try
    Protocol := 'http://';
    Domain := 'router.project-osrm.org';
    Path := '/route/v1/driving/';
    PathParams := ''+Format(from)+';'+Format(destination);

    // Concatenate the different components to form the complete URL
    URL := Protocol + Domain + Path + PathParams;
    Content := TFPCustomHTTPClient.SimpleGet(URL);
    Data := GetJSON(Content);
    DistanceData := Data.FindPath('routes[0].distance');

    if DistanceData = Nil then raise EDrivingDistanceNotFoundException.Create('Can not find driving distance.');

    DrivingDistance := DistanceData.AsFloat / 1000;
  finally
    FreeAndNil(Data);
  end;
end;

end.