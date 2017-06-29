unit TestClass1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,GeneralProcedures,
  StdCtrls,COntnrs;

type
  TTestClass1FRM = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    HawbTable:TTableValues;
  end;

var
  TestClass1FRM: TTestClass1FRM;

implementation

{$R *.DFM}

procedure TTestClass1FRM.Button1Click(Sender: TObject);
Var
        TagRecord:TTagRecord;
        I:Integer;

begin
HawbTable:=TTableValues.Create;
HawbTable.AddNode('tag03','03','fieldname3',True);
HawbTable.AddNode('tag01','01','fieldname1',True);
HawbTable.AddNode('tag05','05','fieldname22',True);
HawbTable.AddNode('tag02','02','fieldname2',True);


If HawbTable.FindNode('tag02',TagRecord)then
        ShowMessage('Find'+ TagRecord.TableName);
If HawbTable.FindNode('tag07',TagRecord) then
        ShowMessage(TagRecord.TagName);


HawbTable.GoFirstNode;
while HawbTable.GetNextNode(TagRecord) do begin
        ShowMessage('Loop: '+TagRecord.TableName);
end;

HawbTable.UpdateValue('tag02','ff2222');
If HawbTable.FindNode('ag02',TagRecord) then
        ShowMessage(TagRecord.TagName);


HawbTable.Destroy;

end;

procedure TTestClass1FRM.Button2Click(Sender: TObject);
Var
        OB:TObjectList;
        Si:TStackItem;
        Count:integer;
begin
        //ShowMessage(TStackItem(ob.Items[ob.Count-1]).State );

        OB:=TObjectList.Create(true);
        ob.Add(TStackItem.Create('1',itHawb));
        ob.Add(TStackItem.Create('3',itHawb));
        ob.Add(TStackItem.Create('2',itMawb));

        SHowMessage('count'+IntToStr(ob.Count));
        si:=ob.last;
        SHowMessage('last:'+si.State);

        ob.delete(ob.Count-1);

        ob.Add(TStackItem.Create('7',itHawb));
        ob.Add(TStackItem.Create('8',ItMawb));

        si:=TStackITem(ob.Last);

        ShowMessage('last after:'+si.State);
        ob.delete(ob.Count-1);
        si:=TStackITem(ob.Last);
        ShowMessage('last after after:'+si.State);

        ob.Free;


end;

end.
