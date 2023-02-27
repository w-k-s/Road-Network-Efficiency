unit LatLng;

{$mode objfpc}{$H+}

interface

uses 
  Types, SysUtils, StrUtils;

type 
  TLatLng = record
    Latitude: Real;
    Longitude: Real;
  end;
  EInvalidLatLng = Class(Exception);

  Kilometers = real;

function LatLngFromStr(s: String): TLatLng;
function AbsoluteDistance(aFrom: TLatLng; aTo: TLatLng): Kilometers;

implementation

function LatLngFromStr(s: String): TLatLng;
var 
  Tokens: TStringDynArray;
begin
  Tokens := s.Split(',');
  with Result do begin
    try
      Latitude := StrToFloat(Tokens[0]);
      Longitude := StrToFloat(Tokens[1]);
    except
      on E: Exception do raise EInvalidLatLng.Create('"'+s+'" is not a valid LatLng. A LatLng should be two decimals separated by a comma e.g. "12.32,34.56"');
    end;
  end;
end;

function AbsoluteDistance(aFrom: TLatLng; aTo: TLatLng): Kilometers;
var
  xDisplacement : real;
  yDisplacement : real;
  AbsDistance : Kilometers;
begin
  xDisplacement := Abs(aFrom.Latitude - aTo.Latitude);
  yDisplacement := Abs(aFrom.Longitude - aTo.Longitude);
  {Each degree of lat/lng is rougly 111km}
  AbsDistance := 111 * (xDisplacement + yDisplacement);
end;

end.