program TokyoReadXML;

uses
  Vcl.Forms,
  Main in 'Main.pas' {mainFRm},
  X_readFile in 'X_readFile.pas' {X_readFileFRM},
  G_kyriacosTypes in 'G_kyriacosTypes.pas',
  G_KyrSQL in 'G_KyrSQL.pas',
  G_generalProcs in 'G_generalProcs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TmainFRm, mainFRm);
  Application.CreateForm(TX_readFileFRM, X_readFileFRM);
  Application.CreateForm(TX_readFileFRM, X_readFileFRM);
  Application.Run;
end.
