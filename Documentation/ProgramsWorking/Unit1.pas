unit Unit1;

//*******************************************************************************
//* The Mawbs are in MVMTS>
//* Each Mawb is in MvMT>
//* Hawbs are in <shps>
//* Each hawb is a <shp> with fields <hawb>, <invoiceAmount><LineItems>
//* Hawb items are found in <LineItems>
//* Each HawbIte is a <LineItem>
//*******************************************************************************
//*******************************************************************************
//*******************************************************************************

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, OleCtrls, LibXmlParser, LibXmlComps, UnicodeConv, Db, MemDS,
  DBAccess, IBC, Grids, Wwdbigrd, Wwdbgrid ,GeneralProcedures, DAScript,
  IBCScript;


Const
        MAXWORDS=100;

type

  TState=(START,CMAWB,CHAWB);
  TAction=(Read,Create,DoNothing);

  THawb=Record
        HawbId:String;
        Description:String;
        Weight:Double;
        Pieces:Integer;
  end;



  TAirwayBillItemLine=Record
        Sequence:Integer;
        Description:String;
        Weight:Double;
        Pieces:Integer;
  end;


//  TProgramState=(START,CMAWB,CHAWB,CINV,CITEM,ERRR);

  TStateOutput=Record
        State:Tstate;
        Action:TAction;
  end;


  //TStateArray = Array [TProgramState,TItemType] of TProgramState;
  TStateArray = Array [TState,TItemType] of TStateOutput;


  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CSMIB1: TCSMIB;
    XmlScanner1: TXmlScanner;
    ListBox1: TListBox;
    Button4: TButton;
    AdditionalSQL: TIBCQuery;
    AdditionalSQLCODE: TStringField;
    AdditionalSQLDESCRIPTION: TStringField;
    AdditionalSQLAMOUNT: TFloatField;
    AdditionalSRC: TIBCDataSource;
    wwDBGrid1: TwwDBGrid;
    MawbSQL: TIBCQuery;
    MawbSQLREFERENCE_YEAR: TSmallintField;
    MawbSQLREFERENCE_NUMBER: TIntegerField;
    MawbSQLDATE_ARRIVED: TDateTimeField;
    MawbSQLFK_COUNTRY_CONSIGNEE: TIntegerField;
    MawbSQLFK_PORT_IMPORTATION: TIntegerField;
    MawbSQLSIGNATORY_NAME: TStringField;
    MawbSQLFORM_DATE: TDateTimeField;
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
    MawbSQLDATE_PASSED: TDateTimeField;
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
    ReadTrans: TIBCTransaction;
    WriteTrans: TIBCTransaction;
    HawbSQL: TIBCQuery;
    HawbItemSQL: TIBCQuery;
    SmallintField3: TSmallintField;
    IntegerField16: TIntegerField;
    DateTimeField4: TDateTimeField;
    IntegerField17: TIntegerField;
    IntegerField18: TIntegerField;
    StringField18: TStringField;
    DateTimeField5: TDateTimeField;
    StringField19: TStringField;
    StringField20: TStringField;
    IntegerField19: TIntegerField;
    SmallintField4: TSmallintField;
    IntegerField20: TIntegerField;
    IntegerField21: TIntegerField;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    StringField24: TStringField;
    StringField25: TStringField;
    FloatField11: TFloatField;
    FloatField12: TFloatField;
    FloatField13: TFloatField;
    FloatField14: TFloatField;
    FloatField15: TFloatField;
    FloatField16: TFloatField;
    DateTimeField6: TDateTimeField;
    IntegerField22: TIntegerField;
    IntegerField23: TIntegerField;
    IntegerField24: TIntegerField;
    IntegerField25: TIntegerField;
    FloatField17: TFloatField;
    IntegerField26: TIntegerField;
    FloatField18: TFloatField;
    IntegerField27: TIntegerField;
    FloatField19: TFloatField;
    IntegerField28: TIntegerField;
    FloatField20: TFloatField;
    StringField26: TStringField;
    StringField27: TStringField;
    StringField28: TStringField;
    StringField29: TStringField;
    StringField30: TStringField;
    IntegerField29: TIntegerField;
    IntegerField30: TIntegerField;
    StringField31: TStringField;
    StringField32: TStringField;
    StringField33: TStringField;
    StringField34: TStringField;
    SenderInvoiceSQL: TIBCQuery;
    HawbSQLHAB_ID: TStringField;
    HawbSQLFK_MAWB_REFER_NUMBER: TIntegerField;
    HawbSQLFK_CLEARING_STATE: TStringField;
    HawbSQLFK_INVOICE_STATUS: TStringField;
    HawbSQLDESCRIPTION: TStringField;
    HawbSQLFK_CUSTOMER_CODE: TIntegerField;
    HawbSQLWEIGHT: TFloatField;
    HawbSQLFK_CURRENCY: TStringField;
    HawbSQLEXCHANGE_RATE: TFloatField;
    HawbSQLINVOICE_TOTAL: TFloatField;
    HawbSQLFREIGHT_AMOUNT: TFloatField;
    HawbSQLFK_OTHER_CHARGE_CODE: TStringField;
    HawbSQLOTHER_CHARGE_AMOUNT: TFloatField;
    HawbSQLOTHER_CHARGE_PAID: TStringField;
    HawbSQLSTAMPS_AMOUNT: TFloatField;
    HawbSQLEXPS_NON_INVOICABLE: TFloatField;
    HawbSQLSERIAL_NUMBER: TIntegerField;
    HawbSQLCUSTOMS_VALUE: TFloatField;
    HawbSQLINVOICE_SERIAL: TIntegerField;
    HawbSQLCOURIER_INVOICE_SERIAL: TIntegerField;
    HawbSQLCOURIER_INVOICE_VALUE: TFloatField;
    HawbSQLHIGH_VALUE: TStringField;
    HawbSQLFK_SEC_MAWB_REFER_NUMBER: TIntegerField;
    HawbSQLEDE_STORAGE_EXPENSES: TFloatField;
    HawbSQLEDE_DELIVERY_EXPENSES: TFloatField;
    HawbSQLDATE_INVOICED: TDateTimeField;
    HawbSQLSENT_TO_HEAD: TStringField;
    HawbSQLNUM_OF_PIECES_ARRIVED: TIntegerField;
    HawbSQLTOTAL_NUM_OF_PIECES: TIntegerField;
    HawbSQLFK_CLEARANCE_TYPE: TStringField;
    HawbSQLFK_DELIVERY_TERM: TStringField;
    HawbSQLORIGIN_STATION: TStringField;
    HawbSQLEC2_NUMBER_DATE: TStringField;
    HawbSQLSENDERS_INV_NO: TStringField;
    HawbSQLNUMBER_OF_PARCELS: TIntegerField;
    HawbSQLFK_CUSTOMER_ACCOUNT: TIntegerField;
    HawbSQLDISTRICT: TStringField;
    HawbSQLDELIVERY_ORDER_AMOUNT: TFloatField;
    HawbSQLOTHER2_CHARGE_AMOUNT: TFloatField;
    HawbSQLFK_OTHER2_CHARGE_CODE: TStringField;
    HawbSQLPOSOSTOSIS: TStringField;
    HawbSQLTOTAL_DUTIES: TFloatField;
    HawbSQLCLEARANCE_WAITING_CODE: TStringField;
    HawbSQLCLEARANCE_WAITING_REASON: TStringField;
    HawbSQLDATE_CLEARED: TDateTimeField;
    HawbSQLDATE_REGISTERED: TDateTimeField;
    HawbSQLFACTOR: TFloatField;
    HawbSQLFK_COUNTRY_ORIGIN: TIntegerField;
    HawbSQLCHARGE_TRL: TFloatField;
    HawbSQLCHARGE_VAT: TFloatField;
    HawbSQLCHARGE_EXCISE: TFloatField;
    HawbSQLCHARGE_IMPORT: TFloatField;
    HawbSQLINVOICABLE: TStringField;
    HawbSQLTOTAL_CHARGES: TFloatField;
    HawbSQLCUSTOMER_NAME: TStringField;
    HawbSQLEDE_COMMENTS: TStringField;
    HawbSQLFK_MAWB_ID: TStringField;
    HawbSQLSIGNATORY_NAME: TStringField;
    HawbSQLXML_HOUSE_ID: TStringField;
    HawbSQLSENDER_NAME: TStringField;
    HawbSQLSENDER_ADDRESS_1: TStringField;
    HawbSQLSENDER_ADDRESS_2: TStringField;
    HawbSQLSENDER_ADDRESS_3: TStringField;
    HawbSQLIS_PRIVATE: TStringField;
    HawbSQLDELIVERY_ORDER_ID: TStringField;
    HawbSQLOTHER4_CHARGE_AMOUNT: TFloatField;
    HawbSQLFK_OTHER4_CHARGE: TStringField;
    HawbSQLIS_PAID: TStringField;
    HawbSQLPARTIAL_FLAG: TStringField;
    HawbSQLPARTIAL_WEIGHT: TFloatField;
    HawbSQLPARTIAL_DELIVERY_ORDER_ID: TStringField;
    HawbSQLPARTIAL_MAWB_ID: TStringField;
    HawbSQLPARTIAL_PIECES: TIntegerField;
    HawbSQLPARTIAL_MAWB_REFER_NUMBER: TIntegerField;
    HawbSQLSTATUS_C: TStringField;
    HawbSQLIS_MEDIUM: TStringField;
    HawbSQLMEDIUM_VAT_RATE: TFloatField;
    HawbSQLIS_CHARGED_DELIVERY: TStringField;
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
    Button5: TButton;
    IBCDataSource1: TIBCDataSource;
    DeleteTestSQL: TIBCScript;
    OpenDialog1: TOpenDialog;
    procedure ss1MailTransferApproved(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private Declarations }
    Function StripColon(Var1: String):String;
    Function   GetFileName:String;
    Procedure UpdateTable(TableStructure:TTableValues);
    Procedure InsertMawb;
    Procedure InsertHawb;
    Procedure InsertSenderInvoice;
    Procedure InsertItem;
  public
    { Public declarations }
    MawbTable:TTableValues;
    HawbTable:TTableValues;
    InvoiceTable:TTableValues;
    ItemTable:TTableValues;

  end;

