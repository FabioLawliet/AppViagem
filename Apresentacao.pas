unit Apresentacao;
interface
uses
  System.SysUtils, System.Types, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.StdCtrls,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.TabControl, System.JSON, UOpenURL, FMX.Controls.Presentation, FMX.Layouts,
  FMX.Objects, FMX.Edit, uDataModule, System.Sensors, System.Sensors.Components,
  FMX.Maps, uMapView, uDistancia, uCadVeiculo, System.Rtti, FMX.Grid.Style,
  FMX.Grid, FMX.ScrollBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Grid, Data.Bind.DBScope, FMX.Dialogs, FMX.VirtualKeyboard,
  System.UITypes, FMX.Platform;
type
  TfApresentacao = class(TForm)
    ApresenTabControl: TTabControl;
    ApresenTabItem01_Atualizar: TTabItem;
    ApresenTabItem02_Login: TTabItem;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Layout1: TLayout;
    imgFundo: TImage;
    LayoutCompleto: TLayout;
    LayLogin: TLayout;
    LayEntrar: TLayout;
    RectEntrar: TRectangle;
    Label11: TLabel;
    LayEmail: TLayout;
    RectLogin: TRectangle;
    edtEmail: TEdit;
    ImgUser: TImage;
    LaySenha: TLayout;
    RectPassword: TRectangle;
    edtSenha: TEdit;
    ImgPassword: TImage;
    Tab02_SenhaEye: TRectangle;
    Tab02_imgCloseEye: TImage;
    Tab02_imgOpenEye: TImage;
    lbCadastreSe: TLabel;
    LayLogo: TLayout;
    Image1: TImage;
    RectAtualizar: TRectangle;
    Label1: TLabel;
    RecAtualizarMaisTarde: TRectangle;
    Label2: TLabel;
    Layout2: TLayout;
    Image2: TImage;
    ApresenTabItem03_CadUsuario: TTabItem;
    VertScrollBox1: TVertScrollBox;
    Layout3: TLayout;
    LayPrincipal: TLayout;
    LayConfirmar: TLayout;
    RecConfirmarUser: TRectangle;
    Label3: TLabel;
    Layout4: TLayout;
    Label4: TLabel;
    Rectangle2: TRectangle;
    Tab03_edtemail: TEdit;
    LayName: TLayout;
    Label5: TLabel;
    Rectangle3: TRectangle;
    Tab03_edtNome: TEdit;
    LayRepetirSenha: TLayout;
    Label6: TLabel;
    Rectangle4: TRectangle;
    Tab03_edtSenha2: TEdit;
    Layout5: TLayout;
    Label7: TLabel;
    Rectangle5: TRectangle;
    Tab03_edtSenha: TEdit;
    Tab03_SenhaEye: TRectangle;
    Tab03_imgCloseEye: TImage;
    Tab03_imgOpenEye: TImage;
    Layout6: TLayout;
    Layout7: TLayout;
    Image3: TImage;
    ApresenTabItem04_TelaPrincipal: TTabItem;
    RecCalcViagem: TRectangle;
    RecSeila: TRectangle;
    RecCadVeiculos: TRectangle;
    RecMenuPesquisa: TRectangle;
    Label8: TLabel;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    ApresenTabItem05_ListaVeiculos: TTabItem;
    Rectangle8: TRectangle;
    Label13: TLabel;
    Layout12: TLayout;
    Label9: TLabel;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Layout13: TLayout;
    RecExcluir: TRectangle;
    btnExcluir: TSpeedButton;
    RecAdicionar: TRectangle;
    btnAdicionar: TSpeedButton;
    RecEditar: TRectangle;
    btnEditar: TSpeedButton;
    ApresenTabItem00_Logo: TTabItem;
    Image7: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RectAtualizarClick(Sender: TObject);
    procedure lbCadastreSeClick(Sender: TObject);
    procedure RecConfirmarUserClick(Sender: TObject);
    procedure Tab03_SenhaEyeClick(Sender: TObject);
    procedure Tab02_SenhaEyeClick(Sender: TObject);
    procedure RectEntrarClick(Sender: TObject);
    procedure RecAtualizarMaisTardeClick(Sender: TObject);
    procedure RecCadVeiculosClick(Sender: TObject);
    procedure RecSeilaClick(Sender: TObject);
    procedure RecCalcViagemClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure ApresenTabControlChange(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnEditarClick(Sender: TObject);
  private
    procedure OnFinishUpdate(Sender: TObject);
    procedure PreencheCadastroVeiculo(Aid: integer);
    function GetVersaoApp: currency;
    { Private declarations }
  public
    FVersaoServer: String;
    FVersaoApp: String;
    { Public declarations }
  end;
var
  fApresentacao: TfApresentacao;
implementation
{$R *.fmx}
procedure TfApresentacao.RecAtualizarMaisTardeClick(Sender: TObject);
begin
  ApresenTabControl.ActiveTab := ApresenTabItem02_login;
end;

procedure TfApresentacao.RecCadVeiculosClick(Sender: TObject);
begin
  ApresenTabControl.ActiveTab := ApresenTabItem05_ListaVeiculos;
end;

procedure TfApresentacao.RecCalcViagemClick(Sender: TObject);
begin
  if not assigned(fDistancia) then
    Application.CreateForm(TfDistancia, fDistancia);

  fDistancia.Show;
end;

procedure TfApresentacao.RecConfirmarUserClick(Sender: TObject);
begin
  if Tab03_edtNome.Text = '' then
  begin
    ShowMessage('Informe um nome!');
    exit;
  end;

  if Tab03_edtemail.Text = '' then
  begin
    ShowMessage('Informe um email!');
    exit;
  end;

  if (Tab03_edtSenha.Text <> Tab03_edtSenha2.Text) then
  begin
    ShowMessage('As senhas informadas não sao iguais!');
    exit;
  end;

  if (Tab03_edtSenha.Text = '') or (Tab03_edtSenha2.Text = '')  then
  begin
    ShowMessage('As uma das senhas está em branco!');
    exit;
  end;

  dm.QueryPessoa.Close();
  dm.QueryPessoa.Open();
  dm.QueryPessoa.Filter := 'email = ' + Tab03_edtemail.Text;
  dm.QueryPessoa.Filtered := True;

  if (dm.QueryPessoa.RecordCount = 0) then
  begin
    dm.QueryPessoa.Append;
    dm.QueryPessoaNome.AsString := Tab03_edtNome.Text;
    dm.QueryPessoaEmail.AsString := Tab03_edtEmail.Text;
    dm.QueryPessoaSenha.AsString := Tab03_edtSenha.Text;
    dm.QueryPessoa.Post;
    dm.FDConnection.CommitRetaining;
  end else
  begin
    ShowMessage('O email ' + Tab03_edtemail.Text + ' já foi cadastrado! Escolha outro e-mail.');
    dm.QueryPessoa.Filtered := False;
    Exit;
  end;

  ShowMessage('Cadastro realizado com sucesso!');
  ApresenTabControl.ActiveTab := ApresenTabItem02_login;
end;

procedure TfApresentacao.RecSeilaClick(Sender: TObject);
begin
  if not assigned(fMapView) then
    Application.CreateForm(TfMapView, fMapView);

  fMapView.Show;
  fMapView.FormStyle := TFormStyle.Normal;
end;

procedure TfApresentacao.RectAtualizarClick(Sender: TObject);
{$IFDEF ANDROID}
var
  url: string;
{$ENDIF}
begin
{$IFDEF ANDROID}
  url := 'https://drive.google.com/file/d/1RXgWgHoOZkJmWF8O1ux2Sp_rKzHMqam6/view?usp=share_link';
  OpenURL(url, False);
  dm.FDConnection.ExecSQL('update versao set versao = ' + FVersaoServer);
  Application.Terminate;
{$ENDIF}
end;
procedure TfApresentacao.RectEntrarClick(Sender: TObject);
const cSql = 'select * from Pessoa where email = :email and senha = :senha';
begin
  dm.QueryPessoa.Close;
  dm.QueryPessoa.SQL.Clear;
  dm.QueryPessoa.SQL.Add(cSQL);
  dm.QueryPessoa.ParamByName('email').AsString := edtEmail.Text;
  dm.QueryPessoa.ParamByName('senha').AsString := edtSenha.Text;
  dm.QueryPessoa.Open();

  if (not dm.QueryPessoa.IsEmpty) then
  begin
    ApresenTabControl.ActiveTab := ApresenTabItem04_TelaPrincipal;
  end else
  begin
    ShowMessage('Email ou senha inválido!');
  end;
end;

procedure TfApresentacao.Tab02_SenhaEyeClick(Sender: TObject);
begin
  if Tab02_imgCloseEye.Visible then
  begin
    Tab02_imgCloseEye.Visible := False;
    Tab02_imgOpenEye.Visible := True;
    edtSenha.Password := False;
  end else
  begin
    Tab02_imgCloseEye.Visible := True;
    Tab02_imgOpenEye.Visible := False;
    edtSenha.Password := True;
  end;
end;

procedure TfApresentacao.Tab03_SenhaEyeClick(Sender: TObject);
begin
  if Tab03_imgCloseEye.Visible then
  begin
    Tab03_imgCloseEye.Visible := False;
    Tab03_imgOpenEye.Visible := True;
    Tab03_edtSenha.Password := False;
    Tab03_edtSenha2.Password := False;
  end else
  begin
    Tab03_imgCloseEye.Visible := True;
    Tab03_imgOpenEye.Visible := False;
    Tab03_edtSenha.Password := True;
    Tab03_edtSenha2.Password := True;
  end;
end;

procedure TfApresentacao.ApresenTabControlChange(Sender: TObject);
begin
  if ApresenTabControl.ActiveTab = ApresenTabItem05_ListaVeiculos then
  begin
    dm.QueryVeiculo.Close;
    dm.QueryVeiculo.Open;
  end;
end;

procedure TfApresentacao.btnAdicionarClick(Sender: TObject);
begin
  if not assigned(fCadVeiculo) then
    Application.CreateForm(TfCadVeiculo, fCadVeiculo);

  fCadVeiculo.Veiculo.id := 0;
  fCadVeiculo.Show;
  fCadVeiculo.FormStyle := TFormStyle.Normal;
end;

procedure TfApresentacao.PreencheCadastroVeiculo(Aid: integer);
const
  cSQL = 'select * from veiculo where id = :id';
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := dm.FDConnection;
  try
    vQuery.SQL.Add(cSQL);
    vQuery.ParamByName('id').AsInteger := Aid;
    vQuery.Open();
    if not vQuery.IsEmpty then
    begin
      fCadVeiculo.Veiculo.id               := vQuery.FieldByName('id').AsInteger;
      fCadVeiculo.Veiculo.descricao        := vQuery.FieldByName('descricao').AsString;
      fCadVeiculo.Veiculo.placa            := vQuery.FieldByName('placa').AsString;
      fCadVeiculo.Veiculo.capacTanque      := vQuery.FieldByName('capacidadetanque').AsCurrency;
      fCadVeiculo.Veiculo.mediacombustivel := vQuery.FieldByName('mediaconsumo').AsCurrency;
      fCadVeiculo.Veiculo.tipocombustivel  := vQuery.FieldByName('tipocombustivel').AsString;
      fCadVeiculo.Veiculo.valorCombustivel := vQuery.FieldByName('valorcombustivel').AsCurrency;
    end;
  finally
    FreeAndNil(vQuery);
  end;
end;

procedure TfApresentacao.btnEditarClick(Sender: TObject);
begin
  if not assigned(fCadVeiculo) then
    Application.CreateForm(TfCadVeiculo, fCadVeiculo);

  PreencheCadastroVeiculo(StrToInt(StringGrid1.Cells[0, StringGrid1.Row]));
  fCadVeiculo.Show;
  fCadVeiculo.FormStyle := TFormStyle.Normal;
end;

procedure TfApresentacao.btnExcluirClick(Sender: TObject);
var
  idVeiculo: integer;
begin
  if dm.QueryVeiculo.recordCount <= 0 then
  begin
    ShowMessage('Não foi selecionado ou não existe veículo para exclusão!');
    exit;
  end;

  idVeiculo := StrToInt(StringGrid1.Cells[0, StringGrid1.Row]);

  dm.QueryVeiculo.First;
  while not dm.QueryVeiculo.Eof do
  begin
    if (dm.QueryVeiculoid.AsInteger = idVeiculo) then
    begin
      dm.QueryVeiculo.Delete;
      ShowMessage('Veículo removido com sucesso!');
      Exit;
    end
    else
      dm.QueryVeiculo.Next;
  end;
  dm.QueryVeiculo.First;
end;

function TfApresentacao.GetVersaoApp: currency;
var
  vQuery: TFDQuery;
begin
  Result := 0;
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := dm.FDConnection;
  try
    vQuery.SQL.Add('select versao from versao');
    vQuery.Open;
    if vQuery.IsEmpty then
      vQuery.Connection.ExecSQL('insert into versao(versao) values (0)')
    else
      Result := vQuery.FieldByName('Versao').AsFloat;
  finally
    FreeAndNil(vQuery);
  end;
end;

procedure TfApresentacao.FormCreate(Sender: TObject);
begin
  FVersaoApp := FloatToStr(GetVersaoApp);
end;

procedure TfApresentacao.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService: IFMXVirtualKeyboardService;
{$ENDIF}
begin
{$IFDEF ANDROID}
    if (Key = vkHardWareBack) then
    begin
      TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

      if (FService <> nil) and (TVirtualKeyBoardState.Visible in FService.VirtualKeyBoardState) then
      begin
        //Teclado virtual aberto.
      end else
      begin
        if (ApresenTabControl.ActiveTab = ApresenTabItem05_ListaVeiculos) then
        begin
          Key := 0;
          ApresenTabControl.ActiveTab := ApresenTabItem04_TelaPrincipal;
        end;
      end;
    end;
{$ENDIF}
end;

procedure TfApresentacao.FormShow(Sender: TObject);
var
  t: TThread;
begin
    t := TThread.CreateAnonymousThread(
    procedure
    var
      JsonObj: TJSONObject;
    begin
      sleep(1000);
      try
        RESTRequest1.Execute;
      except
          on Ex: Exception do
          begin
            raise Exception.Create('Erro ao acessar o servidor. ' + ex.Message);
          end;
      end;
      try
        JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
          (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;
        FVersaoServer := TJSONObject(JsonObj).GetValue('Versao').Value;
      finally
        JsonObj.disposeof;
      end;
    end);
    t.OnTerminate := OnFinishUpdate;
    t.Start;
end;

procedure TfApresentacao.Image4Click(Sender: TObject);
begin
  ApresenTabControl.ActiveTab := ApresenTabItem05_ListaVeiculos;
end;

procedure TfApresentacao.lbCadastreSeClick(Sender: TObject);
begin
  ApresenTabControl.ActiveTab := ApresenTabItem03_CadUsuario;
end;

procedure TfApresentacao.OnFinishUpdate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    ShowMessage(Exception(TThread(Sender).FatalException).Message);
    Exit;
  end;

  if (FVersaoApp <> FVersaoServer) then
    ApresenTabControl.ActiveTab := ApresenTabItem01_Atualizar
  else
    ApresenTabControl.ActiveTab := ApresenTabItem02_Login;
end;
end.
