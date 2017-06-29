unit X_readFile;
//XMLNode has Childnodes , and you can use Node.Childnodes[0] or Node.ChildNodes['Hdr] to get child node
//XMLNodeList is the list itself. it has attribute list.count and list['arrive'] to get the node
// childnodes will create a node if NOT found . FindNode will result to null and chekc assign
//if Assigned(list['data'])
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc;

type
TMawbRec =Record
  MawbId:String;
  ArrivalDate:String;
End;
THawbRec =Record
  HawbId:String;
  ArrivalDate:String;
End;

  TX_readFileFRM = class(TForm)
    Button1: TButton;
    XMLDocument1: TXMLDocument;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function ReadFile(Const FileName:String) :boolean;
  function getOneMawb(aMawb:IXMLNode):boolean;
  public
    { Public declarations }
  end;

var
  X_readFileFRM: TX_readFileFRM;

implementation

{$R *.dfm}

procedure TX_readFileFRM.Button1Click(Sender: TObject);
begin
  ReadFile('C:\Data\DelphiProjects\testX1\files\Real3.xml');

end;

function TX_readFileFRM.ReadFile(Const FileName:String) :Boolean;
var
  Doc: IXMLDocument;
  Data: IXMLNode;
  Movements, Mawbs,Hawbs :IXMLNodeList;
  aMovement,aMawb,aHawb:ixmlnODE;
  I: Integer;
  j:Integer;
  MawbRec:TmawbRec;

begin
  result:=true;
  showMessage(Filename);
  Doc := LoadXMLDocument(FileName);
  Data := Doc.DocumentElement;

 Movements:=Data.ChildNodes['Dtls'].ChildNodes['Entries'].ChildNodes['Entry'].childNOdes['Mvmts'].ChildNodes;
// Mawbs:=Data.ChildNodes['Dtls'].ChildNodes['Entries'].ChildNodes['Entry'].childNOdes['Mvmts'].ChildNodes['Mvmt'].ChildNodes['TDOCs'].ChildNodes;

 if Movements.Count <1 then begin
  result:=False;
  exit;
 end;
 ShowMessage(Movements[0].ChildNodes['MvmtNo'].Text);

 Mawbs:=Movements[0].ChildNodes['TDOCs'].ChildNodes; //only one movement is sent
  if Mawbs.Count <1 then begin
    result:=False;
    exit;
 end;
ShowMessage(IntToStr(Mawbs.Count));


  for I := 0 to Mawbs.Count-1 do  begin
    aMawb := Mawbs[i];
    ShowMessage(aMawb.ChildNodes['TDOCNo'].Text);
    getOneMawb(aMawb);

  end;




//   wNode:=mvmt['hdr'];
//  ShowMessage(wNode.LocalName);
//  wNode:=Mvmt['ArrivalDate'];
//  ShowMessage(wNode.Text);
//  ShowMessage(Mvmt['ArrivalDate'].text);
  exit;
  MawbRec.MawbId:= movements['ArrivalData'].Text;


  end;


function TX_readFileFRM.getOneMawb(aMawb:IXMLNode):boolean;
var
  Hawbs :IXMLNodeList;
  aHawb:ixmlnODE;
  j:Integer;
begin
    hawbs:=aMawb.ChildNodes['Shps'].ChildNodes;
    for j:= 0 to hawbs.Count -1 do begin
      Ahawb:=hawbs[j];
        showMessage(Ahawb.ChildNodes['HAWB'].Text);

//        HawbTable.AddNodeWithValue('X_FK_CLEARING_STATE','HawbSQL','FK_CLEARING_STATE','0',FALSE);
//        HawbTable.AddNodeWithValue('X_FK_INVOICE_STATUS','HawbSQL','FK_INVOICE_STATUS','0',FALSE);
//        HawbTable.AddNodeWithValue('X_FK_MAWB_ID','HawbSQL','FK_mawb_id','999',FALSE);
//        HawbTable.AddNodeWithValue('X_DELIVERY_ORDER_AMOUNT','HawbSQL','DELIVERY_ORDER_AMOUNT','0',FALSE);
//        HawbTable.AddNodeWithValue('X_INVOICE_AMOUNT','SenderINvoiceSQL','INVOICE_AMOUNT','0',FALSE);
//        HawbTable.AddNodeWithValue('X_MEDIUM_CUSTOMS_VALUE','SenderINvoiceSQL','CUSTOMS_VALUE','0',FALSE);