var
  Form1: TForm1;

implementation

uses MainTest;


{$R *.DFM}


Procedure TForm1.InsertMawb;
Var
        Success:integer;
        TagRecord:TTagRecord;
        Count:Integer;
        I:Integer;
        ATable:TIBCQuery;
        AField:TField;
        FieldName:String;
Begin

{        AGraph.UpdateNode(TGMawb,'Shp','2031');
        AGraph.UpdateNode(TGMawb,'Tag5','2014-12-23');
}

       MawbSQL.Close;
       MawbSQL.OPen;
       MawbSQL.Insert;
//       UPdateTable(0,'MawbSQL');
       MawbSQL.FieldByName('PASSED').Value:='N';
       MawbSQL.FieldByName('INVOICED').Value:='N';
       MawbSQL.FieldByName('REFERENCE_YEAR').Value:='2031';//NEED TO FIND THAT

       MawbSQL.Post;

end;


Procedure TForm1.InsertHawb;
Var
        Success:integer;
        TagRecord:TTagRecord;
        Count:Integer;
        I:Integer;
        ATable:TIBCQuery;
        AField:TField;
        FieldName:String;
Begin
        {
        HawbTable.UpdateValue(0,'Shp','2031');
        HawbTable.UpdateValue(0,'Tag2','Y');
        HawbTable.UpdateValue(0,'Tag3','Y');
        HawbTable.UpdateValue(0,'Tag4','Y');
        HawbTable.UpdateValue(0,'Tag5','2014-12-23');
        }
{
       MawbSQL.Close;
       MawbSQL.OPen;
       MawbSQL.Insert;
}

       UPdateTable(HawbTable);

       HawbSQL.Post;

