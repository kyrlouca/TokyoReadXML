unit I_readHawbFileNewVersion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IBC, MemDS, IBCError, StdCtrls, ComCtrls, ExtCtrls, Buttons, Wwtable, Wwquery,
  wwstorep, fcButton, fcImgBtn, fcShapeBtn, Mask, wwdbedit, Grids,
  Wwdbigrd, Wwdbgrid, DBAccess, Db,typInfo, DAScript, IBCScript;


Const
        MAXWORDS=100;
type
  TAllSerials=Record
        MawbID:String;
        HawbID:String;
        MawbSerial:Integer;
        HawbSerial:Integer;
        SenderInvoiceSerial:Integer;
        ItemSerial:Integer;
        IsPartial:Boolean;
  end;

  TDefaultCharges=Record
     CEdeCharge:Double;
     CDeliveryExpenses:double;
     CStorageExpenses:Double;
  end;

  TMawbRecordLine= Record
        ReportDate:TDate;
        MNumber:String;
        OriginArea:String;
        OriginCountry:String;
        DestinationArea:String;
        DestinationCountry:String;
        DepartureDate:TDate;
        WeightUnit:String;
        ManifestSection:String;
        ScheduledArriveDate:Tdate;
        ReportTemplate:String;
        MovementKey:String;

        RotationYear:Integer;
        ReferenceYear:Integer;
        ArrivalDate:Tdate;
        FormDate:TDate;
  end;



  TAirwaybillLine=Record
        Sequence:Integer;

        SenderName:String;
        SenderAddress:String;
        SenderPostcode:String;
        SenderCity:string;
        SenderCountryCode:String;

        ConsigneeName:String;
        ConsigneeAddress:String;
        ConsigneePostcode:String;
        ConsigneeCity:String;
        ConsigneeCountryCode:String;

        XCurrency:String;
        YFreight:Double;
        YCurrencyCode:string;
        YExchangeRate:double;
        YOriginCountry:Integer;

        Amount:Double;
        SenderPhone:String;
        ConsigneePhone:String;

        ItemsCount:Integer;
        IsMedium:Boolean;



        TransportDoc:String;
        HawbId:String;
        ShipmentOriginArea:String;
        ShipmentOriginCountry:String;
        Pieces:Integer;
        PiecesS:String;
        Weight:Double;
        Description:String;
        PaymentMethod:String;
  end;

  TAirwayBillItemLine=Record
        Sequence:Integer;
        Description:String;
        Weight:Double;
        Pieces:Integer;
  end;
  TCountryDetails=Record
        CountryCode:string;
        CountryNumber:Integer;
        LowFreight:double;
        HighFreight:double;
  end;


  TWordsArray=array[0..MAXWORDS]of String;

  TLineState=(START,WAIT,CAIR,CIAR,CABI,ERRR);
  TLineTYpe=(Mawb,Hawb,Item);
  TStateArray = Array [TlineState,TlineType] of TLineState;

  TI_ReadManifestFileNewVersionFRM = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    Panel3: TPanel;
    ReadFileBTN: TfcShapeBtn;
    SystemParametersSQL: TIBCQuery;
    SystemParametersSQLPARAMETER_ID: TStringField;
    SystemParametersSQLINT_1: TIntegerField;
    SystemParametersSQLINT_2: TIntegerField;
    SystemParametersSQLSTR_1: TStringField;
    SystemParametersSQLSTR_2: TStringField;
    HawbSQL: TIBCQuery;
    HawbItemSQL: TIBCQuery;
    UpdateTrans: TIBCTransaction;
    MawbUpdateTrans: TIBCTransaction;
    AirwaybillUpdateTrans: TIBCTransaction;
    ItemUpdateTrans: TIBCTransaction;
    UpdateHawbDescSQL: TIBCSQL;
    MawbSQL: TIBCQuery;
    SmallintField1: TSmallintField;
    IntegerField1: TIntegerField;
    DateTimeField1: TDateTimeField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    StringField1: TStringField;
    DateTimeField2: TDateTimeField;
    StringField2: TStringField;
    StringField3: TStringField;
    IntegerField4: TIntegerField;
    SmallintField2: TSmallintField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    DateTimeField3: TDateTimeField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    FloatField7: TFloatField;
    IntegerField11: TIntegerField;
    FloatField8: TFloatField;
    IntegerField12: TIntegerField;
    FloatField9: TFloatField;
    IntegerField13: TIntegerField;
    FloatField10: TFloatField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    SearchMawbSQL: TIBCQuery;
    SearchMawbSQLMAWB_ID: TStringField;
    CountrySQL: TIBCQuery;
    CountrySQLNUMBER: TIntegerField;
    CountrySQLCODE: TStringField;
    CountrySQLNAME: TStringField;
    CountrySQLEU_MEMBER: TStringField;
    CountrySQLFREIGHT05: TIntegerField;
    CountrySQLFREIGHT6: TIntegerField;
    CountrySQLFK_CURRENCY_CODE: TStringField;
    CountrySQLGREEK_NAME: TStringField;
    CountrySQLXML_COUNTRY: TStringField;
    CurrencyExchangeSQL: TIBCQuery;
    CurrencyExchangeSQLDESCRIPTION: TStringField;
    CurrencyExchangeSQLCURRENCY_CODE: TStringField;
    CurrencyExchangeSQLCOUNTRY_CODE: TIntegerField;
    CurrencyExchangeSQLXML_CURRENCY: TStringField;
    CurrencyExchangeSQLFK_CURRENCY_CODE: TStringField;
    CurrencyExchangeSQLRATE: TFloatField;
    FindDeliveryOrderChargeSQL: TIBCQuery;
    FindDeliveryOrderChargeSQLAMOUNT: TFloatField;
    ReadOnly: TIBCTransaction;
    MawbFLD: TwwDBEdit;
    Button1: TButton;
    FdeleteOneSQL: TIBCQuery;
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
    HawbItemSQLEURO_PENDING: TStringField;
    HawbItemSQLFK_SENDER_INVOICE_SERIAL: TIntegerField;
    HawbItemSQLMULTI_ITEMS_INVOICE: TStringField;
    HawbItemSQLINVOICE_LINE: TIntegerField;
    HawbItemSQLPRE_DISCOUNT_AMOUNT: TFloatField;
    HawbItemSQLWEIGHT_NET: TFloatField;
    PartialHawbSQL: TIBCQuery;
    SearchHawbSQL: TIBCQuery;
    SearchHawbSQLHAB_ID: TStringField;
    SearchHawbSQLSERIAL_NUMBER: TIntegerField;
    SearchHawbSQLFK_MAWB_REFER_NUMBER: TIntegerField;
    SearchHawbSQLFK_MAWB_ID: TStringField;
    PartialHawbSQLSERIAL_NUMBER: TIntegerField;
    PartialHawbSQLFK_MAWB_SERIAL_ORIGINAL: TIntegerField;
    PartialHawbSQLFK_MAWB_ID_ORIGINAL: TStringField;
    PartialHawbSQLFK_MAWB_SERIAL_ARRIVED: TIntegerField;
    PartialHawbSQLFK_MAWB_ID_ARRIVED: TStringField;
    PartialHawbSQLFK_HAWB_SERIAL_ORIGINAL: TIntegerField;
    PartialHawbSQLFK_HAWB_ID_ORIGINAL: TStringField;
    PartialHawbSQLPARTIAL_PIECES: TIntegerField;
    PartialHawbSQLPARTIAL_DELIVERY_ORDER_ID: TStringField;
    PartialHawbSQLPARTIAL_WEIGHT: TFloatField;
    PartialHawbSQLDESCRIPTION: TStringField;
    Button2: TButton;
    IBCScript1: TIBCScript;
    Button3: TButton;
    Button4: TButton;
    UpdateHawbTypeSQL: TIBCSQL;
    SystemParametersSQLNUM_1: TFloatField;
    HawbSQLSTATUS_C: TStringField;
    HawbSQLIS_MEDIUM: TStringField;
    HawbSQLMEDIUM_VAT_RATE: TFloatField;
    procedure ReadFileBTNClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AirwayBillSQLNewRecord(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    GMawbSerial:Integer;
    MediumValueMin,MediumValueMax:Integer;
    Function GetOneSystemParameter(TheKey,TheDescription:String;var Int1,Int2:Integer;var Num1:Double; Var Str1,str2:String):Boolean;

    Function InsertMawb(MawbRecordLine:TMawbRecordLine;Var AllSerials:TAllSerials):Integer;
    Function InsertHawb(Var Airwaybill:TAirwayBillLine;DefaultCharges:TDefaultCharges;Var AllSerials:TAllSerials):Integer;
    Function InsertSenderInvoice(Var Airwaybill:TAirwaybillLine;Var AllSerials:TAllSerials):Integer;
//    Function InsertHawbItem(AirwaybillItem:TAirwayBillItemLine;Var AllSerials:TAllSerials):Integer;
    Function InsertHawbItem(Airwaybill:TAirwaybillLine ;AirwaybillItem:TAirwayBillItemLine;Var AllSerials:TAllSerials):Integer;

    Function InsertFakeItem(Airwaybill:TAirwayBillLine;Var AllSerials:TAllSerials):Integer;

    Function IncrementItems(AllSerials:TAllSerials):boolean;


    Function PrepareMawbRecord(RWordsArray:TWordsArray;Var MawbRecordLine:TMawbRecordLine):Boolean;
    Function PrepareHawbRecord(RWordsArray:TWordsArray;Var RAirwaybill:TAirwaybillLine):Boolean;
    Function PrepareHawbItemRecord(RWordsArray:TWordsArray;Var RItemLine:TAirwayBillItemLine):Boolean;

    procedure FindCountry(CountryCode:String;Var CountryDetails:TCountryDetails);
    procedure FindDefaultCharges(Var DefaultCharges:TDefaultCharges);


    Function GetSystemParameters(TheKey:String):Boolean;

    Function RemoveQuotes(TheString:String):String;
    Function ConvertDate(TheString:String):TDate;
    Function ConvertDateTime(TheDate,TheTime:String):TDate;
    procedure ReplaceComma(Var TheString :String);
    function SafeStringToFloat(TheString:String):Double;
    function UniversalStrToFloat(TheString:String):Double;

    Function OpenFile(Var InFile:TextFile):Boolean;
    Function ReadOneLine(Var InFile:TextFile; Var TheLine:String):Boolean;
    Function ParseLine(TheLine:String;Var MyWordsArray:TWordsArray):Integer;
    Function GetWord(TheString:String;StartingPos:Integer;Var TheWord :String;Var NewStartingPos:Integer):Boolean;


  end;

  Var
  I_ReadManifestFileNewVersionFRM: TI_ReadManifestFileNewVersionFRM;


implementation


Var
   TheStringList: TStringList;
{$R *.DFM}


procedure TI_ReadManifestFileNewVersionFRM.FindDefaultCharges(Var DefaultCharges:TDefaultCharges);
Begin
     with FIndDeliveryOrderChargeSQL do
     begin
        close;
        if not prepared then prepare;
        ParamByName('TheCode').Value:='D2';
        open;
        if IsEmpty then
        begin
                ShowMessage('Add a D2 record in other_charge table for D/O Ede charge');
                abort;
        end;
        DefaultCharges.CEdeCharge:=FieldByName('amount').asFloat;
     end;

     with FIndDeliveryOrderChargeSQL do
     begin
        close;
        if not prepared then prepare;
        ParamByName('TheCode').Value:='D3';
        open;
        if IsEmpty then
        begin
                ShowMessage('Add a D3 record in other_charge table for Delivery Charges');
                abort;
        end;
        DefaultCharges.CDeliveryExpenses:=FieldByName('amount').asFloat;
     end;

     with FIndDeliveryOrderChargeSQL do
     begin
        close;
        if not prepared then prepare;
        ParamByName('TheCode').Value:='D4';
        open;
        if IsEmpty then
        begin
                ShowMessage('Add a D4 record in other_charge table for Storage Charges');
                abort;
        end;
        DefaultCharges.CStorageExpenses:=FieldByName('amount').asFloat;
     end;


end;





Function TI_ReadManifestFileNewVersionFRM.PrepareMawbRecord(RWordsArray:TWordsArray;Var MawbRecordLine:TMawbRecordLine):Boolean;
Var
        DateF:TDate;
        DateTimeF:TTimestamp;
        DateStr:String;
        TheYear,theMonth,TheDay:Word;
Begin
        MawbRecordLine.ReportDate:=         ConvertDate(RwordsArray[3]);
        MawbRecordLine.ArrivalDate:=   now;
        MawbRecordLine.FormDate:=    ConvertDate(RwordsArray[3]);

        DecodeDate(MawbRecordLine.ArrivalDate,TheYear,TheMonth,TheDay);
        MawbRecordLine.RotationYear:=TheYear;
        MawbRecordLine.ReferenceYear:=TheYear;


        MawbRecordLine.MNumber:=            RwordsArray[5];
        MawbRecordLine.OriginArea:=         RwordsArray[6];
        MawbRecordLine.OriginCountry:=      RwordsArray[7];
        MawbRecordLine.DestinationCountry:= RwordsArray[8];
End;




Function TI_ReadManifestFileNewVersionFRM.PrepareHawbRecord(RWordsArray:TWordsArray;Var RAirwaybill:TAirwayBillLine):Boolean;
Var
        Temp,S1:String;
        Pp:Integer;
        cc:integer;
Begin
        RAirwayBill.HawbID:=                    RwordsArray[5];
        RAirwayBill.ShipmentOriginCountry:=     RwordsArray[8];
        RAirwayBill.PiecesS:=                   RwordsArray[11];

        S1:=RAirwayBill.PiecesS;
        PP:=Pos('\',s1);
        cc:=Length(s1)-pp;

        Temp:=Copy(S1,(Pp+1),cc );
        Try
                Rairwaybill.Pieces:= StrToInt(Temp);
        except
                RAirwayBill.Pieces:=0;
        end;

        try RAirwayBill.Weight:=        StrToFLoat(RwordsArray[12])except RAirwayBill.Weight:=0; end;
        RAirwayBill.Description:=       RwordsArray[13];     // it's ok

        try RAirwayBill.Amount:=                StrtoFLoat(RwordsArray[14]) except RAirwaybill.Amount:=0;end;
        RAirwayBill.XCurrency:=                 RwordsArray[15];

        RAirwaybill.SenderName:=        RwordsArray[16];   //ok
        RAirwaybill.SenderAddress:=     Trim(RwordsArray[18])+', '+Trim(RwordsArray[19])+', '+Trim(RwordsArray[20]);
        RAirwaybill.SenderPostcode:=    RwordsArray[21];
        RAirwaybill.SenderCity:=        RwordsArray[22];
        RAirwaybill.SenderCountryCode:= RwordsArray[24];
        RAirwaybill.SenderPhone:=      RwordsArray[25];


        RAirwaybill.ConsigneeName:=     RwordsArray[27];
        RAirwaybill.ConsigneeAddress:=  Trim(RwordsArray[28])+', '+Trim(RwordsArray[29])+', '+Trim(RwordsArray[30]);
        RAirwaybill.ConsigneePostcode:= RwordsArray[31];
        RAirwaybill.ConsigneeCity:=     RwordsArray[30];
        RAirwaybill.ConsigneeCountryCode:=             RwordsArray[34];
        RAirwaybill.ConsigneePhone:=    RwordsArray[35];


End;

Function TI_ReadManifestFileNewVersionFRM.PrepareHawbItemRecord(RWordsArray:TWordsArray;Var RItemLine:TAirwayBillItemLine):Boolean;
Begin
        try RItemLine.Sequence:=        StrToInt (RwordsArray[2])except RItemLine.Sequence:=0; end;
        RItemLine.Description:=         RwordsArray[4];
//        try RItemLine.Weight:=          StrToFLoat(RwordsArray[5])except RItemLine.Weight:=0; end;
        try RItemLine.Pieces:=          StrtoInt(RwordsArray[7])except RItemLIne.Pieces:=0;end;
//        RItemLine.xCurrency:=           RwordsArray[10];
End;


//////////////////////////////////////////////////////////////
//*** INSERT procedures
//////////////////////////////////////////////////////////////

Function TI_ReadManifestFileNewVersionFRM.IncrementItems(AllSerials:TAllSerials):boolean;
Begin
End;

Function TI_ReadManifestFileNewVersionFRM.InsertMawb(MawbRecordLine:TMawbRecordLine;Var AllSerials:TAllSerials):Integer;
Var
        Dataset:TDataset;
        ReferenceNumber:integer ;
        MawbIdNumber:Int64;
        MawbId:String;
        GoodsNumber:Integer;
        GoodsWeight:Double;
        IsExists:Boolean;
        CountryDetails:TcountryDetails;
Begin
     Dataset:=MawbSQL;

     If Dataset.Active then begin
        Dataset.Close;
     end;
     Dataset.open;
     Dataset.Insert;

     ReferenceNumber:=MawbSQL.FieldByName('REFERENCE_NUMBER').asInteger;


     Try
        MawbIdNumber :=ReferenceNumber; //if invalid mawbid set its value to 123
        MawbId:=IntToStr(MawbIdNumber);
     except
        MawbId:='123';
     end;

//             Screen.ActiveForm.Close;

     GoodsNumber:=0; //StrToInt(TheArray[3]);
     GoodsWeight:=0; //StrToFloat(TheArray[3]);


     Dataset.FieldByName('REFERENCE_NUMBER').value:=ReferenceNumber;
     Dataset.fieldbyname('MAWB_ID').Value:=MawbId;


     FindCountry(MawbrecordLine.OriginCountry,CountryDetails);
     Dataset.fieldbyname('FK_country_consignee').Value:=CountryDetails.CountryNumber;
     Dataset.fieldbyname('ROTATION_YEAR').Value:=MawbRecordLine.RotationYear;
     Dataset.fieldbyname('Reference_year').Value:=MawbRecordLine.ReferenceYEar;
     Dataset.fieldbyname('DATE_ARRIVED').AsDateTime:=MawbRecordLine.ArrivalDate;
     Dataset.fieldbyname('FORM_DATE').AsDateTime:=MawbRecordLine.FormDate;


     Dataset.fieldbyname('FK_PORT_IMPORTATION').asinteger:=6;
     Dataset.fieldbyname('FK_PORT_Clearing').Value:=6;
     Dataset.fieldbyname('Signatory_Name').Value:='';
     Dataset.fieldbyname('SENT_TO_HEAD').Value:='N';
     Dataset.fieldbyname('INVOICED').Value:='N';
     Dataset.fieldbyname('PASSED').Value:='N';


     Dataset.fieldbyname('AMOUNT_INVOICED').Value:=0;
     Dataset.fieldbyname('AMOUNT_NOT_INVOICED').Value:=0;


     Dataset.fieldbyname('GOODS_NUMBER').Value:=GoodsNumber;
     Dataset.fieldbyname('GOODS_WEIGHT').Value:=GoodsWeight;
     Dataset.fieldbyname('MEDIUM_VALUE_NUMBER').Value:=GoodsNumber;
     Dataset.fieldbyname('MEDIUM_VALUE_WEIGHT').Value:=GoodsWeight;
     Dataset.fieldbyname('LOW_VALUE_NUMBER').Value:=0;
     Dataset.fieldbyname('LOW_VALUE_WEIGHT').Value:=0;
     Dataset.fieldbyname('HIGH_VALUE_NUMBER').Value:=0;
     Dataset.fieldbyname('HIGH_VALUE_WEIGHT').Value:=0;
     Dataset.fieldbyname('DOCS_NUMBER').Value:=0;
     Dataset.fieldbyname('DOCS_WEIGHT').Value:=0;

     Dataset.fieldbyname('FK_PORT_Clearing').asinteger:=6;
     Dataset.fieldbyname('FK_PORT_IMPORTATION').asinteger:=6;
     Dataset.fieldbyname('GOODS_DESCRIPTION').asString:='Bags';
     Dataset.fieldbyname('Signatory_Name').asstring:=' ';

     AllSerials.MawbSerial:=Dataset.FieldByName('REFERENCE_NUMBER').AsInteger;
     AllSerials.MawbID:=Dataset.fieldbyname('MAWB_ID').AsString;

     Dataset.Post;
     Dataset.Close;

     Result:=ReferenceNumber;

End;





Function TI_ReadManifestFileNewVersionFRM.InsertHawb(Var Airwaybill:TAirwayBillLine;DefaultCharges:TDefaultCharges;Var AllSerials:TAllSerials):Integer;
Var
   CountryDetails:TCountryDetails;
   Dataset:TDataset;
//   HawbSerial:Integer;
   IsHawbExists:Boolean;
   HPOriginalHawbSerial:Integer;
   HPOriginalMawbSerial:Integer;
   HPOriginalMawbid :String;

begin



     with SearchHawbSQL do begin
          Close;
          If not Prepared Then Prepare;
          ParamByName('HabId').Value:= Airwaybill.HawbId;
          Open;
          HPOriginalHawbSerial:=FieldByName('Serial_number').AsInteger;
          HPOriginalMawbSerial:= FieldByName('fk_mawb_refer_number').AsInteger;
          HPOriginalMawbid :=FieldByName('FK_mawb_id').AsString;
          IsHawbExists:=NOt IsEmpty;
     end;

     IF isHawbExists then begin
        with PartialHawbSQL do begin
                close;
                if not PartialHawbSQL.Active then open;

                Insert;

                FieldByName('FK_HAWB_SERIAL_ORIGINAL').value:=HPOriginalHawbSerial ;
                FieldByName('FK_HAWB_ID_ORIGINAL').value:=Airwaybill.HawbId;

                FieldByName('FK_MAWB_SERIAL_ORIGINAL').value:=HPOriginalMawbSerial;
                FieldByName('FK_MAWB_ID_ORIGINAL').value:= HPOriginalMawbid;

                FieldByName('FK_MAWB_SERIAL_ARRIVED').value:=Allserials.MawbSerial;
                FieldByName('FK_MAWB_ID_ARRIVED').value:= AllSerials.MawbID;


                FieldByName('PARTIAL_WEIGHT').value:= Airwaybill.Weight;
                FieldByName('PARTIAL_PIECES').value:=Airwaybill.Pieces;
                FieldByName('PARTIAL_DELIVERY_ORDER_ID').value:=Airwaybill.HawbId;
                FieldByName('DESCRIPTION').value:=Airwaybill.Description;

                AllSerials.IsPartial:=True;
                post;
                close;

        end;

        EXIT;
     end;



     FindCountry(Airwaybill.SenderCountryCode,CountryDetails);
     Airwaybill.YOriginCountry:=CountryDetails.CountryNumber;


     Result:=0;
     Dataset:=HawbSQL;

     If not Dataset.Active then Dataset.open;

     Dataset.Insert;

     Dataset.fieldbyname('hab_ID').Value:=AirwayBill.HawbId;

     AllSerials.HawbSerial:=Dataset.FieldByName('SERIAL_NUMBER').value;
     Dataset.fieldbyname('FK_MAWB_ID').Value:=AllSerials.MawbID;
     Dataset.fieldbyname('fk_mawb_refer_number').Value:=AllSerials.MawbSerial;

     Dataset.FieldByName('DELIVERY_ORDER_AMOUNT').Value:=DefaultCharges.CEdeCharge;
     Dataset.FieldByName('Ede_Delivery_Expenses').Value:= DefaultCharges.CDeliveryExpenses;
     Dataset.FieldByName('Ede_Storage_Expenses').Value:=  DefaultCharges.CStorageExpenses;

     Dataset.FieldByName('STAMPS_AMOUNT').Value:=0;


     Dataset.FieldByName('SENT_TO_HEAD').Value:='N';
     Dataset.FieldByName('High_value').Value:='Y';
     Dataset.FieldByName('Other_charge_Paid').Value:='N';
     Dataset.FieldByName('Fk_clearing_state').value:=0;

     Dataset.FieldByName('Fk_clearance_type').value:='IM 4';

     Dataset.FieldByName('FK_DELIVERY_TERM').Value:='FOB';
     Dataset.FieldByName('Fk_invoice_status').value:=0;
     DataSet.FieldByNAME('Date_Registered').value:=date;
     Dataset.FieldByName('High_Value').Value:='Y';
     Dataset.FieldByName('IS_Private').Value:='Y';
     Dataset.FieldByName('IS_MEDIUM').Value:='N';

     Dataset.FieldByName('Description').value:=Airwaybill.Description; //will get final value from Hawb iTEM if there is one
     Dataset.FieldByName('Customer_name').Value:=Airwaybill.ConsigneeName;
     Dataset.FieldByName('Sender_name').Value:=Airwaybill.SenderName;
     Dataset.FieldByName('SENDER_ADDRESS_1').Value:=Airwaybill.SenderAddress;
     Dataset.FieldByName('SENDER_ADDRESS_2').Value:=Airwaybill.SenderPostcode;
     Dataset.FieldByName('SENDER_ADDRESS_3').Value:=Airwaybill.SenderCity;

     Dataset.FieldByName('Weight').Value:=AIrwaybill.Weight;
     Dataset.FieldByName('FK_COUNTRY_ORIGIN').Value:=Airwaybill.YOriginCountry;    //*************

     Dataset.FieldByName('NUM_OF_PIECES_ARRIVED').Value:=AirwayBill.Pieces;
     Dataset.FieldByName('NUMBER_OF_PARCELS').Value:=AirwayBill.Pieces; //may need to change that
     AllSerials.IsPartial:=false;

     Dataset.Post;
     Dataset.Close;

     Result:=     Dataset.FieldByName('serial_number').AsInteger;

end;



//**************************** The sender Invoice



Function TI_ReadManifestFileNewVersionFRM.InsertSenderInvoice(Var Airwaybill:TAirwaybillLine;Var AllSerials:TAllSerials):Integer;
Var
        CountryDetails:TCountryDetails;



   TheRate,FreightCYP,InvoiceForeign,Factor:Double;
   TotalForeignAmount:Double;
   AfterDiscountAmount,PreDiscountAmount:Double;
   OriginalInvoice:Double;
   TheDiscountRate:Double;
   TheDiscount:Double;
   FreightAmount,InsuranceAmount,OtherChargesAmount:Double;
   CustomsValue:Double;


Begin
     If AllSerials.IsPartial then begin
        Result:=0;
        EXIT;
     end;

     FindCountry(Airwaybill.SenderCountryCode,CountryDetails);

     with CurrencyExchangeSQL do begin
          Close;
          If not Prepared Then Prepare;
          ParamByName('InCurrency').Value:=Airwaybill.XCurrency;
          Open;
          If (not IsEmpty) then begin
             Airwaybill.YCurrencyCode:=FieldByName('CURRENCY_CODE').AsString;
             Airwaybill.YExchangeRate:=FieldByName('Rate').AsFloat;
          end else begin
             Airwaybill.YCurrencyCode:='EUR';
             Airwaybill.YExchangeRate:=1;
          end;
          close;
     end;


     If  Airwaybill.Weight <=5 then
        Airwaybill.YFreight:=CountryDetails.LowFreight*Airwaybill.Weight
     else
         Airwaybill.YFreight:=CountryDetails.HighFreight*Airwaybill.Weight;

     If SenderInvoiceSQL.Active then begin
        SenderInvoiceSQL.Close;
     end;
     SenderInvoiceSQL.Open;
     SenderInvoiceSQL.Insert;


     SenderInvoiceSQL.FieldByName('IS_VALID').Value:='Y'; //not really needed any more
     SenderInvoiceSQL.FieldByName('Fk_HAWB_SERIAL').value:=AllSErials.HawbSerial;
     SenderInvoiceSQL.FieldByName('Fk_MAWB_SERIAL').value:=AllSErials.MawbSerial;
     SenderInvoiceSQL.FieldByName('Fk_hAWB_id').value:=AllSerials.hawbId;
     SenderInvoiceSQL.FieldByName('Invoice_serial').value:=1;

     SenderInvoiceSQL.FieldByName('Invoice_Number').value:='1';
     SenderInvoiceSQL.FieldByName('PRE_DISCOUNT_Amount').value:=AIrwaybill.Amount;
     // check amount and if less than xxx then hawb.fk_clearing_type = 'MED';


     SenderInvoiceSQL.FieldByName('INVOICE_Amount').value:=AIrwaybill.Amount;




     SenderInvoiceSQL.FieldByName('Currency').value:=Airwaybill.YCurrencyCode;
     SenderInvoiceSQL.FieldByName('exchange_rate').value:=AIrwaybill.YExchangeRate;

     SenderInvoiceSQL.FieldByName('freight_cyp_amount').value:=AIrwaybill.YFreight;

     //**********************************************
     with SenderInvoiceSQL do begin
        TheDiscountRate:=FieldByName('DISCOUNT_RATE').AsFloat;
        PreDiscountAmount:=FieldByName('PRE_DISCOUNT_AMOUNT').AsFloat;
        FreightAmount:=FieldByName('FREIGHT_AMOUNT').AsFloat;
        InsuranceAmount:=FieldByName('INSURANCE_AMOUNT').AsFloat;
        OtherChargesAmount:=FieldByName('OTHER_CHARGES_AMOUNT').AsFloat;
        TheRate:=FieldByName('EXCHANGE_RATE').AsFloat;
        FreightCYP:=FieldByName('FREIGHT_CYP_AMOUNT').AsFloat;

        TheDiscount:=TheDiscountRate*PreDiscountAmount/100.00;
        AfterDiscountAmount:=PreDiscountAmount- TheDiscount;

        TotalForeignAmount:=AfterDiscountAmount+FreightAmount+InsuranceAmount+OtherChargesAmount;

        try
          Factor:= ((TotalForeignAmount / TheRate)+ FreightCYP)/AfterDiscountAmount;
        except on EMathError do
          Factor:=0;
        end;

{        FieldByName('DiscountAmountCalc').Value:=TheDiscount;
        FieldByName('AfterDiscountAmount').Value:=AfterDiscountAmount;
        FieldByName('TotalForeignAmount').Value:=TotalForeignAmount;
        FieldByName('TheFactor').AsFloat:=Factor;
        FieldByName('TheCustomsValue').Value:=Round(Factor*AfterDiscountAmount)*100.00/100.00;
        }
        CustomsValue:=Round(Factor*AfterDiscountAmount)*100.00/100.00;
        if (CustomsValue<0.00) then
                CustomsValue:=0.000;

        FieldByName('Customs_Value').Value:=CustomsValue;

        Airwaybill.IsMedium:=False;
        if (not AllSerials.IsPartial) and  (CustomsValue > MediumValueMin)and(CustomsValue < MediumValueMax) then begin
          Airwaybill.IsMedium:=True;
        //ShowMessage('Amount' + FloatToSTr(Airwaybill.Amount) +' is less than '+ IntToStr(MediumValueMin));
          With UPdateHawbTypeSQL do begin
                ParamByName('HawbSerial').Value:=AllSerials.HawbSerial;
                ParamByName('CustomsValue').Value:=CustomsValue;    
                Execute;
          end;
        end;


     end;

     //**********************************************




     AllSerials.SenderInvoiceSerial:= SenderInvoiceSQL.FieldByName('Invoice_Number').AsINteger;

      SenderInvoiceSQL.Post;
      SenderInvoiceSQL.Close;


End;

Function TI_ReadManifestFileNewVersionFRM.InsertHawbItem(Airwaybill:TAirwaybillLine;AirwaybillItem:TAirwayBillItemLine;Var AllSerials:TAllSerials):Integer;
Var
   Dataset:TDataset;
begin

     If AllSerials.IsPartial then begin
        Result:=0;
        EXIT;
     end;

    Dataset:=HawbItemSQL;
     If Dataset.Active then begin
        Dataset.Close;
     end;
     Dataset.Open;
     Dataset.Insert;

     Dataset.fieldbyname('FK_Hawb_serial').Value:=Allserials.HawbSerial;
     Dataset.fieldbyname('FK_Mawb').Value:=Allserials.MawbSerial;
     Dataset.fieldbyname('FK_Sender_invoice_serial').Value:=allserials.SenderInvoiceSerial;

     Dataset.FieldByName('INVOICE_LINE').value:=1;
     Dataset.FieldByName('FK_VAT_CODE').value:='1';
     Dataset.FieldByName('FK_EXCISE_CODE').value:=' ';
     Dataset.FieldByName('MULTI_ITEMS_INVOICE').Value:='N';
     Dataset.FieldByName('NET_QUANTITY').value:=1;
     Dataset.FieldByName('DUTY_TYPE').Value:='G';
     Dataset.FieldByName('EURO_PENDING').value:='N';
     Dataset.FieldByName('FK_IMPORT_TYPE').value:='C';
     Dataset.FieldByName('POSOSTOSIS').value:='N';
     Dataset.FieldByName('FK_RELIEF_CODE').value:='0';
     Dataset.FieldByName('IMPORT_DUTY_RATE_UNIT').value:='u';


     Dataset.FieldByName('CURRENCY').VALUE:=Airwaybill.YCurrencyCode;
//     Dataset.FieldByName('CURRENCY_Rate').VALUE:=Airwaybill.YExchangeRate;
     Dataset.FieldByName('FK_COUNTRY_ORIGIN').value:=Airwaybill.YOriginCountry;
     Dataset.FieldByName('PRE_DISCOUNT_AMOUNT').value:=Airwaybill.Amount;
     Dataset.FieldByName('WEIGHT_NET').value:=Airwaybill.Weight;
     Dataset.FieldByName('DESCRIPTION').value:=AirwaybillItem.Description;


     Dataset.Post;
     Dataset.Close;


end;


Function TI_ReadManifestFileNewVersionFRM.InsertFakeItem(Airwaybill:TAirwayBillLine;Var AllSerials:TAllSerials):Integer;
Var
   Dataset:TDataset;
begin

     If AllSerials.IsPartial then begin
        Result:=0;
        EXIT;
     end;

     Result:=0;
     Dataset:=HawbItemSQL;

     If not Dataset.Active then begin
             Dataset.open;
     end;
     Dataset.Insert;

     Dataset.fieldbyname('FK_Hawb_serial').Value:=Allserials.HawbSerial;
     Dataset.fieldbyname('FK_Mawb').Value:=Allserials.MawbSerial;
     Dataset.fieldbyname('FK_Sender_invoice_serial').Value:=allserials.SenderInvoiceSerial;

     Dataset.FieldByName('INVOICE_LINE').value:=1;
     Dataset.FieldByName('FK_VAT_CODE').value:='1';
     Dataset.FieldByName('FK_EXCISE_CODE').value:=' ';
     Dataset.FieldByName('MULTI_ITEMS_INVOICE').Value:='N';
     Dataset.FieldByName('NET_QUANTITY').value:=1;
     Dataset.FieldByName('DUTY_TYPE').Value:='G';
     Dataset.FieldByName('EURO_PENDING').value:='N';
     Dataset.FieldByName('FK_IMPORT_TYPE').value:='C';
     Dataset.FieldByName('POSOSTOSIS').value:='N';
     Dataset.FieldByName('FK_RELIEF_CODE').value:='0';
     Dataset.FieldByName('IMPORT_DUTY_RATE_UNIT').value:='u';


     Dataset.FieldByName('CURRENCY').VALUE:=Airwaybill.YCurrencyCode;
//     Dataset.FieldByName('CURRENCY_Rate').VALUE:=Airwaybill.YExchangeRate;
     Dataset.FieldByName('FK_COUNTRY_ORIGIN').value:=Airwaybill.YOriginCountry;
     Dataset.FieldByName('PRE_DISCOUNT_AMOUNT').value:=Airwaybill.Amount;
     Dataset.FieldByName('WEIGHT_NET').value:=Airwaybill.Weight;
     Dataset.FieldByName('DESCRIPTION').value:=Airwaybill.Description;


     Result:=     Dataset.FieldByName('serial_number').AsInteger;
     Dataset.Post;


end;


//////////////////////////////////////////////////////////////
//*** STORE  procedures
//////////////////////////////////////////////////////////////

procedure TI_ReadManifestFileNewVersionFRM.AirwayBillSQLNewRecord(DataSet: TDataSet);
begin

end;


//////////////////////////////////////////////////////////////
//*** Parsing procedures
//////////////////////////////////////////////////////////////

Function TI_ReadManifestFileNewVersionFRM.GetSystemParameters(TheKey:String):Boolean;
Var
        CDefaultDirectory:String;
        CDefaultFile:String;

Begin
     with SystemParametersSQL do
     begin
        close;
        if not prepared then prepare;
        ParambyName('TheKey').Value:='S_9';
        open;
        if IsEmpty then
        begin
                ShowMessage('Add S_9 in system_parameters for default directory');
                abort;
        end;
        CDefaultDirectory:=FieldByName('str_1').asString;
        CDefaultFile:=FieldByName('str_2').asString;
        OpenDialog1.InitialDir:=CDefaultDirectory;
        OpenDialog1.FileName:=CDefaultFile;
     end;

End;

Function TI_ReadManifestFileNewVersionFRM.GetOneSystemParameter(TheKey,TheDescription:String;var Int1,Int2:Integer;var Num1:Double; Var Str1,str2:String):Boolean;
Var
        x1:Double;
Begin
     with SystemParametersSQL do
     begin
        close;
        if not prepared then prepare;
        ParambyName('TheKey').Value:=TheKey;
        open;
        if IsEmpty then
        begin
                ShowMessage('Add '+TheKey  + ' in system_parameters '+TheDescription);
                abort;
        end;
        Int1:=FieldByName('Int_1').asInteger;
        Int2:=FieldByName('Int_2').asInteger;
        Num1:=FieldByName('Num_1').asFloat;
        Str1:=FieldByName('Str_1').asString;
        Str2:=FieldByName('Str_2').asString;
        result:=not IsEmpty;
     end;

End;


Function TI_ReadManifestFileNewVersionFRM.ParseLine(TheLine:String;Var MyWordsArray:TWordsArray):Integer;
Var
           WordCount:Integer;
           StartingPos:Integer;
           NewStartingPos:integer;
           TheWOrd:String;
Begin
           WordCount:=0;
           StartingPos:=1;
           // read all the words of a single line
           while (GetWord(TheLIne,StartingPos,TheWord,NewStartingPos)) do begin
                 Inc(WordCount);
                 MyWordsArray[WordCount]:=RemoveQuotes(TheWord);
                 StartingPos:=NewStartingPos;
                 If (WordCount=MAXWORDS) then begin
                        ShowMessage('Line with too many words:'+TheLine);
                        abort;
                 end;
           end;
           Result:=WordCount;
End;




Function TI_ReadManifestFileNewVersionFRM.OpenFile(Var InFile:TextFile):Boolean;
Var
        TheFileName:String;
Begin

Result:=False;

with OpenDialog1 do begin
if Execute then begin
   TheFileName:= Filename;
    AssignFile(InFile,TheFileName);
    {$I-}
    Reset(InFile);
    {$I+}
    if IOResult <> 0 then begin
      	MessageDlg('Can Not Read File'+TheFileName, mtError, [mbOk], 0);
        Result:=false;
    end else begin
        Result:=True;
    end;
end else begin
     ShowMessage('No File was Selected');
     Result:=false;
end; //execute
end;{with}

end;



Function TI_ReadManifestFileNewVersionFRM.ReadOneLine(Var InFile:TextFile;Var TheLine:String):Boolean;
Var
        MyEol:Boolean;
        Ir:Integer;
        TheChar:Char;
        intChar:Integer;
Begin
          THeLine:='';
          MyEol:=false;
          Ir:=0;
           While ((not myEol)and (Not Eof(Infile)) ) do begin
                 Read(Infile,TheChar);
                 intChar:=Ord(TheChar);
                 if IntChar=10 then begin
                    MyEoL:=true;
                    break;
                 end else begin
                     TheLine:=TheLine+TheChar;
                 end;
                 Inc(ir);
//                 if(ir=100) then showmessage('100');
           end;
           result:= (not  (eof(InFile)));

End;

Function TI_ReadManifestFileNewVersionFRM.GetWord(TheString:String;StartingPos:Integer;Var TheWord :String;Var NewStartingPos:Integer):Boolean;
//**************************************
// Use an automaton here just for fun
// three states:
// Before Start: just ignore everything until you hit a quote
// After First Quote : Include everthying until you hit second quote
// After Second QUote : Just get out
// What happens if never reach the "AFTER_SECOND_QUOTE"? Serious problem here
//**************************************
Const
     Comma=',';
     Space='#32';
     Qt='"';

Var
   NumberOfLetters:Integer;
   TheChar,PrevChar:Char;
   CurrentState:String;
Begin
  CurrentState:='BEFORE_START';
  TheWord:='';
  NumberOfLetters:=0;
  NewStartingPos:=StartingPos;
  While( (CurrentState<>'AFTER_SECOND_QUOTE') and (NewStartingPos <= Length(TheString)) ) do begin
     TheChar:=TheString[NewStartingPos];
     if (CurrentState='BEFORE_START') then begin
        if (TheChar=qt) then begin
           CurrentState:='AFTER_FIRST_QUOTE';
        end else if TheChar<> qt then begin
           // just ignore, we need to find quotes first
        end;
     end else if (CurrentState='AFTER_FIRST_QUOTE') then begin
        if (TheChar=Qt) then begin
           CurrentState:='AFTER_SECOND_QUOTE';
        end else if TheChar<> qt then begin
            TheWord:=TheWord+TheChar;
            Inc(NumberofLetters);
        end;
     end;
     Inc(NewStartingPos);
  end;//for

  If (CurrentState = 'BEFORE_START')then begin
      // never made it to the first quote,
      // it means that there is no need to check for more words in this line
      result:=False;
  end else if (CurrentState = 'AFTER_SECOND_QUOTE')then begin
      Result:=True;
  end else if (CurrentState <> 'AFTER_SECOND_QUOTE')then begin
      //TheWord:='SERIOUS PROBLEM MUST GET OUT';
      Result:=true; //serious problem, never found second quote . CHanged it to just get the word until the end of line
  end;

End;


//********************************************************************
// My convert Procedures
//********************************************************************

Function TI_ReadManifestFileNewVersionFRM.RemoveQuotes(TheString:String):String;
Const
     Qt='"';
Var
     NewString:String;
     TheLength:Integer;
     ThePos:Integer;
Begin
     NewString:=TheString;
     TheLength:=Length(TheString);

     If theLength>0 then begin
        If theString[1]=Qt then begin
           NewString:=Copy(TheString,2,TheLength-1);
           ThePos:=Pos(Qt,NewString);
           If ThePos>0 then begin
              NewString:=Copy(NewString,1,(ThePos-1));
           end;
        end;
     end;
     Result:=NewString;
End;



Function TI_ReadManifestFileNewVersionFRM.ConvertDateTime(TheDate,TheTime:String):TDate;
Var
        StrDate : string;
begin
        DateSeparator := '-';
        ShortDateFormat:='yyyy/mm/dd hh:nn:ss';
        DateSeparator  :='/';
        LongTimeFormat :='hh:mm:ss';
        TimeSeparator  :=':';
        StrDate:=TheDate+' '+TheTime;

        try
           Result:=StrToDateTime(StrDate);
        except
           Result:=int(Now);
        end;
       ShortDateFormat:='dd/mm/yyyy';
End;

Function TI_ReadManifestFileNewVersionFRM.ConvertDate(TheString:String):Tdate;
Var
    TheDate:TDate;
     Year,Month,Day:String;
Begin
     ShortDateFormat:='yyyy/mm/dd';
     try
        TheDate:=StrToDate(TheString);
     except
           TheDate:=int(Now);
     end;
     ShortDateFormat:='dd/mm/yyyy';
     Result:=TheDate;
End;


procedure TI_ReadManifestFileNewVersionFRM.ReplaceComma(Var TheString :String);
var
 ThePos :Integer;
begin
         ThePos:=Pos(',',TheString);
         If (ThePos>0) then
            TheString[ThePos]:='.';

end;

function TI_ReadManifestFileNewVersionFRM.SafeStringToFloat(TheString:String):Double;
Var
   String1 :String;
   TheNumber: double;
begin
   String1:=TheString;
   ReplaceComma(String1);
   try
      TheNumber:=StrToFloat(String1);
   except
   on EConvertError do
      TheNumber:=0;
   end;
   Result:=TheNumber;
end;

function TI_ReadManifestFileNewVersionFRM.UniversalStrToFloat(TheString:String):Double;
Var
   String1 :String;
   TheNumber: double;
   IsCommaDigit:Boolean;
begin
   IsCommaDigit:=(DecimalSeparator=','); // the system uses the comma for decimal if true
   If not IsCommaDigit then begin // since the local is using the dot for decimal
      String1:=TheString;
      ReplaceComma(String1); // replace the comma with the dot
      try
         TheNumber:=StrToFloat(String1);
      except
      on EConvertError do
         TheNumber:=0;
      end;
      Result:=TheNumber;
   end else
   begin
      String1:=TheString;
      try
         TheNumber:=StrToFloat(String1);
      except
      on EConvertError do
         TheNumber:=0;
      end;
      Result:=TheNumber;
   end;
end;



//********************************************************************
// Processing Procedures
//********************************************************************
procedure TI_ReadManifestFileNewVersionFRM.FindCountry(CountryCode:String;Var CountryDetails:TCountryDetails);
Begin
     with CountrySQL do
     begin
          Close;
          If not Prepared Then Prepare;
          ParamByName('Code').Value:=CountryCode;
          Open;
          If (not IsEmpty) then begin
            CountryDetails.CountryNumber:=FieldByName('Number').AsInteger;
             CountryDetails.LowFreight:=FieldBYName('FREIGHT05').AsFloat;
             CountryDetails.HighFreight:=FieldBYName('FREIGHT6').AsFloat;

          end;
          close;
     end;

End;

procedure TI_ReadManifestFileNewVersionFRM.ReadFileBTNClick(Sender: TObject);

//***************************************************
//      STATE AUTOMATON
//      F,A,I (F=Mawb A=Hawb I=ITem)
//      ARRAY below will point you the state to go when standing in a state and reading a linetype
//***************************************************
Const
        StateArray2 : TStateArray = (
        //f  ,A   ,i  ,
        (WAIT,ERRR,ERRR),   //START  Mawb was created outside case statement
        (WAIT,CAIR,WAIT),   //WAIT   Just waiting, does not create anything, ignore the line
        (WAIT,CIAR,CABI),   //CAIR   creates airwaybill.
        (WAIT,CIAR,CABI),   //CIAR   create FAKE ITEM for previous air and then create current airwaybill (AGAIN check for P,H,R
        (WAIT,CAIR,WAIT),   //CABI   create HAWB item only for first Item.
        (ERRR,ERRR,ERRR)    //ERRR
        );
var
   NewPos:integer;
   TheType:Char;
   LineCount:Integer;
   MovementCount:Integer;
   DocumentCount:integer;
   AirwaybillCount:Integer;
   AirwaybillMediumCount:Integer;
   ItemCount:Integer;

   InFile : TextFile;
   TheLine     : String;
   KWordsArray:TWordsArray;

   LineState:TLineState;
   PreviousState:TlineState;
   LineType:TlineTYpe;
   IsLineError:Boolean;
   IsIgnoreLine:Boolean;

   AllSerials:TAllSerials;
   MawbRecordLine:TMawbRecordLine;
   AirwayBillLine:TAirwayBillLine;
   ItemLine:TAirwaybillItemLine;

   Str1,Str2:String;
   VVrate:Double;
   DefaultCharges:TDefaultCharges;
begin

    if not GetOneSystemParameter('S11','Medium EDE min and max Values',MediumValueMin,MediumValueMax,vvRate,Str1,Str2) then begin
        abort;
    end;


    If not OpenFile(InFile) then begin
        abort;
    end;

    IsLineError:=False;
    LineState:=START;
    PreviousState:=START;
    LineCount:=0;
    ItemCount:=0;
    MovementCount:=0;
    DocumentCount:=0;
    AirwaybillCount:=0;
    AirwaybillMediumCount:=0;

    FindDefaultCharges(DefaultCharges);
    while ( ReadOneLine(inFile,TheLine)) do begin

          If (ParseLine(TheLine,KWordsArray)<1) then // last line may be empty
                break;

           Inc(LineCount); //120
           {
           If (  (LineCount>=83) )  then begin
                ShowMessage(intToStr(Linecount));
           end;
           }
           IsLineError:=false;
           TheType:=KWordsArray[1][1];
           Case TheTYpe of
           'F':begin LineTYpe:=Mawb;              IsIgnoreLine:=false; end;
           'M':begin LineType:=Linetype;       IsIgnoreLine:=true; end;
           'H':begin LineType:=LineType;       IsIgnoreLine:=true; end;
           'P':begin LineType:=LineType;       IsIgnoreLine:=true; end;
           'R':begin LineType:=LIneType;       IsIgnoreLine:=true; end;
           'A':begin LineType:=Hawb;              IsIgnoreLine:=false; end ;
           'I':begin LineType:=Item;              IsIgnoreLine:=false; end;
           else begin
                IsLineError:=true;
                IsIgnoreLine:=True;
           end;
           end;

        If IsIgnoreLine then begin
                continue;           // skip everthing below , the line was unrecognizable
        end;

                //check and create Mawb before changing the STATE of the machine!
                iF (LineState=START)then begin
                        if (LineType=Mawb)then begin
                                PrepareMawbRecord(KWordsArray,MawbRecordLine);
                                GMawbSerial:=InsertMawb(MawbRecordLine,AllSerials);
                                AllSerials.HawbSerial:=0;
                                Inc(MovementCount);
                        end else begin
                                ShowMessage('error first line not File');
                                abort;
                        end;
                end;


        LineState:=StateArray2[LineState,LineType];
        Case  LineState Of
           WAIT: begin
                        //do nothing
                end;
           CAIR:  begin
                        PrepareHawbRecord(KwordsArray,AirwayBillLine);
                        InsertHawb(AirwayBIllLine,DefaultCharges,AllSerials);
                        InsertSenderInvoice(AirwayBIllLine,AllSerials);
                        If Airwaybillline.IsMedium then begin
                         Inc(AirwaybillMediumCount);
                        end;
                        Inc(Airwaybillcount);

                end;
           CIAR:  begin
                        InsertFakeItem(AirwayBillLine,AllSerials);
                        PrepareHawbRecord(KwordsArray,AirwayBillLine);
                        InsertHawb(AirwayBIllLine,DefaultCharges,AllSerials);
                        InsertSenderInvoice(AirwayBIllLine,AllSerials);
                        If Airwaybillline.IsMedium then begin
                         //Inc(AirwaybillMediumCount);
                        end;
                        Inc(Airwaybillcount);
                end;
           CABI:begin
                        PrepareHawbItemRecord(KwordsArray,ItemLine);
                        InsertHawbItem(AirwayBillLine,ItemLine,AllSerials);
//
                        With UPdateHawbDescSQL do begin
                                ParamByName('HawbSerial').Value:=AllSerials.HawbSerial;
                                ParamByName('Description').Value:=ItemLine.Description;
                                Execute;
                        end;

                end;
           ERRR: begin
                        //from start we expect an F linetype
                        ShowMessage('there was an error');
                        ShowMessage(GetEnumName(TypeInfo(TLIneState),integer(PreviousState)) );
                        ShowMessage(TheLIne);
                        //abort;
                end;
           else
                begin
                        ShowMessage('St????= what '+ TheLine);
                end;
        end;
        PreviousState:=LineState;

    end;//while

    Closefile(Infile);

    MessageDlg('File was SUCCESSFULLY Read.'+#10#13+ 'Movements='+
    IntToStr(MovementCOunt)+#10#13+'Documents='+IntToStr(DocumentCount)
    +#10#13+'AirwayBills='+IntToStr(AirwayBillCount)
    +#10#13+'Medium Value='+IntToStr(AirwayBillMediumCount)
    , mtInformation, [mbOK], 0);
End;

procedure TI_ReadManifestFileNewVersionFRM.Button1Click(Sender: TObject);
Var
        ADate:TDate;
        MawbID:String;
begin
MawbID:=MawbFLD.Text;

With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Delete from hawb_item where fk_hawb_serial in (select serial_number from Hawb where fk_mawb_refer_number> 12290 ) ');
        ExecSQL;

end;

With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Delete from sender_invoice where FK_Mawb_serial> 12290');
        ExecSQL;

end;

With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Delete from hawb_partial where fk_mawb_serial_arrived> 12290');
        ExecSQL;
end;
With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Delete from hawb where fk_mawb_refer_number> 12290');
        ExecSQL;
end;
With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Delete from hawb_low_deleted where fk_mawb_refer_number> 12290');
        ExecSQL;
end;


With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Delete from Mawb where reference_number> 12290');
        ExecSQL;

end;





End;



procedure TI_ReadManifestFileNewVersionFRM.Button2Click(Sender: TObject);
begin
With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Update hawb_item set FK_Mawb =''998'' where fk_hawb_serial in (select serial_number from Hawb where fk_mawb_refer_number> 12290 ) ');
        ExecSQL;

end;
{
With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('Update sender_invoice set fk_mawb_id='where FK_Mawb_serial> 12290');
        ExecSQL;

end;
}
With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('update hawb set fk_mawb_id = ''998'' where fk_mawb_refer_number> 12290');
        ExecSQL;
end;
With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('update hawb_low_deleted set fk_mawb_id =''998'' where fk_mawb_refer_number> 12290');
        ExecSQL;
end;


With fDeleteOneSQL do begin
        Close;
        SQL.Clear;
        SQL.Add('update Mawb set mawb_id = ''998'' where reference_number> 12290');
        ExecSQL;

end;





end;

procedure TI_ReadManifestFileNewVersionFRM.Button3Click(Sender: TObject);
begin
IBCScript1.Execute;
end;

procedure TI_ReadManifestFileNewVersionFRM.Button4Click(Sender: TObject);
Var
        Int1,Int2:Integer;
        Str1,Str2:string;
        vvRate:DOuble;
begin

  GetOneSystemParameter('S11','Medium Hawb Values', int1, int2,vvrate, str1, str2);
end;

END.
