unit RoadNetworkEfficiency;

{$mode objfpc}{$H+}

interface

uses 
  Types, SysUtils, StrUtils;

type 
  TRoadNetworkEfficiency = real;
  ESameStartingPointAndDestinationException = Class(Exception);

function RoadNetworkEfficiency(
	drivingDistance: Kilometers;
	absoluteValueDistance: Kilometers
): TRoadNetworkEfficiency;

implementation

function RoadNetworkEfficiency(
	drivingDistance: Kilometers;
	absoluteValueDistance: Kilometers
): TRoadNetworkEfficiency;
var
	Efficiency : TRoadNetworkEfficiency;
begin
	if absoluteValueDistance = 0 then raise ESameStartingPointAndDestinationException.Create('Can not calculate efficiency when starting point and destination are the same');
	Efficiency := drivingDistance/absoluteValueDistance
end;

end.