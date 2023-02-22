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

function LatLngFromStr(s: String): TLatLng;

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

end.