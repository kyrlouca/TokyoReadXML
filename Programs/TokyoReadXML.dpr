program TokyoReadXML;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  X_readFile in 'X_readFile.pas' {X_readFileFRM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TX_readFileFRM, X_readFileFRM);
  Application.CreateForm(TX_readFileFRM, X_readFileFRM);
  Application.Run;
end.