//        HawbTable.AddNodeWithValue('X_CHARGE_VAT','HawbSQL','CHARGE_VAT','0',FALSE);
//
//        HawbTable.AddNodeWithValue('X_MEDIUM_HAWB_CUSTOMS_VALUE','HawbSQL','CUSTOMS_VALUE','0',FALSE);
//        HawbTable.AddNodeWithValue('X_MEDIUM_VAT','HAWBSQL','MEDIUM_VAT_RATE',FloatToSTr(GlobalDefaultMediumVAT),FALSE);
//
//          HawbTable.AddNode('HAWB','HawbSQL','Hab_id',FALSE);
//        HawbTable.AddNode('SDPieces','HawbSQL','NUMBER_OF_PARCELS',FALSE);
//        HawbTable.AddNode('ManifestedPieces','HawbSQL','NUM_OF_PIECES_ARRIVED',FALSE);
//        HawbTable.AddNode('CargoDesc','HawbSQL','DESCRIPTION',FALSE);
//        HawbTable.AddNode('GrossWgt','HawbSQL','weight',false);
//        HawbTable.AddNode('DutyTaxFee','HawbSQL','tax',false);
//        HawbTable.AddNode('ShpCtryOrgn','HawbSQL','fk_country_origin',false);
//        HawbTable.AddNode('ArrivalDateInDischarge','HawbSQL','DATE_REGISTERED',false);
//        HawbTable.AddNode('CstmsVal','SenderInvoiceSQL','xx',true);
//        HawbTable.AddNode('X_PRE_DISCOUNT_AMOUNT','SenderInvoiceSQL','PRE_DISCOUNT_AMOUNT',false);
//
//        HawbTable.AddNode('Frght','SenderInvoiceSQL','FREIGHT_AMOUNT',FALSE);
//
//        HawbTable.AddNode('Incoterms','HawbSQL','FK_DELIVERY_TERM',FALSE);
//
//        HawbTable.AddNode('Category','HawbSQL','x_FK_DELIVERY_TERM',TRUE);
//        HawbTable.AddNodeWithNull('X_IsMedium','HawbSQL','IS_MEDIUM');
//        HawbTable.AddNodeWithNull('X_IsHigh','HawbSQL','HIGH_VALUE');
//
//        HawbTable.AddNode('DHLServiceCd','HawbSQL','AIS_PAID',true);
//        HawbTable.AddNode('X_IsPaid','HawbSQL','IS_PAID',FALSE);
//
//        HawbTable.AddNode('Status','HawbSQL','x_CLEARANCE_WAITING_CODE',TRUE);
//        HawbTable.AddNode('X_WAITING_REASON','HawbSQL','CLEARANCE_WAITING_CODE',FALSE);
//
//        HawbTable.AddNode('CstmsValCrncyCd','SenderInvoiceSQL','ACurrency',TRUE);
//        HawbTable.AddNode('X_CURRENCY','SenderInvoiceSQL','CURRENCY',false);
//        HawbTable.AddNode('X_ExchangeRate','SenderInvoiceSQL','EXCHANGE_RATE',false);
//
//        HawbTable.AddNode('X_Clearance','HawbSQL','FK_CLEARANCE_TYPE',FALSE);


    end;

end;




end.
{
        //*******************************************************
        //****  Create Mawb fields from tags // actual values will be uploaded during process
        //*******************************************************

        MawbTable:=TTableValues.Create;

        MawbTable.AddNodewithValue('TDOCNo','MawbSQL','Mawb_id','-1',FALSE);// MawbID was Read before
        MawbTable.AddNode('ArrivalDate','MawbSQL','Date_Arrived',FALSE);
        MawbTable.AddNode('X_MawbID','MawbSQL','MawbId',true);

}