end;

Procedure TForm1.InsertSenderInvoice;
Var
        Success:integer;
        TagRecord:TTagRecord;
        Count:Integer;
        I:Integer;
        ATable:TIBCQuery;
        AField:TField;
        FieldName:String;
Begin

{
        AGraph.UpdateNode(TGMawb,'Shp','2031');
        AGraph.UpdateNode(TGMawb,'Tag2','Y');
        AGraph.UpdateNode(TGMawb,'Tag3','Y');
        AGraph.UpdateNode(TGMawb,'Tag4','Y');
        AGraph.UpdateNode(TGMawb,'Tag5','2014-12-23');
}

       MawbSQL.Close;
       MawbSQL.OPen;
       MawbSQL.Insert;
       //UPdateTable(2,'SenderInvoiceSQL');

       SenderInvoiceSQL.Post;

end;




Function TForm1.GetFileName:String;
Var
        Success:integer;
        DefaultDir:String;
Begin
        DefaultDir:= MainTestFRM.GetValueFromSystemTable('F_4', 'Default Dirictory');
        //CDefaultFile:=FieldByName('str_2').asString;
        OpenDialog1.InitialDir:=DefaultDir;
        OpenDialog1.Filter:='XML files (*.XML) | *.XML';
        with OpenDialog1 do begin
                if Execute then begin
                        Result:= Filename;
                end else begin
                        Result:='';
                        ShowMessage('No File was Selected');
                end; //execute
        end;{with}
        ShowMessage(Result);

