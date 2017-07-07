unit X_readFile;
//XMLNode has Childnodes , and you can use Node.Childnodes[0] or Node.ChildNodes['Hdr] to get child node
//XMLNodeList is the list itself. it has attribute list.count and list['arrive'] to get the node
// childnodes will create a node if NOT found . FindNode will result to null and chekc assign
//if Assigned(list['data'])
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc, Data.DB, MemDS, DBAccess, IBC,Math;

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
    SenderInvoiceSQL: TIBCQuery;
    SenderInvoiceSQLFK_HAWB_SERIAL: TIntegerField;
    SenderInvoiceSQLINVOICE_SERIAL: TIntegerField;
    SenderInvoiceSQLINVOICE_NUMBER: TStringField;
    SenderInvoiceSQLFK_HAWB_ID: TStringField;
    SenderInvoiceSQLINVOICE_AMOUNT: TFloatField;
    SenderInvoiceSQLFREIGHT_AMOUNT: TFloatField;
    SenderInvoiceSQLDISCOUNT_AMOUNT: TFloatField;
    SenderInvoiceSQLINSURANCE_AMOUNT: TFloatField;
    SenderInvoiceSQLOTHER_CHARGES_AMOUNT: TFloatField;
    SenderInvoiceSQLTOTAL_AMOUNT: TFloatField;
    SenderInvoiceSQLCURRENCY: TStringField;
    SenderInvoiceSQLEXCHANGE_RATE: TFloatField;
    SenderInvoiceSQLFACTOR: TFloatField;
    SenderInvoiceSQLFREIGHT_CYP_AMOUNT: TFloatField;
    SenderInvoiceSQLCUSTOMS_VALUE: TFloatField;
    SenderInvoiceSQLFK_MAWB_SERIAL: TIntegerField;
    SenderInvoiceSQLIS_VALID: TStringField;
    SenderInvoiceSQLNUMBER_OF_HAWB_ITEMS: TIntegerField;
    SenderInvoiceSQLPRE_DISCOUNT_AMOUNT: TFloatField;
    SenderInvoiceSQLDISCOUNT_RATE: TFloatField;
    SenderInvoiceSQLFACTOR_NUMERIC: TFloatField;
    HawbItemSQL: TIBCQuery;
    Button2: TButton;
    HawbItemSQLSERIAL_NUMBER: TIntegerField;
    HawbItemSQLFK_HAWB_SERIAL: TIntegerField;
    HawbItemSQLFK_COUNTRY_ORIGIN: TIntegerField;
    HawbItemSQLDESCRIPTION: TStringField;
    HawbItemSQLFK_RELIEF_CODE: TStringField;
    HawbItemSQLFK_IMPORT_TYPE: TStringField;
    HawbItemSQLINVOICE_VALUE: TFloatField;
    HawbItemSQLDUTY_TYPE: TStringField;
    HawbItemSQLTARIFF_DESCRIPTION: TStringField;
    HawbItemSQLNET_QUANTITY: TIntegerField;
    HawbItemSQLIMPORT_DUTY_RATE: TFloatField;
    HawbItemSQLRELIEVED_IMPORT_DUTY: TFloatField;
    HawbItemSQLEXCISE_DUTY_RATE: TFloatField;
    HawbItemSQLEXCISE_RELIEVED: TFloatField;
    HawbItemSQLTRL_RATE: TFloatField;
    HawbItemSQLTRL_RELEIVED: TFloatField;
    HawbItemSQLVAT_RATE: TFloatField;
    HawbItemSQLVAT_RELEIVED: TFloatField;
    HawbItemSQLCUSTOMS_VALUE: TFloatField;
    HawbItemSQLCURRENCY_RATE: TFloatField;
    HawbItemSQLCURRENCY: TStringField;
    HawbItemSQLFK_MAWB: TIntegerField;
    HawbItemSQLFK_VAT_CODE: TIntegerField;
    HawbItemSQLFK_TARIFF_C_CODE: TStringField;
    HawbItemSQLFK_TARIFF_CODE: TStringField;
    HawbItemSQLIMPORT_DUTY_RATE_UNIT: TStringField;
    HawbItemSQLIMPORT_DUTY_RATE_QUANT: TFloatField;
    HawbItemSQLIMPORT_DUTY_RATE_BASE: TFloatField;
    HawbItemSQLDUTY_IMPORT_PAY: TFloatField;
    HawbItemSQLDUTY_TRL_PAY: TFloatField;
    HawbItemSQLDUTY_EXCISE_PAY: TFloatField;
    HawbItemSQLDUTY_VAT_PAY: TFloatField;
    HawbItemSQLDUTY_IMPORT_TOTAL: TFloatField;
    HawbItemSQLDUTY_EXCISE_TOTAL: TFloatField;
    HawbItemSQLDUTY_TRL_TOTAL: TFloatField;
    HawbItemSQLDUTY_VAT_TOTAL: TFloatField;
    HawbItemSQLTOTAL_VALUE_FOR_VAT: TFloatField;
    HawbItemSQLDUTY_TOTAL_CHARGES: TFloatField;
    HawbItemSQLFK_EXCISE_CODE: TStringField;
    HawbItemSQLEURO1: TStringField;
    HawbItemSQLEURO2: TStringField;
    HawbItemSQLPOSOSTOSIS: TStringField;
    HawbItemSQLFK_SENDER_INVOICE_SERIAL: TIntegerField;
    HawbItemSQLMULTI_ITEMS_INVOICE: TStringField;
    HawbItemSQLINVOICE_LINE: TIntegerField;
    HawbItemSQLPRE_DISCOUNT_AMOUNT: TFloatField;
    HawbItemSQLWEIGHT_NET: TFloatField;
    HawbItemSQLUNIT: TStringField;
    HawbItemSQLEURO_PENDING: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    cn:TIBCConnection;
  function ReadFile(Const FileName:String) :boolean;
  function findMawb(Const MawbId:String):Integer;
  function findHawb(Const HawbId:String):Boolean;

  function ProcessOneMawb(mawbNode:IXMLNode):boolean;

  function CreateMawb(Const MawbId:String;Const MawbNode:IXMLNode):integer;
  function UpdateMawb(Const MawbSerial:Integer;Const MawbNode:IXMLNode):Boolean;
