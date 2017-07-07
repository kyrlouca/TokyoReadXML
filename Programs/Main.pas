unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DBAccess, IBC, Data.DB,
  MemDS;

type
  TmainFRm = class(TForm)
    Button1: TButton;
    IBCConnection1: TIBCConnection;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  function ConvertFloat(StrNum:String):double;
  function ConvertDecimalF(StrNum:String):double;

  public
    { Public declarations }
  end;

var
  mainFRm: TmainFRm;

implementation

{$R *.dfm}

uses X_readFile;

procedure TmainFRm.Button2Click(Sender: TObject);
var
   num:Double;
begin
 FormatSettings.DecimalSeparator :='.';
 FormatSettings.ThousandSeparator :=',';
//  num:=ConvertFloat('322.22');
  num:=ConvertDecimalF('322.22');
  showMessage(FloatToStr(num));

end;

function TmainFRm.ConvertFloat(StrNum:String):double;
var
  fs : TFormatSettings;
  ds:char;
  temp:string;
begin
   fs := TFormatSettings.Create();
   ds:= fs.DecimalSeparator;
   if (ds=',') then begin
      Temp := StringReplace(StrNum, ',', '', [rfReplaceAll]);
      Temp := StringReplace(Temp, '.',',', [rfReplaceAll]);
      Result := StrToFloatDef(temp,0);
   end else begin
     result:=StrToFloatDef(strNum,0);
   end;


end;

function TmainFRm.ConvertDecimalF(StrNum:String):double;
var
  fs : TFormatSettings;
begin
//   formatSettings.DecimalSeparator:='$';
//   ShowMessage(System.SysUtils.FormatSettings.DecimalSeparator);
//   exit;

   fs := TFormatSettings.Create();
   fs.DecimalSeparator:='.';
   fs.ThousandSeparator:=',';
   try
     result:=StrToFloat(StrNum,fs);
   except
     result:=0;
   end;

 end;



procedure TmainFRm.Button1Click(Sender: TObject);
begin
  X_readFileFRM.ShowModal;
end;

end.
