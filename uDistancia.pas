unit uDistancia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.EditBox,
  FMX.NumberBox, uDataModule;

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
    Label8: TLabel;
    lbDistancia: TLabel;
    lbTempo: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Layout1: TLayout;
    Label2: TLabel;
    Rectangle3: TRectangle;
    nbCodVeiculo: TNumberBox;
    lbGasto: TLabel;
    procedure FormShow(Sender: TObject);
    procedure RecCalcularClick(Sender: TObject);
    procedure nbCodVeiculoExit(Sender: TObject);
    procedure nbCodVeiculoChange(Sender: TObject);
  private
    { Private declarations }
    function getValorGasto(ADistancia: Integer):   string;
  public
    { Public declarations }
  end;

var
  fDistancia: TfDistancia;

implementation

uses
  System.JSON;

{$R *.fmx}

procedure TfDistancia.FormShow(Sender: TObject);
begin
  edtOrigem.Text     := '';
  edtDestino.Text    := '';
  nbCodVeiculo.Value := 0;
  lbDistancia.Text   := 'Distância: ';
  lbTempo.Text       := 'Tempo: ';
  lbGasto.Text       := 'Estim. de Gasto: ';
end;

function TfDistancia.getValorGasto(ADistancia: integer): string;
var
  num: currency;
begin
  dm.QueryVeiculo.First;
  while not dm.QueryVeiculo.Eof do
  begin
    if (dm.QueryVeiculoid.AsInteger = nbCodVeiculo.Value) then
      result := FormatFloat('###,###,##0.00', (ADistancia / dm.QueryVeiculomediaconsumo.AsCurrency) * dm.QueryVeiculovalorcombustivel.AsCurrency);

    dm.QueryVeiculo.Next;
  end;
  dm.QueryVeiculo.First;
end;

procedure TfDistancia.nbCodVeiculoChange(Sender: TObject);
begin
  nbCodVeiculo.Value := StrToInt(nbCodVeiculo.Text);
end;

procedure TfDistancia.nbCodVeiculoExit(Sender: TObject);
var
  Encontrou: boolean;
begin
  if (nbCodVeiculo.Value = 0) then
    Exit;

  dm.QueryVeiculo.First;
  while not dm.QueryVeiculo.Eof do
  begin
    if (dm.QueryVeiculoid.AsInteger = nbCodVeiculo.Value) then
      Encontrou := True;

    dm.QueryVeiculo.Next;
  end;
  dm.QueryVeiculo.First;

  if not Encontrou then
  begin
    ShowMessage('Código do veículo não encontrado!');

    if nbCodVeiculo.CanFocus then
      nbCodVeiculo.SetFocus;
  end;
end;

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
  Encontrou: boolean;
begin
  Encontrou := false;

  dm.QueryVeiculo.First;
  while not dm.QueryVeiculo.Eof do
  begin
    if (dm.QueryVeiculoid.AsInteger = StrToInt(nbCodVeiculo.Text)) then
    begin
      Encontrou := True;
      break;
    end;

    dm.QueryVeiculo.Next;
  end;
  dm.QueryVeiculo.First;

  if not Encontrou then
  begin
    ShowMessage('O veículo de código ' + nbCodVeiculo.Text + ' não está cadastrado!' );
  end;

  if edtOrigem.Text = '' then
  begin
    ShowMessage('Não foi informada a cidade de origem!');
    edtOrigem.SetFocus;
    Exit;
  end;

  if edtDestino.Text = '' then
  begin
    ShowMessage('Não foi informada a cidade de destino!');
    edtDestino.SetFocus;
    Exit;
  end;

  RESTRequest1.Resource := 'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyAwjnJzF57fQddVy_dL8yTC01Zw7ufVuY8';
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
  distancia_int := Trunc(odistancia.GetValue('value').Value.ToInteger/1000);

  duracao_str := oduracao.GetValue('text').Value;
  //duracao_int := oduracao.GetValue('value').Value.ToInteger;

  lbDistancia.Text := 'Distância: ' + distancia_str;
  lbTempo.Text     := 'Tempo: ' + duracao_str;

  if (getValorGasto(distancia_int) <> '') then
    lbGasto.Text     := 'Estim. de Gasto: R$ ' + getValorGasto(distancia_int)
  else
    lbGasto.Text     := 'Estim. de Gasto: Veículo não encontrado!';
end;

end.
