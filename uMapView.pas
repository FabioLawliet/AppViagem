unit uMapView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, System.Sensors,
  System.Sensors.Components, FMX.Maps, FMX.Layouts;

type
  TfMapView = class(TForm)
    imgFundo: TImage;
    MapView1: TMapView;
    LocationSensor1: TLocationSensor;
    Switch1: TSwitch;
    Layout1: TLayout;
    RecMenuPesquisa: TRectangle;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMapView: TfMapView;

implementation

uses System.Permissions
{$IFDEF ANDROID}
	, Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
	;
{$R *.fmx}

procedure TfMapView.FormCreate(Sender: TObject);
var
  vPosition: TMapCoordinate;
begin
  MapView1.MapType  := TMapType.Normal;
  MapView1.Location := TMapCoordinate.Create(-24.961742843186105, -53.50712288237702);
  MapView1.Zoom := 15;
end;

procedure TfMapView.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  MyMarker: TMapMarkerDescriptor;
  Position: TMapCoordinate;
begin
   MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude, NewLocation.Longitude);
   Position.Latitude := NewLocation.Latitude;
   Position.Longitude := NewLocation.Longitude;
   MyMarker := TMapMarkerDescriptor.Create(Position, 'Estou aqui');
   MyMarker.Draggable := true;
   MyMarker.Visible := true;
   MyMarker.Snippet := 'Eu';
   MapView1.AddMarker(MyMarker);
end;

procedure TfMapView.Switch1Click(Sender: TObject);
{$IFDEF ANDROID}
var
  APermissaoGPS: String;
{$ENDIF}
begin
{$IFDEF ANDROID}
  APermissaoGPS := JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  PermissionsService.RequestPermissions([APermissaoGPS],
      procedure(const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>)
      begin
        if (Length(AGrantResults) = 1) and
          (AGrantResults[0] = TPermissionStatus.Granted) then
          LocationSensor1.Active := True
        else
          LocationSensor1.Active := False;
      end);
{$ENDIF}
end;

end.