End;

Procedure TForm1.InsertItem;
Var
        Success:integer;
        TagRecord:TTagRecord;
        Count:Integer;
        I:Integer;
        ATable:TIBCQuery;
        AField:TField;
        FieldName:String;
Begin

{
        AGraph.UpdateNode(TGMawb,'Shp','2031');
        AGraph.UpdateNode(TGMawb,'Tag2','Y');
        AGraph.UpdateNode(TGMawb,'Tag3','Y');
        AGraph.UpdateNode(TGMawb,'Tag4','Y');
        AGraph.UpdateNode(TGMawb,'Tag5','2014-12-23');
}

       MawbSQL.Close;
       MawbSQL.OPen;
       MawbSQL.Insert;
       //UPdateTable(3,'HawbItemSQL');

       HawbItemSQL.Post;

end;




Procedure TForm1.UpdateTable(TableStructure:TTableValues);
Var
        Success:integer;
        TagRecord:TTagRecord;
        Count:Integer;
        I:Integer;
        F:DOuble;
        ATable:TIBCQuery;
        AField:TField;
        TableName:String;
        FieldName:String;
        OldDS:char;
Begin


 TableStructure.GoFirstNode;
 while TableStructure.GetNextNode(TagRecord) do begin
        TableName:=TagRecord.TableName;
        ATable:=FindComponent(TableName) as TIBCQuery;

         FieldName:=TagRecord.FieldName;
        aField:=ATable.FindField(FieldName);
        If Assigned(AField) then begin

               case aField.DataType of
               ftInteger: begin
                        //ShowMessage('int '+aField.FieldName);
                        try
                                aField.Value := StrToIntDef(TagRecord.FIeldValue,0);
                        except
                                on Exception:  EConvertError do
                                        aField.Value:=0;
                        end;
                        end;
               ftFloat: begin
                        //ShowMessage('float '+aField.FieldName);
                        try
                                OldDS:=DecimalSeparator;
                                DecimalSeparator:='.';
                                F := StrToFloat(TagRecord.FIeldValue);
                                DecimalSeparator:=OldDS;
                        except
                                on Exception : EConvertError do
                                F:=0;
                        end;
                        aField.Value := F;
                        end;
               ftSmallInt: begin
                        ShowMessage('sma int '+aField.FieldName);
                        aField.Value := StrToIntDef(TagRecord.FIeldValue,0);
                        end;
               ftString:begin
                        aField.Value := TagRecord.FIeldValue;
                        //ShowMessage('string '+aField.FieldName);
                        end;
               ftDateTime:begin
                        aField.value:=ConvertDate(TagRecord.FieldValue);
                        //ShowMessage('date '+aField.FieldName);
                        end;
               end;

        end;
 end;

