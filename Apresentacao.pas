unit Apresentacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.TabControl, System.JSON, UOpenURL, FMX.Controls.Presentation;

type
  TfApresentacao = class(TForm)
    ApresenTabControl: TTabControl;
    ApresenTabItem01: TTabItem;
    ApresenTabItem02: TTabItem;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btnAtualizar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure OnFinishUpdate(Sender: TObject);
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

procedure TfApresentacao.btnAtualizarClick(Sender: TObject);
var
  url: string;
begin
{$IFDEF ANDROID}
  url := 'https://drive.google.com/file/d/1sYlZPp4rOruUWEGEPi6ztHla1hZ8JbaX/view?usp=sharing';
{$ELSE}
  url := 'https://drive.google.com/file/d/1sYlZPp4rOruUWEGEPi6ztHla1hZ8JbaX/view?usp=sharing';
{$ENDIF}
  OpenURL(url, False);
  Application.Terminate;
end;

procedure TfApresentacao.FormCreate(Sender: TObject);
begin
  FVersaoApp    := '1.0';
  FVersaoServer := '0.0';
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
      sleep(2000);
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

procedure TfApresentacao.OnFinishUpdate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    ShowMessage(Exception(TThread(Sender).FatalException).Message);
    Exit;
  end;
  if (FVersaoApp < FVersaoServer) then
  begin
    ApresenTabControl.TabIndex := ApresenTabItem02.Index;
  end;
end;



end.
