program AppViagem;
uses
  System.StartUpCopy,
  FMX.Forms,
  Apresentacao in 'Apresentacao.pas' {fApresentacao},
  UOpenURL in 'UOpenURL.pas',
  uDataModule in 'uDataModule.pas' {dm: TDataModule},
  uMapView in 'uMapView.pas' {fMapView},
  uDistancia in 'uDistancia.pas' {fDistancia},
  uCadVeiculo in 'uCadVeiculo.pas' {fCadVeiculo};

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TfApresentacao, fApresentacao);
  Application.Run;
end.
