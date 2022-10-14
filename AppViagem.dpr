program AppViagem;

uses
  System.StartUpCopy,
  FMX.Forms,
  Apresentacao in 'Apresentacao.pas' {fApresentacao},
  UOpenURL in 'UOpenURL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfApresentacao, fApresentacao);
  Application.Run;
end.