End;

Function TForm1.StripColon(Var1: String):String;
Var
 ColPos:Integer;
Begin
        ColPos:=Pos(':',Var1);
        Result:=Copy(Var1,ColPos+1,Length(Var1)-ColPos );

End;

procedure TForm1.ss1MailTransferApproved(Sender: TObject);
begin
SHowMessage('approved');
end;

procedure TForm1.Button1Click(Sender: TObject);
Var
        Success:integer;
        Count:Integer;
        I:Integer;
        S:String;
        D:TDateTime;

begin
DeleteTestSQL.ExecuteScript;

end;

procedure TForm1.Button2Click(Sender: TObject);
Var
  aTag :TTag;
  Full:String;
  SL:TStringList;
  i:Integer;

begin

SL:=TStringList.Create;
SL.AddObject('ab', TTag.Create('tag1','mawb','ab',false) );

aTag:=TTag(SL.Objects[SL.IndexOf('ab')]);
ShowMessage(aTag.GetFullName);


//Full:=TTag(SL. //IndexOf('ab'));

for i:=0 to SL.Count-1 do begin
        aTag:=TTag(SL.Objects[i]);
        aTag.Free;
end;
SL.Free;

end;

procedure TForm1.Button5Click(Sender: TObject);

VAR
  ItemState:TItemType;
  TheTag:String;
  Parser : TXmlParser;
  XmlFileName:String;
  x:string;
  TheContent:String;
  AHawb:THawb;
  PartType:TPartType;
  IsContent:Boolean;
  IsStartTag:Boolean;

  TagRecord:TTagRecord;
  IsGetTagValue:Boolean;
  IsEmptyTag:Boolean;


  OB:TObjectList;
  Si:TStackItem;
  I:Integer;

  eTag:String;
  STag:String;
  ItemType:TItemType;
  HawbSerial:Integer;
  MawbSerial:Integer;
  DefaultDir:String;
  TheFile:String;

BEGIN

        XmlFileName:=GetFileName;
        MawbTable:=TTableValues.Create;
        MawbTable.AddNode('ArrivalDate','MawbSQL','Date_Arrived',FALSE);


        HawbTable:=TTableValues.Create;
        HawbTable.AddNode('HAWB','HawbSQL','Hab_id',FALSE);
        //CstmsProcedureCdDate
        HawbTable.AddNode('GrossWgt','HawbSQL','weight',false);
        HawbTable.AddNode('DutyTaxFee','HawbSQL','tax',false);
        HawbTable.AddNode('ArrivalDateInDischarge','HawbSQL','DATE_REGISTERED',false);
        HawbTable.AddNode('InvoiceAmount','SenderInvoiceSQL','invoice_amount',false);



        ItemTable:=TTableValues.Create;
        ItemTable.AddNode('DutyTaxFeeRate','HawbItemSQL','fee rate',false);
        ItemTable.AddNode('Wdth','HawbItemSQL','dim width',false);

        OB:=TObjectList.Create(true);


  Parser := TXmlParser.Create;          // Create Parser Instance
  Parser.Normalize := TRUE; // (i.e. pack and trimm off Whitespaces)

