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
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainFRm: TmainFRm;

implementation

{$R *.dfm}

uses X_readFile;

procedure TmainFRm.Button1Click(Sender: TObject);
begin
  X_readFileFRM.ShowModal;
end;

end.
