unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, IOUtils;

type
  Tdm = class(TDataModule)
    QueryPessoa: TFDQuery;
    QueryPessoaid: TFDAutoIncField;
    QueryPessoanome: TStringField;
    QueryPessoacpf: TStringField;
    QueryPessoacelular: TStringField;
    QueryPessoacep: TStringField;
    QueryPessoaendereco: TStringField;
    QueryPessoacidade: TStringField;
    QueryPessoauf: TStringField;
    QueryPessoabairro: TStringField;
    QueryPessoaemail: TStringField;
    QueryPessoasenha: TStringField;
    QueryPessoaimg_usuario: TBlobField;
    FDConnection: TFDConnection;
    QueryVeiculo: TFDQuery;
    QueryVeiculoid: TFDAutoIncField;
    QueryVeiculodescricao: TStringField;
    QueryVeiculoPlaca: TStringField;
    QueryVeiculotipocombustivel: TStringField;
    QueryVeiculocapacidadetanque: TCurrencyField;
    QueryVeiculomediaconsumo: TCurrencyField;
    procedure FDConnectionAfterConnect(Sender: TObject);
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.FDConnectionAfterConnect(Sender: TObject);
const
  cSQLCreatePessoa =
  'create table IF NOT EXISTS pessoa( 	    	    ' +
  'id integer not null primary key autoincrement, ' +
  'nome varchar(40),                              ' +
  'cpf varchar(11),                               ' +
  'celular varchar(13),                           ' +
  'cep varchar(10),                               ' +
  'endereco varchar(60),                          ' +
  'cidade varchar(60),                            ' +
  'uf char(2),                                    ' +
  'bairro varchar(60),                            ' +
  'email varchar(60),                             ' +
  'senha varchar(40),                             ' +
  'img_usuario blob)                              ';

  cSQLCreateVeiculo =
  'create table IF NOT EXISTS veiculo(            ' +
  'id integer not null primary key autoincrement, ' +
  'descricao varchar(50),                         ' +
  'Placa varchar(6),                              ' +
  'tipocombustivel varchar(1),                    ' +
  'capacidadetanque currency(4,2),                ' +
  'mediaconsumo currency(4,2))                    ';
begin
  FDConnection.ExecSQL(cSQLCreatePessoa);
  FDConnection.ExecSQL(cSQLCreateVeiculo);
end;

procedure Tdm.FDConnectionBeforeConnect(Sender: TObject);
var
  strPath: String;
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'RouteApp.db');
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('C:\Users\Fábio\Documents\Embarcadero\Studio\Projects\AppViagem\database','RouteApp.db');
  {$ENDIF}
  FDConnection.Params.Values['UseUnicode'] := 'False';
  FDConnection.Params.Values['DataBase'] := strPath;
end;

end.