//  XmlFilename:='E:\All\CabReadXML\Documentation\Test1.xml';
  Parser.LoadFromFile (XmlFilename);


  Parser.StartScan;
  //Dtls-Entries-Entry-(VanningPlace,Mvmts-Mvmt-TDOCS-TDOC-Shps-Shp-(HAWB,LineItems-LineItem, A lot of other fields)
  MawbSQL.Close;
  MawbSQL.Open;
  HawbSQL.Close;
  HawbSQL.open;
  SenderInvoiceSQL.Close;
  SenderInvoiceSQL.Open;

  IsGetTagValue:=False;
  IsContent:=False;
  IsStartTag:=False;
  ItemType:=itMawb;
  WHILE Parser.Scan DO begin

//***********************************************************************************
//******** Start Tag***************************************************************************
//***********************************************************************************
        if Parser.CurPartType=ptStartTag then begin
        //* From starttag we find
        //* the type of item (mawb, hawb, item) or if the tag is in the array and it is useful to read its content

                TheTag:=StripColon(Parser.Curname);
                IsGetTagValue:=False; // read the content after a tag only for tags in array
                IsStartTag:=True;
                If TheTag='Mvmt' then begin
                //************************************************************************
                //** we are now reading Mawb data
                //************************************************************************
                        ItemType:=itMawb;
                        ob.Add(TStackItem.Create('Mvmt',itMawb));
                        //ShowMessage('add '+TstackItem(ob.Items[ob.count-1]).State);
                        ItemType:=itMawb;
                        MawbSQL.Insert;
                        MawbSQL.FieldByName('REFERENCE_YEAR').Value:='2022';
                        MawbSQL.FieldByName('PASSED').Value:='N';
                        MawbSQL.FieldByName('SENT_TO_HEAD').Value:='N';
                        MawbSQL.FieldByName('INVOICED').Value:='N';
                        MawbSQL.Post;
                        MawbSerial:=MawbSQL.FieldByName('REFERENCE_NUMBER').AsInteger;
                end else If TheTag='Shp' then begin
                //************************************************************************
                //** we are now reading Hawb data
                //************************************************************************
                        ItemType:=itHawb;
                        ob.Add(TStackItem.Create('Shp',itHawb));
                        //ShowMessage('add '+TstackItem(ob.Items[ob.count-1]).State);
                        ItemType:=itHawb;

                        HawbSQL.Insert;
                        HawbSQL.FieldByName('hab_id').Value:='-1';
                        HawbSQL.FieldByName('FK_MAWB_REFER_NUMBER').Value:=MawbSerial;
                        HawbSQL.FieldByName('SENT_TO_HEAD').Value:='N';
                        HawbSQL.Post;
                        HawbSerial:=HawbSQL.FieldByName('serial_number').AsInteger;


                        SenderInvoiceSQL.Insert;
                        SenderInvoiceSQL.FieldByName('INVOICE_SERIAL').Value:=1;
                        SenderInvoiceSQL.FieldByName('INVOICE_number').Value:=1000;
                        SenderInvoiceSQL.FieldByName('FK_HAWB_SERIAL').Value:=HawbSerial;
                        SenderInvoiceSQL.FieldByName('invoice_amount').Value:=0;
                        SenderInvoiceSQL.FieldByName('is_valid').Value:='Y';
                        SenderInvoiceSQL.FieldByName('CURRENCY').Value:='EUR';
                        SenderInvoiceSQL.FieldByName('EXCHANGE_RATE').Value:=1;
                        SenderInvoiceSQL.Post;


                end else if (TheTag='LineItem') or (TheTag='Dim') then begin
                //************************************************************************
                //** we are now reading Hawb ITem data
                //************************************************************************
                        ItemType:=itItem;
                        ob.Add(TStackItem.Create('Item',itItem));
                        //ShowMessage('add '+TstackItem(ob.Items[ob.count-1]).State);

                end else begin
                //************************************************************************
                // Check if this StartTag is useful
                //************************************************************************

                        if ItemType=itMawb then begin
                                if MawbTable.FindNode(TheTag,tagRecord) then begin
                                        IsGetTagValue:=True;
                                        //ShowMessage('found useful tag='+TheTag+' '+TagRecord.TagName);
                                end;
                        end else if ItemType=itHawb then begin
                                if hawbTable.FindNode(TheTag,tagRecord) then begin
                                        IsGetTagValue:=True;
                                        //ShowMessage('found useful tag='+TheTag+' '+TagRecord.TagName);
                                end;
                        end else if ItemType=itItem then begin
                                if ItemTable.FindNode(TheTag,tagRecord) then begin
                                        IsGetTagValue:=True;
                                        //ShowMessage('found useful tag='+TheTag+' '+TagRecord.FieldName);
                                end;
                        end;

                end;
