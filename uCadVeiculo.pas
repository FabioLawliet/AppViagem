unit uCadVeiculo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.EditBox,
  FMX.NumberBox, uDataModule;

type
  TVeiculo = record
    id: integer;
    descricao: string;
    placa: string;
    capacTanque: currency;
    mediacombustivel: currency;
    tipocombustivel: string;
    valorCombustivel: currency;

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
    Layout1: TLayout;
    Z: TLabel;
    Rectangle3: TRectangle;
    nbValorCombustivel: TNumberBox;
    procedure RecConfirmarUserClick(Sender: TObject);
    procedure nbMediaConsumoChange(Sender: TObject);
    procedure LimpaCampos;
    procedure FormShow(Sender: TObject);
    procedure nbCapacidadeTanqueChange(Sender: TObject);
    procedure nbValorCombustivelChange(Sender: TObject);
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
  if (Veiculo.id > 0) then
  begin
    edtDescVeiculo.text      := veiculo.descricao;
    edtPlaca.text            := veiculo.placa;
    nbCapacidadeTanque.Value := veiculo.capacTanque;
    nbMediaConsumo.Value     := veiculo.mediacombustivel;
    rbGasolina.IsChecked     := (veiculo.tipocombustivel = 'G');
    rbAlcool.IsChecked       := (veiculo.tipocombustivel = 'A');
    rbDiesel.IsChecked       := (veiculo.tipocombustivel = 'D');
    nbValorCombustivel.Value := veiculo.valorCombustivel;
  end
  else
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
  nbValorCombustivel.Value := 0;
end;

procedure TfCadVeiculo.nbCapacidadeTanqueChange(Sender: TObject);
begin
  nbCapacidadeTanque.Value := StrToFloat(nbCapacidadeTanque.Text);
end;

procedure TfCadVeiculo.nbMediaConsumoChange(Sender: TObject);
begin
  nbMediaConsumo.Value := StrToFloat(nbMediaConsumo.Text);
end;

procedure TfCadVeiculo.nbValorCombustivelChange(Sender: TObject);
begin
  nbValorCombustivel.Value := StrToFloat(nbValorCombustivel.Text);
end;

procedure TfCadVeiculo.RecConfirmarUserClick(Sender: TObject);
begin
  nbMediaConsumo.OnChange(nbMediaConsumo);
  nbMediaConsumo.OnChange(nbCapacidadeTanque);

  if edtDescVeiculo.Text = '' then
  begin
    ShowMessage('Informe uma descric�o do ve�culo!');
    if edtDescVeiculo.CanFocus then
      edtDescVeiculo.SetFocus;
    Exit;
  end;

  if edtPlaca.Text = '' then
  begin
    ShowMessage('Informe a placa do v�iculo!');
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
    ShowMessage('Informe o consumo m�dio do ve�culo!');
    if nbMediaConsumo.CanFocus then
      nbMediaConsumo.SetFocus;
    Exit;
  end;

  dm.QueryVeiculo.Close();
  dm.QueryVeiculo.Open();

  if (veiculo.id > 0) then
  begin
    dm.QueryVeiculo.First;
    while not dm.QueryVeiculo.Eof do
    begin
      if (dm.QueryVeiculoid.AsInteger = veiculo.id) then
      begin
        dm.QueryVeiculo.Edit;
        dm.QueryVeiculo.FieldByName('descricao').AsString          := edtDescVeiculo.Text;
        dm.QueryVeiculo.FieldByName('placa').AsString              := edtPlaca.Text;
        dm.QueryVeiculo.FieldByName('capacidadetanque').AsCurrency := nbCapacidadeTanque.Value;
        dm.QueryVeiculo.FieldByName('mediaconsumo').AsCurrency     := nbMediaConsumo.Value;
        dm.QueryVeiculo.FieldByName('valorcombustivel').AsCurrency := StrToCurr(nbValorCombustivel.Text);

        if rbGasolina.IsChecked then
          dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'G'
        else if rbAlcool.IsChecked then
          dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'A'
        else
          dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'D';

        dm.QueryVeiculo.Post;
        dm.FDConnection.CommitRetaining;

        ShowMessage('Ve�culo editado com sucesso!');
        break;
      end;
      dm.QueryVeiculo.Next;
    end;
  end else
  begin
    dm.QueryVeiculo.Append;
    dm.QueryVeiculo.FieldByName('descricao').AsString          := edtDescVeiculo.Text;
    dm.QueryVeiculo.FieldByName('placa').AsString              := edtPlaca.Text;
    dm.QueryVeiculo.FieldByName('capacidadetanque').AsCurrency := nbCapacidadeTanque.Value;
    dm.QueryVeiculo.FieldByName('mediaconsumo').AsCurrency     := nbMediaConsumo.Value;
    dm.QueryVeiculo.FieldByName('valorcombustivel').AsCurrency := StrToCurr(nbValorCombustivel.Text);

    if rbGasolina.IsChecked then
      dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'G'
    else if rbAlcool.IsChecked then
      dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'A'
    else
      dm.QueryVeiculo.FieldByName('tipoCombustivel').AsString := 'D';

    dm.QueryVeiculo.Post;
    dm.FDConnection.CommitRetaining;

    ShowMessage('Ve�culo cadastrado com sucesso!');
  end;

  LimpaCampos;
  Close;
end;
end.