{
        HawbTable.AddNodeWithValue('X_FK_CLEARING_STATE','HawbSQL','FK_CLEARING_STATE','0',FALSE);
        HawbTable.AddNodeWithValue('X_FK_INVOICE_STATUS','HawbSQL','FK_INVOICE_STATUS','0',FALSE);
        HawbTable.AddNodeWithValue('X_FK_MAWB_ID','HawbSQL','FK_mawb_id','999',FALSE);
        HawbTable.AddNodeWithValue('X_DELIVERY_ORDER_AMOUNT','HawbSQL','DELIVERY_ORDER_AMOUNT','0',FALSE);
        HawbTable.AddNodeWithValue('X_INVOICE_AMOUNT','SenderINvoiceSQL','INVOICE_AMOUNT','0',FALSE);
        HawbTable.AddNodeWithValue('X_MEDIUM_CUSTOMS_VALUE','SenderINvoiceSQL','CUSTOMS_VALUE','0',FALSE);


        HawbTable.AddNodeWithValue('X_CHARGE_VAT','HawbSQL','CHARGE_VAT','0',FALSE);

        HawbTable.AddNodeWithValue('X_MEDIUM_HAWB_CUSTOMS_VALUE','HawbSQL','CUSTOMS_VALUE','0',FALSE);
        HawbTable.AddNodeWithValue('X_MEDIUM_VAT','HAWBSQL','MEDIUM_VAT_RATE',FloatToSTr(GlobalDefaultMediumVAT),FALSE);

        HawbTable.AddNode('HAWB','HawbSQL','Hab_id',FALSE);
        HawbTable.AddNode('SDPieces','HawbSQL','NUMBER_OF_PARCELS',FALSE);
        HawbTable.AddNode('ManifestedPieces','HawbSQL','NUM_OF_PIECES_ARRIVED',FALSE);
        HawbTable.AddNode('CargoDesc','HawbSQL','DESCRIPTION',FALSE);
        HawbTable.AddNode('GrossWgt','HawbSQL','weight',false);
        HawbTable.AddNode('DutyTaxFee','HawbSQL','tax',false);
        HawbTable.AddNode('ShpCtryOrgn','HawbSQL','fk_country_origin',false);
        HawbTable.AddNode('ArrivalDateInDischarge','HawbSQL','DATE_REGISTERED',false);
        HawbTable.AddNode('CstmsVal','SenderInvoiceSQL','xx',true);
        HawbTable.AddNode('X_PRE_DISCOUNT_AMOUNT','SenderInvoiceSQL','PRE_DISCOUNT_AMOUNT',false);

        //SenderInvoiceTable:=TTableValues.Create;
        //SenderInvoiceTable.AddNode('CstmsVal','SenderInvoiceSQL','INvoice_amount',True);



        HawbTable.AddNode('Frght','SenderInvoiceSQL','FREIGHT_AMOUNT',FALSE);


        HawbTable.AddNode('Incoterms','HawbSQL','FK_DELIVERY_TERM',FALSE);

        HawbTable.AddNode('Category','HawbSQL','x_FK_DELIVERY_TERM',TRUE);
        HawbTable.AddNodeWithNull('X_IsMedium','HawbSQL','IS_MEDIUM');
        HawbTable.AddNodeWithNull('X_IsHigh','HawbSQL','HIGH_VALUE');
        //HawbTable.AddNodeWithNull('X_IsLow','HawbSQL','IS_PRIVATE');asdfasd

        HawbTable.AddNode('DHLServiceCd','HawbSQL','AIS_PAID',true);
        HawbTable.AddNode('X_IsPaid','HawbSQL','IS_PAID',FALSE);

        HawbTable.AddNode('Status','HawbSQL','x_CLEARANCE_WAITING_CODE',TRUE);
        HawbTable.AddNode('X_WAITING_REASON','HawbSQL','CLEARANCE_WAITING_CODE',FALSE);


        //HawbTable.AddNode('InvNo','SenderInvoiceSQL','INVOICE_NUMBER',false);

        HawbTable.AddNode('CstmsValCrncyCd','SenderInvoiceSQL','ACurrency',TRUE);
        HawbTable.AddNode('X_CURRENCY','SenderInvoiceSQL','CURRENCY',false);
        HawbTable.AddNode('X_ExchangeRate','SenderInvoiceSQL','EXCHANGE_RATE',false);


        //HawbTable.AddNode('CoName','HawbSQL','CUSTOMER_NAME',FALSE);
        HawbTable.AddNode('X_Clearance','HawbSQL','FK_CLEARANCE_TYPE',FALSE);

}
