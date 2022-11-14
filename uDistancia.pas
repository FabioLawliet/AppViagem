unit uDistancia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TfDistancia = class(TForm)
    imgFundo: TImage;
    layOrigem: TLayout;
    Label4: TLabel;
    Rectangle2: TRectangle;
    edtOrigem: TEdit;
    LayDestino: TLayout;
    Label1: TLabel;
    Rectangle1: TRectangle;
    edtDestino: TEdit;
    RecCalcular: TRectangle;
    Label3: TLabel;
    RecMenuPesquisa: TRectangle;
    btnMenu: TSpeedButton;
    Label8: TLabel;
    lbDistancia: TLabel;
    lbTempo: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure RecCalcularClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDistancia: TfDistancia;

implementation

uses
  System.JSON;

{$R *.fmx}

procedure TfDistancia.RecCalcularClick(Sender: TObject);
var
  Retorno: TJSONObject;
  Prows : TJsonPair;
  Arrayr: TJsonArray;
  oRows: TJsonObject;
  Arraye: TJsonArray;
  oElementos: TJsonObject;
  oDuracao: TJsonObject;
  oDistancia: TJsonObject;
  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;
begin
  RESTRequest1.Resource := 'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyBifc4bw_lVPmqW467-B-YfrYCa3fxcGIo';
  RESTRequest1.Params.AddUrlSegment('origem', edtOrigem.Text);
  RESTRequest1.params.AddUrlSegment('destino', edtDestino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if (retorno.GetValue('status').Value <> 'OK') then
  begin
    showMessage('Ocorreu um erro ao calcular a viagem!');
    Exit;
  end;

  prows      := retorno.Get('rows');
  arrayr     := prows.JSONValue as TJSONArray;
  orows      := arrayr.Items[0] as TJSONObject;
  arraye     := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao   := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  lbDistancia.Text := 'Distância: ' + distancia_str;
  lbTempo.Text     := 'Tempo: ' + duracao_str;
end;

end.
