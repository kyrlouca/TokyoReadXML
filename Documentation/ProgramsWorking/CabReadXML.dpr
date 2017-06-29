program CabReadXML;

{%ToDo 'CabReadXML.todo'}

uses
  Forms,
  MainTest in 'MainTest.pas' {MainTestFRM},
  Unit1 in 'Unit1.pas' {Form1},
  I_readHawbFileNewVersion in 'I_readHawbFileNewVersion.pas' {I_ReadManifestFileNewVersionFRM},
  General in 'General.pas' {GeneralFRM},
  GeneralProcedures in 'GeneralProcedures.pas',
  TestClass1 in 'TestClass1.pas' {TestClass1FRM},
  ReadFIle in '..\..\CabEx\Programs\ReadFIle.pas' {ReadFileFRM},
  ViewTables in '..\..\CabEx\Programs\ViewTables.pas' {ViewTableFRM};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainTestFRM, MainTestFRM);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TI_ReadManifestFileNewVersionFRM, I_ReadManifestFileNewVersionFRM);
  Application.CreateForm(TGeneralFRM, GeneralFRM);
  Application.CreateForm(TTestClass1FRM, TestClass1FRM);
  Application.CreateForm(TReadFileFRM, ReadFileFRM);
  Application.CreateForm(TViewTableFRM, ViewTableFRM);
  Application.Run;
end.