//***********************************************************************************
//******** End Tag***************************************************************************
//***********************************************************************************

        end else if Parser.CurPartType=ptEndTag then begin
                TheTag:=StripColon(Parser.Curname);
                IsGetTagValue:=False;
                If (TheTag='Mmvt') or (TheTag='Shp') or (TheTag='LineItem') Or (TheTag='Dim') then begin
                        // Pop out last stack item to find what item was read before
                        ob.Delete(ob.count-1);
                        If ob.Count>0 then begin
                                ItemType:= TstackItem(ob[ob.count-1]).ItemType;
                                If ItemType=itHawb then
                                        //ShowMessage('after delete = hawbl');
                                If ItemType=ititem then
                                        //ShowMessage('after delete = item');
                        end;
                end;

                If TheTag='Mvmt' then begin
                        MawbSQL.Edit;
                         UpdateTable(MawbTable);
                         MawbSQL.Post;
                end else If TheTag='Shp' then begin
                        // do your stuff, update the hawb
                        //Si:=ob.last;
                        HawbSQL.Edit;
                        SenderInvoiceSQL.Edit;
                         UpdateTable(HawbTable);
                        HawbSQL.Post;
                        SenderInvoiceSQL.Post;
                end else if (TheTag='LineItem') or (TheTag='Dim') then begin
                        // do your stuff, insert the hawb item
                end else begin
                end;

        end else if Parser.CurPartType=ptContent then begin
//***********************************************************************************
//******** COntent***************************************************************************
//***********************************************************************************
                If ISGetTagValue then begin
                        IsGetTagValue:=False;
                        //raph.GetNode(CurrentState,theTag,TagRecord);
                        if ItemType=itMawb then begin
                                ShowMessage('Mawb- '+TagRecord.TagName+' update =*'+ Parser.CurContent+'*');
                                MawbTable.UpdateValue(TheTag,Parser.CurContent);
                        end else if ItemType=itHawb then begin
                                ShowMessage('Hawb- '+TagRecord.TagName+' update =*'+ Parser.CurContent+'*');
                                HawbTable.UpdateValue(TheTag,Parser.CurContent);
                        end else if ItemType=itItem then begin
                                ShowMessage('Hawb item- '+TagRecord.TagName+' update =*'+ Parser.CurContent+'*');
                                ItemTable.UpdateValue(TheTag,Parser.CurContent);
                        end;
                end;
        //end else begin
        end;


end; //while

  HawbTable.GoFirstNode;
  {
  While HawbTable.GetNextNode(tagRecord) do begin
        ShowMessage(tagRecord.FieldName);
  end;
  While ItemTable.GetNextNode(tagRecord) do begin
        ShowMessage(tagRecord.FieldName);
  end;
  }
{
  For I:=0 to ob.Count-1 do begin
        si:=TStackItem(ob.Items[i]);
        ShowMessage('deleting state:'+si.State);
  end;
}
  Parser.Free;
  ob.Free;
//  AGraph.Destroy;
End;


procedure TForm1.Button4Click(Sender: TObject);
Var
        IDate:Integer;
        DDate:TDateTime;
begin
        DDate:=ConvertDate('2000-01-01');
        ShowMessage(FloatToStr(DDate));

end;

end.
