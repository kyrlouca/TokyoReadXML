unit X_readFile;
//XMLNode has Childnodes , and you can use Node.Childnodes[0] or Node.ChildNodes['Hdr] to get child node
//XMLNodeList is the list itself. it has attribute list.count and list['arrive'] to get the node
// childnodes will create a node if NOT found . FindNode will result to null and chekc assign
//if Assigned(list['data'])
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc, Data.DB, MemDS, DBAccess, IBC;

type
TMawbRec =Record
  MawbId:String;
  ArrivalDate:String;
End;
THawbRec =Record
  HawbId:String;
  HawbSerial:Integer;
  MawbSerial:Integer;
  MawbId:String;
  ArrivalDate:String;
End;

  TX_readFileFRM = class(TForm)
    Button1: TButton;
    XMLDocument1: TXMLDocument;
    ReadTrans: TIBCTransaction;
    WriteTrans: TIBCTransaction;
    HawbSQL: TIBCQuery;
    MawbSQL: TIBCQuery;
    MawbSQLREFERENCE_YEAR: TSmallintField;
    MawbSQLREFERENCE_NUMBER: TIntegerField;
    MawbSQLDATE_ARRIVED: TDateField;
    MawbSQLFK_COUNTRY_CONSIGNEE: TIntegerField;
    MawbSQLFK_PORT_IMPORTATION: TIntegerField;
    MawbSQLSIGNATORY_NAME: TStringField;
    MawbSQLFORM_DATE: TDateField;
    MawbSQLFLIGHT_NUMBER: TStringField;
    MawbSQLPASSED: TStringField;
    MawbSQLROTATION_NUMBER: TIntegerField;
    MawbSQLROTATION_YEAR: TSmallintField;
    MawbSQLFK_PORT_CLEARING: TIntegerField;
    MawbSQLGOODS_NUMBER: TIntegerField;
    MawbSQLGOODS_DESCRIPTION: TStringField;
    MawbSQLCBOOK_NUMBER: TStringField;
    MawbSQLMAWB_ID: TStringField;
    MawbSQLINVOICED: TStringField;
    MawbSQLSENT_TO_HEAD: TStringField;
    MawbSQLCUSTOMS_OVERTIME_HOURS: TFloatField;
    MawbSQLCUSTOMS_OVERTIME_RATE: TFloatField;
    MawbSQLSTORAGE_EXPENSES: TFloatField;
    MawbSQLDELIVERY_EXPENSES: TFloatField;
    MawbSQLAMOUNT_NOT_INVOICED: TFloatField;
    MawbSQLAMOUNT_INVOICED: TFloatField;
    MawbSQLDATE_PASSED: TDateField;
    MawbSQLGOODS_WEIGHT: TIntegerField;
    MawbSQLHAWBS_CLEARED_FIRST_TIME: TIntegerField;
    MawbSQLHAWBS_IN_MAWB: TIntegerField;
    MawbSQLDOCS_NUMBER: TIntegerField;
    MawbSQLDOCS_WEIGHT: TFloatField;
    MawbSQLHIGH_VALUE_NUMBER: TIntegerField;
    MawbSQLHIGH_VALUE_WEIGHT: TFloatField;
    MawbSQLMEDIUM_VALUE_NUMBER: TIntegerField;
    MawbSQLMEDIUM_VALUE_WEIGHT: TFloatField;
    MawbSQLLOW_VALUE_NUMBER: TIntegerField;
    MawbSQLLOW_VALUE_WEIGHT: TFloatField;
    MawbSQLCUSTOMS_OVERTIME_RATE_TYPE: TStringField;
    MawbSQLXML_CONSOLIDATED_ID: TStringField;
    MawbSQLROTATION_2: TStringField;
    MawbSQLHMSD: TStringField;
    MawbSQLLOW_VALUE_TDID: TStringField;
    MawbSQLSTATUSC_NUMBER: TIntegerField;
    MawbSQLSTATUSC_WEIGHT: TIntegerField;
    MawbSQLTDID_NEW: TStringField;
    MawbSQLF63: TStringField;
    MawbSQLSTATUSC: TStringField;
    MawbSQLTDID_MEDIUM: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cn:TIBCConnection;
    function ReadFile(Const FileName:String) :boolean;
  function findHawb(Const HawbId:String): THawbRec;

  function getOneMawb(aMawb:IXMLNode):boolean;
  function CreateMawb(Const MawbId:String):integer;

  function CreateHawb(Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;

  function CreatePartialHawb(Const hawbId:String ;Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
  public
    { Public declarations }
  end;

var
  X_readFileFRM: TX_readFileFRM;

implementation

{$R *.dfm}

uses Main, G_kyriacosTypes,  G_KyrSQL;

procedure TX_readFileFRM.Button1Click(Sender: TObject);
var
fname:String;
begin
//fname:='C:\Data\DelphiProjects\testX1\files\Real3.xml';
//fName:='C:\Data\DelphiProjects\CabReadXML\XMLFiles1\xr3.xml';
fname:='C:\Data\DelphiProjects\TokyoReadXML\XMLFiles1\Xr3.xml';
  ReadFile(fName);

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


  for I := 0 to Mawbs.Count-1 do  begin
    aMawb := Mawbs[i];
//    ShowMessage(aMawb.ChildNodes['TDOCNo'].Text);
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

function TX_readFileFRM.CreateMawb(Const MawbId:String):integer;
begin
  if MawbSQL.Active then
    MawbSQL.close;

  MawbSQL.ParamByName('serialNumber').Value:=2;
  MawbSql.Open;
  MawbSQl.Edit;
  MawbSQL.FieldByName('Mawb_id').Value:=MawbId;
  MawbSQL.Post;
  MawbSQL.Close;
  result:=2;
   ShowMessage('mawb:'+mawbId);


end;

function TX_readFileFRM.findHawb(Const HawbId:String):THawbRec;
var
  qr:TksQuery;
begin

try
  qr:=TksQuery.Create(cn,'select hab_id from hawb where hab_id= :hawbID');
  qr.ParamByName(hawbId).Value:=hawbId;
  qr.Open;
  close;
finally
  qr.Free;
end;

End;

function TX_readFileFRM.CreatePartialHawb(Const hawbId:String ;Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
var
  qr:TksQuery;
  oh:TksQuery;
  SerialNumber:Integer;
  OldHawbSerial:Integer;
  OldHawbId:String;
  OldMawbSerial:Integer;
  OldMawbId:String;
begin

  try
    oh:=TksQuery.Create(cn,'SELECT NEXT VALUE FOR HAWB_PARTIAL_GENERATOR FROM RDB$DATABASE');
    oh.Open;
    SerialNumber :=oh.FieldByName('GEN_ID').AsInteger;
    oh.Close;
  finally
    oh.Free;
  end;

  try
    oh:=TksQuery.Create(cn,'select serial_number, hab_id, fk_mawb_refer_number from hawb where hawbId= :HawbId');
    oh.ParamByName('hawbId').Value:=hawbId;
    oh.Open;

    qr:=TksQuery.Create(cn,'select hab_id from hawb where serial_numbr:=0');
    qr.Open;
    qr.Insert;
    qr.FieldByName('serial_number').value:=SerialNumber;

    qr.FieldByName('FK_HAWB_SERIAL_ORIGINAL').value := oh.FieldByName('serial_number').AsInteger;
    qr.FieldByName('FK_HAWB_ID_ORIGINAL').value     := oh.FieldByName('hab_id').AsString;

    qr.FieldByName('FK_MAWB_SERIAL_ORIGINAL').value := oh.FieldByName('fk_mawb_refer_number').AsInteger;
    qr.FieldByName('FK_MAWB_ID_ORIGINAL').value     := ''; //not used anymore

    qr.FieldByName('FK_MAWB_SERIAL_ARRIVED').value  := MawbSerial;
    qr.FieldByName('FK_MAWB_ID_ARRIVED').value      :='';

    qr.FieldByName('PARTIAL_WEIGHT').value          := StrToFloatDef(hawbNode.ChildNodes['GrossWgt'].Text,0);
    qr.FieldByName('PARTIAL_PIECES').value          := StrToIntDef(hawbNode.ChildNodes['ManifestedPieces'].Text,0);
    qr.FieldByName('PARTIAL_DELIVERY_ORDER_ID').value := OldHawbId;
    qr.FieldByName('DESCRIPTION').value             := hawbNode.ChildNodes['CargoDesc'].Text;
    qr.close;
    oh.Close;
  finally
    qr.Free;
    oh.free;
  end;

end;


function TX_readFileFRM.CreateHawb(Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
var
  qr:TIBCQuery;
begin
  qr:=HawbSQL;


    qr.FieldByName('PARTIAL_WEIGHT').value          := StrToFloatDef(hawbNode.ChildNodes['GrossWgt'].Text,0);
    qr.FieldByName('PARTIAL_PIECES').value          := StrToIntDef(hawbNode.ChildNodes['ManifestedPieces'].Text,0);
    qr.FieldByName('PARTIAL_DELIVERY_ORDER_ID').value := OldHawbId;
    qr.FieldByName('DESCRIPTION').value             := hawbNode.ChildNodes['CargoDesc'].Text;
    qr.close;
    qr.FieldByName('serial_number').value:=SerialNumber;

   qr.FieldByName('FK_mawb_id').value:=''; //NOT used anymore

   qr.FieldByName('DELIVERY_ORDER_AMOUNT').value:=0;

    qr.FieldByName('FK_CLEARING_STATE').value:='0';
    qr.FieldByName('FK_INVOICE_STATUS').value:='0';
    qr.FieldByName('INVOICE_AMOUNT').value:=0;

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



procedure TX_readFileFRM.FormCreate(Sender: TObject);
begin
cn:= mainFRm.IBCConnection1;
end;

function TX_readFileFRM.getOneMawb(aMawb:IXMLNode):boolean;
var
  MawbId:String;
  Hawbs :IXMLNodeList;
  aHawb:ixmlnODE;
  j:Integer;
  MawbSerial:Integer;
begin
  MawbId:=aMawb.ChildNodes['TDOCNo'].Text;
  MawbSerial:=CreateMawb(MawbId);

    hawbs:=aMawb.ChildNodes['Shps'].ChildNodes;

    for j:= 0 to hawbs.Count -1 do begin
      Ahawb:=hawbs[j];
      showMessage('------hawb---'+Ahawb.ChildNodes['HAWB'].Text);

      with HawbSQL do begin
        hawbSQL.Close;
        HawbSQL.Open;
        HawbSQL.Insert;
        HawbSQl.FieldByName('fk_mawb_refer_NUMBER').Value:= MawbSerial;
        HawbSQl.FieldByName('hab_id').Value:=aHawb.ChildNodes['HAWB'].Text;
        HawbSQl.FieldByName('Weight').Value:= aHawb.ChildNodes['GrossWgt'].Text;

        HawbSQL.Post;
      end;

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
