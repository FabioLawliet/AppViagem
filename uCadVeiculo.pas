unit uCadVeiculo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.EditBox,
  FMX.NumberBox, uDataModule;

type
  TVeiculo = record
    descricao: string;
    placa: string;
    capacTanque: currency;
    mediacombustivel: currency;
    tipocombustivel: string;

  end;

  TfCadVeiculo = class(TForm)
    Layout12: TLayout;
    Label9: TLabel;
    Rectangle1: TRectangle;
    edtDescVeiculo: TEdit;
    Layout13: TLayout;
    Label10: TLabel;
    Rectangle6: TRectangle;
    edtPlaca: TEdit;
    Layout14: TLayout;
    Label12: TLabel;
    Rectangle7: TRectangle;
    Layout15: TLayout;
    Label14: TLabel;
    GroupBox1: TGroupBox;
    Layout17: TLayout;
    rbGasolina: TRadioButton;
    Layout18: TLayout;
    rbAlcool: TRadioButton;
    Layout19: TLayout;
    rbDiesel: TRadioButton;
    Layout16: TLayout;
    Label15: TLabel;
    Rectangle9: TRectangle;
    Rectangle8: TRectangle;
    Label13: TLabel;
    imgFundo: TImage;
    Rectangle2: TRectangle;
    LayConfirmar: TLayout;
    RecConfirmarUser: TRectangle;
    Label3: TLabel;
    nbMediaConsumo: TNumberBox;
    nbCapacidadeTanque: TNumberBox;
    procedure RecConfirmarUserClick(Sender: TObject);
    procedure nbMediaConsumoChange(Sender: TObject);
    procedure LimpaCampos;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    Veiculo: TVeiculo;
    { Public declarations }
  end;

var
  fCadVeiculo: TfCadVeiculo;

implementation

{$R *.fmx}

procedure TfCadVeiculo.FormShow(Sender: TObject);
begin
  LimpaCampos;
  edtDescVeiculo.SetFocus;
end;

procedure TfCadVeiculo.LimpaCampos;
begin
  edtDescVeiculo.Text := '';
  edtPlaca.Text := '';
  nbMediaConsumo.Value := 0;
  nbCapacidadeTanque.Value := 0;
  rbGasolina.IsChecked := true;
end;

procedure TfCadVeiculo.nbMediaConsumoChange(Sender: TObject);
begin
  TNumberBox(Sender).Value := StrToFloat(TNumberBox(Sender).Text);
end;

procedure TfCadVeiculo.RecConfirmarUserClick(Sender: TObject);
begin
  nbMediaConsumo.OnChange(nbMediaConsumo);
  nbMediaConsumo.OnChange(nbCapacidadeTanque);

  if edtDescVeiculo.Text = '' then
  begin
    ShowMessage('Informe uma descricão do veículo!');
    if edtDescVeiculo.CanFocus then
      edtDescVeiculo.SetFocus;
    Exit;
  end;

  if edtPlaca.Text = '' then
  begin
    ShowMessage('Informe a placa do véiculo!');
    if edtPlaca.CanFocus then
      edtPlaca.SetFocus;
    Exit;
  end;

  if (nbCapacidadeTanque.Value <= 0) then
  begin
    ShowMessage('Informe a capacidade do tanque!');
    if nbCapacidadeTanque.CanFocus then
      nbCapacidadeTanque.SetFocus;
    Exit;
  end;

  if (nbMediaConsumo.Value <= 0) then
  begin
    ShowMessage('Informe o consumo médio do veículo!');
    if nbMediaConsumo.CanFocus then
      nbMediaConsumo.SetFocus;
    Exit;
  end;

  dm.QueryVeiculo.Close();
  dm.QueryVeiculo.Open();

  dm.QueryVeiculo.Append;
  dm.QueryVeiculo.FieldByName('descricao').AsString := edtDescVeiculo.Text;
  dm.QueryVeiculo.FieldByName('placa').AsString := edtPlaca.Text;
  dm.QueryVeiculo.FieldByName('capacidadetanque').AsCurrency := nbCapacidadeTanque.Value;
  dm.QueryVeiculo.FieldByName('mediaconsumo').AsCurrency := nbMediaConsumo.Value;

  if rbGasolina.IsChecked then
    dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'G'
  else if rbAlcool.IsChecked then
    dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'A'
  else
    dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'D';

  dm.QueryVeiculo.Post;
  dm.FDConnection.CommitRetaining;

  ShowMessage('Veículo cadastrado com sucesso!');
  Close;
end;
end.