//  function CreateSenderInvoice(Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
  function CreateHawb(Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
  function CreatePartialHawb(Const hawbId:String ;Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
  function CreateHawbItem(Const mawbSerial:Integer; Const hawbSerial:Integer ; hawbItemNode:IXMLNode):Integer;
  public
    { Public declarations }
  end;

var
  X_readFileFRM: TX_readFileFRM;

implementation

{$R *.dfm}

uses Main, G_kyriacosTypes,  G_KyrSQL, G_generalProcs;
procedure TX_readFileFRM.FormCreate(Sender: TObject);
begin
  cn:= mainFRm.IBCConnection1;
end;
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
// ShowMessage(Movements[0].ChildNodes['MvmtNo'].Text);

 Mawbs:=Movements[0].ChildNodes['TDOCs'].ChildNodes; //only one movement is sent
  if Mawbs.Count <1 then begin
    result:=False;
    exit;
 end;

  for I := 0 to Mawbs.Count-1 do  begin
  //each movement may hawe one or more mawbs
    aMawb := Mawbs[i];
    ProcessOneMawb(aMawb);
  end;




//   wNode:=mvmt['hdr'];
//  ShowMessage(wNode.LocalName);
//  wNode:=Mvmt['ArrivalDate'];
//  ShowMessage(wNode.Text);
//  ShowMessage(Mvmt['ArrivalDate'].text);
  exit;
  MawbRec.MawbId:= movements['ArrivalData'].Text;


  end;

function TX_readFileFRM.findMawb(Const MawbId:String):Integer;
var
  qr:TksQuery;
begin
  try
  qr:=TksQuery.Create(cn,'select reference_number from Mawb where Mawb_id= :MawbID');
  qr.ParamByName('MawbID').Value:=MawbId;
  qr.Open;
  result:=qr.FieldByName('reference_number').AsInteger;
  close;
  finally
    qr.Free;
  end;

End;

function TX_readFileFRM.findHawb(Const HawbId:String):Boolean;
var
  qr:TksQuery;
begin

try
  qr:=TksQuery.Create(cn,'select hab_id from hawb where hab_id= :hawbID');
  qr.ParamByName('hawbId').Value:=hawbId;
  qr.Open;
  result:= not qr.IsEmpty;
  close;
finally
  qr.Free;
end;

End;

function TX_readFileFRM.ProcessOneMawb(MawbNode:IXMLNode):Boolean;
var
  MawbId:String;
  hawbNodes :IXMLNodeList;
  hawbNode:ixmlnODE;
  hawbItemNodes:IxmlNodeList;
  hawbItemNode:IxmlNode;
  j,k:Integer;
  MawbSerial:Integer;
  Hawbserial:integer;
  hawb:string;
  UseOld:Boolean;
begin
  ksOpenTables([MawbSQL,HawbSQL,SenderInvoiceSQL,HawbItemSQL]);
  UseOld:=true;
  MawbId:=MawbNode.ChildNodes['TDOCNo'].Text;
  SHowMessage('mawb==='+MawbId);


  MawbSerial:=FindMawb(MawbId);
  if  (MawbSerial <1) then begin
    MawbSerial:=CreateMawb(MawbId,MawbNode);
  end else begin
    //askUser to create new one or update existing one
    if UseOld then begin
      UpdateMawb(MawbSerial,MawbNode);
    end else begin
      MawbSerial:=CreateMawb(MawbId,MawbNOde);
    end;

  end;

  hawbNOdes:=MawbNOde.ChildNodes['Shps'].ChildNodes;

    for j:= 0 to hawbNodes.Count -1 do begin
      hawbNode:=hawbNodes[j];
      hawb:=hawbNode.ChildNodes['HAWB'].Text;
      showMessage('------hawb---'+ hawb);

      if findHawb(hawb)then begin
        CreatePartialHawb(hawb,Mawbserial,hawbNode);
      end else begin

        HawbSerial := CreateHawb(MawbSerial,hawbNode);
        hawbItemNodes:=hawbNode.ChildNodes['LineItems'].ChildNodes;
        for k:= 0 to hawbItemNodes.Count -1 do begin
          hawbItemNode:= hawbItemNodes[k];
          CreateHawbItem(MawbSerial,Hawbserial,HawbItemNode);
        end;

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

function TX_readFileFRM.UpdateMawb(Const MawbSerial:Integer;Const MawbNode:IXMLNode):Boolean;
var
  qr:TksQuery;
begin

  try
    qr:=TksQuery.Create(cn,'SELECT * from Mawb where reference_number= :MawbSerial');
    qr.ParamByName('MawbSerial').Value:= MawbSerial;
    qr.Open;

    result:= not qr.IsEmpty;
    qr.Edit;
    qr.FieldByName('REFERENCE_YEAR').VALUE:=2017;
    qr.FieldByName('goods_number').value:=qr.FieldByName('goods_number').AsInteger+1;
    qr.Post;
    qr.Close;
  finally
    qr.Free;
  end;

end;


function TX_readFileFRM.CreateMawb(Const MawbId:String;Const MawbNode:IXMLNode):integer;
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
end;



procedure TX_readFileFRM.Button2Click(Sender: TObject);
var
  multiSQL:TksMultiSQL;
  hiStr:String;
begin
   try
    hiStr:= 'Delete  from hawb_item_certificate dd where dd.fk_hawb_item in '
    + '( select hi.serial_number from  hawb_item hi where hi.fk_hawb_serial <200 )';

    multiSQL:=TksMultiSQL.Create(cn)
    .add(hiStr,[])
    .add('delete from hawb_comments where fk_hawb_serial < 200',[] )
    .add('delete from hawb_partial where FK_HAWB_SERIAL_ORIGINAL < 200',[] )
    .add('delete from hawb_item where fk_hawb_serial < 200',[] )
    .add('delete from sender_invoice where fk_hawb_serial <200' ,[])
    .add('delete from hawb where serial_number <200',[])
    .ExecSQL();

   finally
     multiSQL.Free;
   end;

end;

function TX_readFileFRM.CreateHawb(Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
var
  qr:TIBCQuery;
  siSQL:TIBCQuery;
  hawbSerial:Integer;
  temp:string;
begin


    qr:=HawbSQL;
    qr.Insert;

    qr.FieldByName('Hab_id').value               :=hawbNode.ChildNodes['HAWB'].Text;
    qr.FieldByName('fk_mawb_refer_number').value :=MawbSerial;
    qr.FieldByName('FK_mawb_id').value           :=''; //NOT used anymore

    qr.FieldByName('DELIVERY_ORDER_AMOUNT').value :=0;

    qr.FieldByName('FK_CLEARING_STATE').value   :='0';
    qr.FieldByName('FK_INVOICE_STATUS').value   :='0';
//    qr.FieldByName('INVOICE_AMOUNT').value    :=0;
    qr.FieldByName('NUMBER_OF_PARCELS').value   :=StrToIntDef( hawbNode.ChildNodes['SDPieces'].Text,0);
    qr.FieldByName('NUM_OF_PIECES_ARRIVED').value :=StrToIntDef( hawbNode.ChildNodes['ManifestedPieces'].Text,0);
    qr.FieldByName('DESCRIPTION').value         := hawbNode.ChildNodes['CargoDesc'].Text;

    qr.FieldByName('weight').value              :=ConvertDecimalF( hawbNode.ChildNodes['GrossWgt'].Text);
//    qr.FieldByName('medium value, DO, xx,  or normal').value :='';
    qr.Post;
    hawbSerial:=qr.FieldByName('serial_number').AsInteger;

    siSQL:=SenderInvoiceSQL;
    siSQL.Insert;
    siSQL.FieldByName('fk_hawb_serial').Value        :=hawbSerial;
    siSQL.FieldByName('Invoice_serial').Value        :=1;
    siSQL.FieldByName('fk_mawb_serial').value  :=MawbSerial;
    siSQL.FieldByName('fk_Hawb_id').value                :=''; //NOT used anymore
    siSQL.FieldByName('Invoice_number').Value        :='';
    siSQL.FieldByName('IS_VALID').Value        :='Y';
    siSQL.FieldByName('EXCHANGE_RATE').Value        :=0.01;
//    temp:=hawbNode.ChildNodes
    siSQL.FieldByName('PRE_DISCOUNT_AMOUNT').value   :=ConvertDecimalF( hawbNode.ChildNodes['TxAndDty'].ChildNodes['CstmsVal'].Text);    siSQL.FieldByName('CURRENCY').value   := hawbNode.ChildNodes['TxAndDty'].ChildNodes['CstmsValCrncyCd'].Text;
    siSQL.FieldByName('invoice_amount').Value        :=0.02;


//    siSQL.FieldByName('FREIGHT_AMOUNT').value   :=ConvertDecimalF( hawbNode.ChildNodes['Frght'].Text);
    siSQL.Post;
    result:=HawbSerial;



//        HawbTable.AddNode('DutyTaxFee','HawbSQL','tax',false);
//        HawbTable.AddNode('ShpCtryOrgn','HawbSQL','fk_country_origin',false);
//        HawbTable.AddNode('ArrivalDateInDischarge','HawbSQL','DATE_REGISTERED',false);
//        HawbTable.AddNode('CstmsVal','SenderInvoiceSQL','xx',true);
//        HawbTable.AddNode('X_PRE_DISCOUNT_AMOUNT','SenderInvoiceSQL','PRE_DISCOUNT_AMOUNT',false);
//

//        HawbTable.AddNode('Incoterms','HawbSQL','FK_DELIVERY_TERM',FALSE);
//
//        HawbTable.AddNode('Category','HawbSQL','x_FK_DELIVERY_TERM',TRUE);
//        HawbTable.AddNodeWithNull('X_IsMedium','HawbSQL','IS_MEDIUM');
//        HawbTable.AddNodeWithNull('X_IsHigh','HawbSQL','HIGH_VALUE');
//
//        HawbTable.AddNode('DHLServiceCd','HawbSQL','AIS_PAID',true);
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

function TX_readFileFRM.CreatePartialHawb(Const hawbId:String ;Const mawbSerial:Integer; hawbNode:IXMLNode):Integer;
var
  qr:TksQuery;
  oh:TksQuery;
  SerialNumber:Integer;
  OldHawbSerial:Integer;
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
    oh:=TksQuery.Create(cn,'select serial_number, hab_id, fk_mawb_refer_number from hawb where hab_Id= :HawbId');
    oh.ParamByName('hawbId').Value:=hawbId;
    oh.Open;

    qr:=TksQuery.Create(cn,'select * from hawb_partial where serial_number =0 ');
    qr.Open;
    qr.Insert;
    qr.FieldByName('serial_number').value:=SerialNumber;

    qr.FieldByName('FK_HAWB_SERIAL_ORIGINAL').value := oh.FieldByName('serial_number').AsInteger;
    qr.FieldByName('FK_HAWB_ID_ORIGINAL').value     := oh.FieldByName('hab_id').AsString;

    qr.FieldByName('FK_MAWB_SERIAL_ORIGINAL').value := oh.FieldByName('fk_mawb_refer_number').AsInteger;
    qr.FieldByName('FK_MAWB_ID_ORIGINAL').value     := ''; //not used anymore

    qr.FieldByName('FK_MAWB_SERIAL_ARRIVED').value  := MawbSerial;
    qr.FieldByName('FK_MAWB_ID_ARRIVED').value      :='';

    qr.FieldByName('PARTIAL_WEIGHT').value          := ConvertDecimalF(hawbNode.ChildNodes['GrossWgt'].Text);
    qr.FieldByName('PARTIAL_PIECES').value          := StrToIntDef(hawbNode.ChildNodes['ManifestedPieces'].Text,0);
    qr.FieldByName('PARTIAL_DELIVERY_ORDER_ID').value := HawbId;
    qr.FieldByName('DESCRIPTION').value             := hawbNode.ChildNodes['CargoDesc'].Text;

    qr.Post;
    result:=0;
    qr.close;
    oh.Close;
  finally
    qr.Free;
    oh.free;
  end;

end;

function TX_readFileFRM.CreateHawbItem(Const mawbSerial:Integer; Const hawbSerial:Integer ; hawbItemNode:IXMLNode):Integer;
var
  OldMawbId:String;
begin
  HawbItemSQL.Insert;
  HawbItemSQL.FieldByName('FK_MAWB').Value              := MawbSerial;
  HawbItemSQL.FieldByName('FK_HAWB_SERIAL').Value       := HawbSerial;
  HawbItemSQL.FieldByName('FK_SENDER_INVOICE_SERIAL').Value := 1;

  HawbItemSQL.FieldByName('PRE_DISCOUNT_AMOUNT').value  := ConvertDecimalF( hawbItemNode.ChildNodes['InvLineVal'].Text);
  HawbItemSQL.FieldByName('DESCRIPTION').value          := hawbItemNode.ChildNodes['DescOfGoods'].Text;
  HawbItemSQL.FieldByName('NET_QUANTITY').value         := math.Ceil ( ConvertDecimalF(HawbItemNode.ChildNodes['TariffQnty'].Text) );
//  HawbItemSQL.FieldByName('INVOICE_VALUE').value        := ConvertDecimalF( hawbItemNode.ChildNodes['UnitPrice'].Text);
  HawbItemSQL.FieldByName('CURRENCY').value             :=hawbItemNode.ChildNodes['InvCrncyCd'].Text;
//  HawbItemSQL.FieldByName('IMPORT_DUTY_RATE_UNIT').value :=hawbItemNode.ChildNodes['DescOfGoods'].Text;
  HawbItemSQL.FieldByName('WEIGHT_NET').value           := ConvertDecimalF( hawbItemNode.ChildNodes['NetWeight'].Text);
//  HawbItemSQL.FieldByName('FK_COUNTRY_ORIGIN').value    :=hawbItemNode.ChildNodes['CtryMfctrerOrgn'].Text;
  HawbItemSQL.FieldByName('FK_COUNTRY_ORIGIN').value    :=1;
  HawbItemSQL.Post;

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
