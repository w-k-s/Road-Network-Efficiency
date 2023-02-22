program RoadNetworkEfficiency;

{$mode objfpc}{$H+}
uses SysUtils, LatLng;

type 
	Arguments = record
		FromLatLng: string;
		ToLatLng: string;
	end;  
	PArguments = ^Arguments;
	EInvalidArguments = Class(Exception);

procedure WriteHelp;
begin
	WriteLn('Road Network Efficiency');
	WriteLn('-----------------------');
	WriteLn('Calculates how tortuous the road from one latlng is to another');
	WriteLn('');
	WriteLn('USAGE:');
	WriteLn('./RoadNetworkEfficiency <options>');
	WriteLn('');
	WriteLn('OPTIONS');
	WriteLn('-h				: Prints help');
	WriteLn('-from [FromLatLng]		: Starting Latitude and Longitude');
	WriteLn('-to [ToLatLng]			: Destination Latitutde and Longitude');
end;

procedure ValidateArguments(args: PArguments);
begin
	if args = nil then begin
		raise EInvalidArguments.Create('No arguments supplied');
	end;
	if Length(args^.FromLatLng) = 0 then begin
		raise EInvalidArguments.Create('-from LatLng not set');
	end;
	if Length(args^.ToLatLng) = 0 then begin
		raise EInvalidArguments.Create('-to LatLng not set');
	end;
end;

procedure ParseArguments(args: PArguments);
var
	ShowHelp: Boolean;
	ArgumentName: String;
	ArgumentValue: String;
	Count: Integer;
begin
	ShowHelp := (ParamCount = 0) or ((ParamCount = 1) and (ParamStr(1) = '-h'));
	if ShowHelp then begin
		WriteHelp;
		halt;
	end;
	for Count := 1 to ParamCount do begin
		if pos('-', ParamStr(Count)) = 1 then ArgumentName := ParamStr(Count)
		else begin
			ArgumentValue := ParamStr(Count);
			with args^ do begin
				case (ArgumentName) of
					'-from': FromLatLng := ArgumentValue;
					'-to': ToLatLng := ArgumentValue;
				end;
			end;
		end;
	end;
	ValidateArguments(args);
end;

var 
	args: PArguments;
	
	fromLatLng: TLatLng;
	toLatLng: TLatLng;
begin
	New(args);
	try
		try
			ParseArguments(args);
			fromLatLng := LatLngFromStr(args^.FromLatLng);
			toLatLng := LatLngFromStr(args^.ToLatLng);

			

		except
	    	on E : EInvalidArguments do begin
	    		WriteLn(e.Message);
	    		WriteHelp;
	    	end;
	    	on E : Exception do WriteLn(e.Message);
		end;
	finally
		Dispose(args);
	end;
end.