unit MainTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fcButton, fcImgBtn, fcShapeBtn, fcLabel, Buttons, ExtCtrls, Db,
  DBAccess, IBC, MemDS;

type
  TMainTestFRM = class(TForm)
    Panel1: TPanel;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    Panel5: TPanel;
    fcLabel1: TfcLabel;
    Panel2: TPanel;
    RReadFileBTN: TfcShapeBtn;
    CabConnection: TIBCConnection;
    ParameterSQL: TIBCQuery;
    ParameterSQLPARAMETER_ID: TStringField;
    ParameterSQLINT_1: TIntegerField;
    ParameterSQLINT_2: TIntegerField;
    ParameterSQLSTR_1: TStringField;
    ParameterSQLSTR_2: TStringField;
    ParameterSQLSTR_3: TStringField;
    ParameterSQLSTR_4: TStringField;
    ParameterSQLNUM_1: TFloatField;
    ParameterSQLNUM_2: TFloatField;
    ParameterSQLDATE_1: TDateTimeField;
    ParameterSQLDATE_2: TDateTimeField;
    ParameterSQLSTR_5: TStringField;
    Button2: TButton;
    ViewDataBTN: TfcShapeBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RReadFileBTNClick(Sender: TObject);
    procedure ViewDataBTNClick(Sender: TObject);
  private
    { Private declarations }
        procedure ConnectToDatabase;
        Function OpenFile(Const InFileName:String;Var InFile:TextFile):Boolean;
  public
        Function GetValueFromSystemTable(Const TheKey,TheDescription:String):String;
    { Public declarations }

  end;

var
  MainTestFRM: TMainTestFRM;

implementation

uses Unit1, TestClass1, ReadFIle, ViewTables;

{$R *.DFM}
Function TMainTestFRM.OpenFile(Const InFileName:String;Var InFile:TextFile):Boolean;
Var
        AppDirectory:String;
        ParamFIleName:String;
        TheFileName:String;
Begin

AppDirectory:= ExtractFilePath(Application.ExeName);
//ParamFileName:=APpDirectory+'DatabaseParams.txt';
ParamFileName:=APpDirectory+InFileName;

Result:=False;

    {$I-}
    TheFileName:= ParamFileName;
    AssignFile(InFile,TheFileName);
    Reset(InFile);
    {$I+}
    if IOResult <> 0 then begin
        Result:=false;
        //raise exception.create('Cannot Open Database Parameter file:'+ThefileName);
    end else begin
        Result:=True;
    end;


End;

procedure TMainTestFRM.ConnectToDatabase;
Var
        FBClientPath:String;
        InFile:TextFile;
        LIne:String;
        ServerIP,DatabasePath:String;
        TextArray : Array [1..3] of String;
        I:Integer;
begin

        If not OpenFile('DatabaseParams.txt',InFile) then begin
                raise exception.create('Cannot open file');
        end;
        I:=0;
        while (not Eof(Infile) and (I<2) )do begin
                Inc(i);
                Readln(InFile,TextArray[i]);
        end;
        If (I<2) then begin
                ShowMEssage('File must have two lines. First line for server ip, second line for Full database file');
        end else begin
                ServerIP:=TextArray[1];
                DatabasePath:=TextArray[2];
        end;
        CloseFile(Infile);

        CabConnection.Server:=ServerIP;
        CabConnection.database:=DatabasePath;

        FbClientPath:=ExtractFileDir( ExtractFilePath(Application.EXEName)  );
        FbClientPath:=FBClientPath+'\gds32.dll';
        //ShowMessage(FbClientPath);
        CabConnection.ClientLibrary := FBClientPath;
        If CabConnection.connected then
                CabConnection.Disconnect;

        CabConnection.Connect;

End;



procedure TMainTestFRM.Button1Click(Sender: TObject);
begin
//Form1.ShowModal;
end;

procedure TMainTestFRM.Button2Click(Sender: TObject);
begin
TestClass1FRM.SHowModal;
end;

procedure TMainTestFRM.FormCreate(Sender: TObject);
begin
ConnectToDatabase;
end;

procedure TMainTestFRM.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TMainTestFRM.Button4Click(Sender: TObject);
Var
        Dir:String;
begin
        Dir:= SELF.GetValueFromSystemTable('F_4', 'Default Dirictory');
        ShowMEssage(Dir);

end;

procedure TMainTestFRM.RReadFileBTNClick(Sender: TObject);
begin
ReadFIleFRM.ShowModal;
end;

procedure TMainTestFRM.ViewDataBTNClick(Sender: TObject);
begin
ViewTableFRM.ShowModal;

end;
Function TMainTestFRM.GetValueFromSystemTable(Const TheKey,TheDescription:String):String;
Var
   TheQuery:TIBCQuery;
Begin


   TheQuery:=MainTestFRM.ParameterSQL;
   TheQUery.ParamByName('TheKey').Value:=TheKey;

   TheQuery.close;
   If TheQuery.Prepared then TheQuery.Prepare;
   TheQUery.ParamByName('TheKey').Value:=TheKey;
   TheQuery.Open;
   If TheQuery.IsEmpty Then begin
//        raise exception.create('Enter into System parameters (field STR_4) the record: '+TheKey+' for '+TheDescription);
         ShowMessage('Enter into System parameters -> UNIX TRANSFER (***STR_4***) the record: '+TheKey+' for '+TheDescription);
         Result:='';
   end else begin
        TheQuery.First;
        Result:=Trim(TheQuery.fieldbyName('STR_4').AsString);
        TheQuery.Close;
   end;


End;


end.
