object X_readFileFRM: TX_readFileFRM
  Left = 0
  Top = 0
  Caption = 'X_readFileFRM'
  ClientHeight = 393
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 56
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 56
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Delete hawbs'
    TabOrder = 1
    OnClick = Button2Click
  end
  object XMLDocument1: TXMLDocument
    Left = 216
    Top = 48
  end
  object ReadTrans: TIBCTransaction
    DefaultConnection = mainFRm.IBCConnection1
    IsolationLevel = iblReadOnlyReadCommitted
    Left = 80
    Top = 144
  end
  object WriteTrans: TIBCTransaction
    DefaultConnection = mainFRm.IBCConnection1
    Left = 144
    Top = 144
  end
  object HawbSQL: TIBCQuery
    KeyFields = 'serial_number'
    KeyGenerator = 'HAWB_SERIAL_GENERATOR'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO HAWB'
      
        '  (HAB_ID, FK_MAWB_REFER_NUMBER, FK_CLEARING_STATE, FK_INVOICE_S' +
        'TATUS, DESCRIPTION, FK_CUSTOMER_CODE, WEIGHT, FK_CURRENCY, EXCHA' +
        'NGE_RATE, INVOICE_TOTAL, FREIGHT_AMOUNT, FK_OTHER_CHARGE_CODE, O' +
        'THER_CHARGE_AMOUNT, OTHER_CHARGE_PAID, STAMPS_AMOUNT, EXPS_NON_I' +
        'NVOICABLE, SERIAL_NUMBER, CUSTOMS_VALUE, INVOICE_SERIAL, COURIER' +
        '_INVOICE_SERIAL, COURIER_INVOICE_VALUE, HIGH_VALUE, FK_SEC_MAWB_' +
        'REFER_NUMBER, EDE_STORAGE_EXPENSES, EDE_DELIVERY_EXPENSES, DATE_' +
        'INVOICED, SENT_TO_HEAD, NUM_OF_PIECES_ARRIVED, TOTAL_NUM_OF_PIEC' +
        'ES, FK_CLEARANCE_TYPE, FK_DELIVERY_TERM, ORIGIN_STATION, EC2_NUM' +
        'BER_DATE, SENDERS_INV_NO, NUMBER_OF_PARCELS, FK_CUSTOMER_ACCOUNT' +
        ', DISTRICT, DELIVERY_ORDER_AMOUNT, OTHER2_CHARGE_AMOUNT, FK_OTHE' +
        'R2_CHARGE_CODE, POSOSTOSIS, TOTAL_DUTIES, CLEARANCE_WAITING_CODE' +
        ', CLEARANCE_WAITING_REASON, DATE_CLEARED, DATE_REGISTERED, FACTO' +
        'R, FK_COUNTRY_ORIGIN, CHARGE_TRL, CHARGE_VAT, CHARGE_EXCISE, CHA' +
        'RGE_IMPORT, INVOICABLE, TOTAL_CHARGES, CUSTOMER_NAME, EDE_COMMEN' +
        'TS, FK_MAWB_ID, SIGNATORY_NAME, XML_HOUSE_ID, SENDER_NAME, SENDE' +
        'R_ADDRESS_1, SENDER_ADDRESS_2, SENDER_ADDRESS_3, IS_PRIVATE, DEL' +
        'IVERY_ORDER_ID, OTHER4_CHARGE_AMOUNT, FK_OTHER4_CHARGE, IS_PAID,' +
        ' PARTIAL_FLAG, PARTIAL_WEIGHT, PARTIAL_DELIVERY_ORDER_ID, PARTIA' +
        'L_MAWB_ID, PARTIAL_PIECES, PARTIAL_MAWB_REFER_NUMBER, STATUS_C, ' +
        'IS_MEDIUM, MEDIUM_VAT_RATE, IS_CHARGED_DELIVERY, IS_VALID, IS_PR' +
        'EPAID, OTHER5_CHARGE_AMOUNT, FK_DUTY_RELIEVE, FK_CLEARANCE_INSTR' +
        'UCTION, SENDER_POST_CODE, SENDER_CITY, SENDER_COUNTRY)'
      'VALUES'
      
        '  (:HAB_ID, :FK_MAWB_REFER_NUMBER, :FK_CLEARING_STATE, :FK_INVOI' +
        'CE_STATUS, :DESCRIPTION, :FK_CUSTOMER_CODE, :WEIGHT, :FK_CURRENC' +
        'Y, :EXCHANGE_RATE, :INVOICE_TOTAL, :FREIGHT_AMOUNT, :FK_OTHER_CH' +
        'ARGE_CODE, :OTHER_CHARGE_AMOUNT, :OTHER_CHARGE_PAID, :STAMPS_AMO' +
        'UNT, :EXPS_NON_INVOICABLE, :SERIAL_NUMBER, :CUSTOMS_VALUE, :INVO' +
        'ICE_SERIAL, :COURIER_INVOICE_SERIAL, :COURIER_INVOICE_VALUE, :HI' +
        'GH_VALUE, :FK_SEC_MAWB_REFER_NUMBER, :EDE_STORAGE_EXPENSES, :EDE' +
        '_DELIVERY_EXPENSES, :DATE_INVOICED, :SENT_TO_HEAD, :NUM_OF_PIECE' +
        'S_ARRIVED, :TOTAL_NUM_OF_PIECES, :FK_CLEARANCE_TYPE, :FK_DELIVER' +
        'Y_TERM, :ORIGIN_STATION, :EC2_NUMBER_DATE, :SENDERS_INV_NO, :NUM' +
        'BER_OF_PARCELS, :FK_CUSTOMER_ACCOUNT, :DISTRICT, :DELIVERY_ORDER' +
        '_AMOUNT, :OTHER2_CHARGE_AMOUNT, :FK_OTHER2_CHARGE_CODE, :POSOSTO' +
        'SIS, :TOTAL_DUTIES, :CLEARANCE_WAITING_CODE, :CLEARANCE_WAITING_' +
        'REASON, :DATE_CLEARED, :DATE_REGISTERED, :FACTOR, :FK_COUNTRY_OR' +
        'IGIN, :CHARGE_TRL, :CHARGE_VAT, :CHARGE_EXCISE, :CHARGE_IMPORT, ' +
        ':INVOICABLE, :TOTAL_CHARGES, :CUSTOMER_NAME, :EDE_COMMENTS, :FK_' +
        'MAWB_ID, :SIGNATORY_NAME, :XML_HOUSE_ID, :SENDER_NAME, :SENDER_A' +
        'DDRESS_1, :SENDER_ADDRESS_2, :SENDER_ADDRESS_3, :IS_PRIVATE, :DE' +
        'LIVERY_ORDER_ID, :OTHER4_CHARGE_AMOUNT, :FK_OTHER4_CHARGE, :IS_P' +
        'AID, :PARTIAL_FLAG, :PARTIAL_WEIGHT, :PARTIAL_DELIVERY_ORDER_ID,' +
        ' :PARTIAL_MAWB_ID, :PARTIAL_PIECES, :PARTIAL_MAWB_REFER_NUMBER, ' +
        ':STATUS_C, :IS_MEDIUM, :MEDIUM_VAT_RATE, :IS_CHARGED_DELIVERY, :' +
        'IS_VALID, :IS_PREPAID, :OTHER5_CHARGE_AMOUNT, :FK_DUTY_RELIEVE, ' +
        ':FK_CLEARANCE_INSTRUCTION, :SENDER_POST_CODE, :SENDER_CITY, :SEN' +
        'DER_COUNTRY)')
    SQLDelete.Strings = (
      'DELETE FROM HAWB'
      'WHERE'
      '  SERIAL_NUMBER = :Old_SERIAL_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE HAWB'
      'SET'
      
        '  HAB_ID = :HAB_ID, FK_MAWB_REFER_NUMBER = :FK_MAWB_REFER_NUMBER' +
        ', FK_CLEARING_STATE = :FK_CLEARING_STATE, FK_INVOICE_STATUS = :F' +
        'K_INVOICE_STATUS, DESCRIPTION = :DESCRIPTION, FK_CUSTOMER_CODE =' +
        ' :FK_CUSTOMER_CODE, WEIGHT = :WEIGHT, FK_CURRENCY = :FK_CURRENCY' +
        ', EXCHANGE_RATE = :EXCHANGE_RATE, INVOICE_TOTAL = :INVOICE_TOTAL' +
        ', FREIGHT_AMOUNT = :FREIGHT_AMOUNT, FK_OTHER_CHARGE_CODE = :FK_O' +
        'THER_CHARGE_CODE, OTHER_CHARGE_AMOUNT = :OTHER_CHARGE_AMOUNT, OT' +
        'HER_CHARGE_PAID = :OTHER_CHARGE_PAID, STAMPS_AMOUNT = :STAMPS_AM' +
        'OUNT, EXPS_NON_INVOICABLE = :EXPS_NON_INVOICABLE, SERIAL_NUMBER ' +
        '= :SERIAL_NUMBER, CUSTOMS_VALUE = :CUSTOMS_VALUE, INVOICE_SERIAL' +
        ' = :INVOICE_SERIAL, COURIER_INVOICE_SERIAL = :COURIER_INVOICE_SE' +
        'RIAL, COURIER_INVOICE_VALUE = :COURIER_INVOICE_VALUE, HIGH_VALUE' +
        ' = :HIGH_VALUE, FK_SEC_MAWB_REFER_NUMBER = :FK_SEC_MAWB_REFER_NU' +
        'MBER, EDE_STORAGE_EXPENSES = :EDE_STORAGE_EXPENSES, EDE_DELIVERY' +
        '_EXPENSES = :EDE_DELIVERY_EXPENSES, DATE_INVOICED = :DATE_INVOIC' +
        'ED, SENT_TO_HEAD = :SENT_TO_HEAD, NUM_OF_PIECES_ARRIVED = :NUM_O' +
        'F_PIECES_ARRIVED, TOTAL_NUM_OF_PIECES = :TOTAL_NUM_OF_PIECES, FK' +
        '_CLEARANCE_TYPE = :FK_CLEARANCE_TYPE, FK_DELIVERY_TERM = :FK_DEL' +
        'IVERY_TERM, ORIGIN_STATION = :ORIGIN_STATION, EC2_NUMBER_DATE = ' +
        ':EC2_NUMBER_DATE, SENDERS_INV_NO = :SENDERS_INV_NO, NUMBER_OF_PA' +
        'RCELS = :NUMBER_OF_PARCELS, FK_CUSTOMER_ACCOUNT = :FK_CUSTOMER_A' +
        'CCOUNT, DISTRICT = :DISTRICT, DELIVERY_ORDER_AMOUNT = :DELIVERY_' +
        'ORDER_AMOUNT, OTHER2_CHARGE_AMOUNT = :OTHER2_CHARGE_AMOUNT, FK_O' +
        'THER2_CHARGE_CODE = :FK_OTHER2_CHARGE_CODE, POSOSTOSIS = :POSOST' +
        'OSIS, TOTAL_DUTIES = :TOTAL_DUTIES, CLEARANCE_WAITING_CODE = :CL' +
        'EARANCE_WAITING_CODE, CLEARANCE_WAITING_REASON = :CLEARANCE_WAIT' +
        'ING_REASON, DATE_CLEARED = :DATE_CLEARED, DATE_REGISTERED = :DAT' +
        'E_REGISTERED, FACTOR = :FACTOR, FK_COUNTRY_ORIGIN = :FK_COUNTRY_' +
        'ORIGIN, CHARGE_TRL = :CHARGE_TRL, CHARGE_VAT = :CHARGE_VAT, CHAR' +
        'GE_EXCISE = :CHARGE_EXCISE, CHARGE_IMPORT = :CHARGE_IMPORT, INVO' +
        'ICABLE = :INVOICABLE, TOTAL_CHARGES = :TOTAL_CHARGES, CUSTOMER_N' +
        'AME = :CUSTOMER_NAME, EDE_COMMENTS = :EDE_COMMENTS, FK_MAWB_ID =' +
        ' :FK_MAWB_ID, SIGNATORY_NAME = :SIGNATORY_NAME, XML_HOUSE_ID = :' +
        'XML_HOUSE_ID, SENDER_NAME = :SENDER_NAME, SENDER_ADDRESS_1 = :SE' +
        'NDER_ADDRESS_1, SENDER_ADDRESS_2 = :SENDER_ADDRESS_2, SENDER_ADD' +
        'RESS_3 = :SENDER_ADDRESS_3, IS_PRIVATE = :IS_PRIVATE, DELIVERY_O' +
        'RDER_ID = :DELIVERY_ORDER_ID, OTHER4_CHARGE_AMOUNT = :OTHER4_CHA' +
        'RGE_AMOUNT, FK_OTHER4_CHARGE = :FK_OTHER4_CHARGE, IS_PAID = :IS_' +
        'PAID, PARTIAL_FLAG = :PARTIAL_FLAG, PARTIAL_WEIGHT = :PARTIAL_WE' +
        'IGHT, PARTIAL_DELIVERY_ORDER_ID = :PARTIAL_DELIVERY_ORDER_ID, PA' +
        'RTIAL_MAWB_ID = :PARTIAL_MAWB_ID, PARTIAL_PIECES = :PARTIAL_PIEC' +
        'ES, PARTIAL_MAWB_REFER_NUMBER = :PARTIAL_MAWB_REFER_NUMBER, STAT' +
        'US_C = :STATUS_C, IS_MEDIUM = :IS_MEDIUM, MEDIUM_VAT_RATE = :MED' +
        'IUM_VAT_RATE, IS_CHARGED_DELIVERY = :IS_CHARGED_DELIVERY, IS_VAL' +
        'ID = :IS_VALID, IS_PREPAID = :IS_PREPAID, OTHER5_CHARGE_AMOUNT =' +
        ' :OTHER5_CHARGE_AMOUNT, FK_DUTY_RELIEVE = :FK_DUTY_RELIEVE, FK_C' +
        'LEARANCE_INSTRUCTION = :FK_CLEARANCE_INSTRUCTION, SENDER_POST_CO' +
        'DE = :SENDER_POST_CODE, SENDER_CITY = :SENDER_CITY, SENDER_COUNT' +
        'RY = :SENDER_COUNTRY'
      'WHERE'
      '  SERIAL_NUMBER = :Old_SERIAL_NUMBER')
    SQLRefresh.Strings = (
      
        'SELECT HAB_ID, FK_MAWB_REFER_NUMBER, FK_CLEARING_STATE, FK_INVOI' +
        'CE_STATUS, DESCRIPTION, FK_CUSTOMER_CODE, WEIGHT, FK_CURRENCY, E' +
        'XCHANGE_RATE, INVOICE_TOTAL, FREIGHT_AMOUNT, FK_OTHER_CHARGE_COD' +
        'E, OTHER_CHARGE_AMOUNT, OTHER_CHARGE_PAID, STAMPS_AMOUNT, EXPS_N' +
        'ON_INVOICABLE, SERIAL_NUMBER, CUSTOMS_VALUE, INVOICE_SERIAL, COU' +
        'RIER_INVOICE_SERIAL, COURIER_INVOICE_VALUE, HIGH_VALUE, FK_SEC_M' +
        'AWB_REFER_NUMBER, EDE_STORAGE_EXPENSES, EDE_DELIVERY_EXPENSES, D' +
        'ATE_INVOICED, SENT_TO_HEAD, NUM_OF_PIECES_ARRIVED, TOTAL_NUM_OF_' +
        'PIECES, FK_CLEARANCE_TYPE, FK_DELIVERY_TERM, ORIGIN_STATION, EC2' +
        '_NUMBER_DATE, SENDERS_INV_NO, NUMBER_OF_PARCELS, FK_CUSTOMER_ACC' +
        'OUNT, DISTRICT, DELIVERY_ORDER_AMOUNT, OTHER2_CHARGE_AMOUNT, FK_' +
        'OTHER2_CHARGE_CODE, POSOSTOSIS, TOTAL_DUTIES, CLEARANCE_WAITING_' +
        'CODE, CLEARANCE_WAITING_REASON, DATE_CLEARED, DATE_REGISTERED, F' +
        'ACTOR, FK_COUNTRY_ORIGIN, CHARGE_TRL, CHARGE_VAT, CHARGE_EXCISE,' +
        ' CHARGE_IMPORT, INVOICABLE, TOTAL_CHARGES, CUSTOMER_NAME, EDE_CO' +
        'MMENTS, FK_MAWB_ID, SIGNATORY_NAME, XML_HOUSE_ID, SENDER_NAME, S' +
        'ENDER_ADDRESS_1, SENDER_ADDRESS_2, SENDER_ADDRESS_3, IS_PRIVATE,' +
        ' DELIVERY_ORDER_ID, OTHER4_CHARGE_AMOUNT, FK_OTHER4_CHARGE, IS_P' +
        'AID, PARTIAL_FLAG, PARTIAL_WEIGHT, PARTIAL_DELIVERY_ORDER_ID, PA' +
        'RTIAL_MAWB_ID, PARTIAL_PIECES, PARTIAL_MAWB_REFER_NUMBER, STATUS' +
        '_C, IS_MEDIUM, MEDIUM_VAT_RATE, IS_CHARGED_DELIVERY, IS_VALID, I' +
        'S_PREPAID, OTHER5_CHARGE_AMOUNT, FK_DUTY_RELIEVE, FK_CLEARANCE_I' +
        'NSTRUCTION, SENDER_POST_CODE, SENDER_CITY, SENDER_COUNTRY FROM H' +
        'AWB'
      'WHERE'
      '  SERIAL_NUMBER = :SERIAL_NUMBER')
    SQLLock.Strings = (
      'SELECT NULL FROM HAWB'
      'WHERE'
      'SERIAL_NUMBER = :Old_SERIAL_NUMBER'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM HAWB'
      ''
      ') q')
    Connection = mainFRm.IBCConnection1
    Transaction = ReadTrans
    UpdateTransaction = WriteTrans
    SQL.Strings = (
      'Select * from hawb where serial_number=-1')
    Left = 288
    Top = 144
  end
  object MawbSQL: TIBCQuery
    KeyFields = 'reference_number'
    KeyGenerator = 'MAWB_KEY_GENERATOR'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO MAWB'
      
        '  (REFERENCE_YEAR, REFERENCE_NUMBER, DATE_ARRIVED, FK_COUNTRY_CO' +
        'NSIGNEE, FK_PORT_IMPORTATION, SIGNATORY_NAME, FORM_DATE, FLIGHT_' +
        'NUMBER, PASSED, ROTATION_NUMBER, ROTATION_YEAR, FK_PORT_CLEARING' +
        ', GOODS_NUMBER, GOODS_DESCRIPTION, CBOOK_NUMBER, MAWB_ID, INVOIC' +
        'ED, SENT_TO_HEAD, CUSTOMS_OVERTIME_HOURS, CUSTOMS_OVERTIME_RATE,' +
        ' STORAGE_EXPENSES, DELIVERY_EXPENSES, AMOUNT_NOT_INVOICED, AMOUN' +
        'T_INVOICED, DATE_PASSED, GOODS_WEIGHT, HAWBS_CLEARED_FIRST_TIME,' +
        ' HAWBS_IN_MAWB, DOCS_NUMBER, DOCS_WEIGHT, HIGH_VALUE_NUMBER, HIG' +
        'H_VALUE_WEIGHT, MEDIUM_VALUE_NUMBER, MEDIUM_VALUE_WEIGHT, LOW_VA' +
        'LUE_NUMBER, LOW_VALUE_WEIGHT, CUSTOMS_OVERTIME_RATE_TYPE, XML_CO' +
        'NSOLIDATED_ID, ROTATION_2, HMSD, LOW_VALUE_TDID, STATUSC_NUMBER,' +
        ' STATUSC_WEIGHT, TDID_NEW, F63, STATUSC, TDID_MEDIUM)'
      'VALUES'
      
        '  (:REFERENCE_YEAR, :REFERENCE_NUMBER, :DATE_ARRIVED, :FK_COUNTR' +
        'Y_CONSIGNEE, :FK_PORT_IMPORTATION, :SIGNATORY_NAME, :FORM_DATE, ' +
        ':FLIGHT_NUMBER, :PASSED, :ROTATION_NUMBER, :ROTATION_YEAR, :FK_P' +
        'ORT_CLEARING, :GOODS_NUMBER, :GOODS_DESCRIPTION, :CBOOK_NUMBER, ' +
        ':MAWB_ID, :INVOICED, :SENT_TO_HEAD, :CUSTOMS_OVERTIME_HOURS, :CU' +
        'STOMS_OVERTIME_RATE, :STORAGE_EXPENSES, :DELIVERY_EXPENSES, :AMO' +
        'UNT_NOT_INVOICED, :AMOUNT_INVOICED, :DATE_PASSED, :GOODS_WEIGHT,' +
        ' :HAWBS_CLEARED_FIRST_TIME, :HAWBS_IN_MAWB, :DOCS_NUMBER, :DOCS_' +
        'WEIGHT, :HIGH_VALUE_NUMBER, :HIGH_VALUE_WEIGHT, :MEDIUM_VALUE_NU' +
        'MBER, :MEDIUM_VALUE_WEIGHT, :LOW_VALUE_NUMBER, :LOW_VALUE_WEIGHT' +
        ', :CUSTOMS_OVERTIME_RATE_TYPE, :XML_CONSOLIDATED_ID, :ROTATION_2' +
        ', :HMSD, :LOW_VALUE_TDID, :STATUSC_NUMBER, :STATUSC_WEIGHT, :TDI' +
        'D_NEW, :F63, :STATUSC, :TDID_MEDIUM)')
    SQLDelete.Strings = (
      'DELETE FROM MAWB'
      'WHERE'
      '  REFERENCE_NUMBER = :Old_REFERENCE_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE MAWB'
      'SET'
      
        '  REFERENCE_YEAR = :REFERENCE_YEAR, REFERENCE_NUMBER = :REFERENC' +
        'E_NUMBER, DATE_ARRIVED = :DATE_ARRIVED, FK_COUNTRY_CONSIGNEE = :' +
        'FK_COUNTRY_CONSIGNEE, FK_PORT_IMPORTATION = :FK_PORT_IMPORTATION' +
        ', SIGNATORY_NAME = :SIGNATORY_NAME, FORM_DATE = :FORM_DATE, FLIG' +
        'HT_NUMBER = :FLIGHT_NUMBER, PASSED = :PASSED, ROTATION_NUMBER = ' +
        ':ROTATION_NUMBER, ROTATION_YEAR = :ROTATION_YEAR, FK_PORT_CLEARI' +
        'NG = :FK_PORT_CLEARING, GOODS_NUMBER = :GOODS_NUMBER, GOODS_DESC' +
        'RIPTION = :GOODS_DESCRIPTION, CBOOK_NUMBER = :CBOOK_NUMBER, MAWB' +
        '_ID = :MAWB_ID, INVOICED = :INVOICED, SENT_TO_HEAD = :SENT_TO_HE' +
        'AD, CUSTOMS_OVERTIME_HOURS = :CUSTOMS_OVERTIME_HOURS, CUSTOMS_OV' +
        'ERTIME_RATE = :CUSTOMS_OVERTIME_RATE, STORAGE_EXPENSES = :STORAG' +
        'E_EXPENSES, DELIVERY_EXPENSES = :DELIVERY_EXPENSES, AMOUNT_NOT_I' +
        'NVOICED = :AMOUNT_NOT_INVOICED, AMOUNT_INVOICED = :AMOUNT_INVOIC' +
        'ED, DATE_PASSED = :DATE_PASSED, GOODS_WEIGHT = :GOODS_WEIGHT, HA' +
        'WBS_CLEARED_FIRST_TIME = :HAWBS_CLEARED_FIRST_TIME, HAWBS_IN_MAW' +
        'B = :HAWBS_IN_MAWB, DOCS_NUMBER = :DOCS_NUMBER, DOCS_WEIGHT = :D' +
        'OCS_WEIGHT, HIGH_VALUE_NUMBER = :HIGH_VALUE_NUMBER, HIGH_VALUE_W' +
        'EIGHT = :HIGH_VALUE_WEIGHT, MEDIUM_VALUE_NUMBER = :MEDIUM_VALUE_' +
        'NUMBER, MEDIUM_VALUE_WEIGHT = :MEDIUM_VALUE_WEIGHT, LOW_VALUE_NU' +
        'MBER = :LOW_VALUE_NUMBER, LOW_VALUE_WEIGHT = :LOW_VALUE_WEIGHT, ' +
        'CUSTOMS_OVERTIME_RATE_TYPE = :CUSTOMS_OVERTIME_RATE_TYPE, XML_CO' +
        'NSOLIDATED_ID = :XML_CONSOLIDATED_ID, ROTATION_2 = :ROTATION_2, ' +
        'HMSD = :HMSD, LOW_VALUE_TDID = :LOW_VALUE_TDID, STATUSC_NUMBER =' +
        ' :STATUSC_NUMBER, STATUSC_WEIGHT = :STATUSC_WEIGHT, TDID_NEW = :' +
        'TDID_NEW, F63 = :F63, STATUSC = :STATUSC, TDID_MEDIUM = :TDID_ME' +
        'DIUM'
      'WHERE'
      '  REFERENCE_NUMBER = :Old_REFERENCE_NUMBER')
    SQLRefresh.Strings = (
      
        'SELECT REFERENCE_YEAR, REFERENCE_NUMBER, DATE_ARRIVED, FK_COUNTR' +
        'Y_CONSIGNEE, FK_PORT_IMPORTATION, SIGNATORY_NAME, FORM_DATE, FLI' +
        'GHT_NUMBER, PASSED, ROTATION_NUMBER, ROTATION_YEAR, FK_PORT_CLEA' +
        'RING, GOODS_NUMBER, GOODS_DESCRIPTION, CBOOK_NUMBER, MAWB_ID, IN' +
        'VOICED, SENT_TO_HEAD, CUSTOMS_OVERTIME_HOURS, CUSTOMS_OVERTIME_R' +
        'ATE, STORAGE_EXPENSES, DELIVERY_EXPENSES, AMOUNT_NOT_INVOICED, A' +
        'MOUNT_INVOICED, DATE_PASSED, GOODS_WEIGHT, HAWBS_CLEARED_FIRST_T' +
        'IME, HAWBS_IN_MAWB, DOCS_NUMBER, DOCS_WEIGHT, HIGH_VALUE_NUMBER,' +
        ' HIGH_VALUE_WEIGHT, MEDIUM_VALUE_NUMBER, MEDIUM_VALUE_WEIGHT, LO' +
        'W_VALUE_NUMBER, LOW_VALUE_WEIGHT, CUSTOMS_OVERTIME_RATE_TYPE, XM' +
        'L_CONSOLIDATED_ID, ROTATION_2, HMSD, LOW_VALUE_TDID, STATUSC_NUM' +
        'BER, STATUSC_WEIGHT, TDID_NEW, F63, STATUSC, TDID_MEDIUM FROM MA' +
        'WB'
      'WHERE'
      '  REFERENCE_NUMBER = :REFERENCE_NUMBER')
    SQLLock.Strings = (
      'SELECT NULL FROM MAWB'
      'WHERE'
      'REFERENCE_NUMBER = :Old_REFERENCE_NUMBER'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MAWB'
      ''
      ') q')
    Connection = mainFRm.IBCConnection1
    Transaction = ReadTrans
    UpdateTransaction = WriteTrans
    SQL.Strings = (
      'select * from mawb where reference_number= :serialNumber')
    Left = 320
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'serialNumber'
        Value = nil
      end>
    object MawbSQLREFERENCE_YEAR: TSmallintField
      FieldName = 'REFERENCE_YEAR'
      Required = True
    end
    object MawbSQLREFERENCE_NUMBER: TIntegerField
      FieldName = 'REFERENCE_NUMBER'
    end
    object MawbSQLDATE_ARRIVED: TDateField
      FieldName = 'DATE_ARRIVED'
    end
    object MawbSQLFK_COUNTRY_CONSIGNEE: TIntegerField
      FieldName = 'FK_COUNTRY_CONSIGNEE'
    end
    object MawbSQLFK_PORT_IMPORTATION: TIntegerField
      FieldName = 'FK_PORT_IMPORTATION'
    end
    object MawbSQLSIGNATORY_NAME: TStringField
      FieldName = 'SIGNATORY_NAME'
      Size = 50
    end
    object MawbSQLFORM_DATE: TDateField
      FieldName = 'FORM_DATE'
    end
    object MawbSQLFLIGHT_NUMBER: TStringField
      FieldName = 'FLIGHT_NUMBER'
      Size = 10
    end
    object MawbSQLPASSED: TStringField
      FieldName = 'PASSED'
      Required = True
      FixedChar = True
      Size = 1
    end
    object MawbSQLROTATION_NUMBER: TIntegerField
      FieldName = 'ROTATION_NUMBER'
    end
    object MawbSQLROTATION_YEAR: TSmallintField
      FieldName = 'ROTATION_YEAR'
    end
    object MawbSQLFK_PORT_CLEARING: TIntegerField
      FieldName = 'FK_PORT_CLEARING'
    end
    object MawbSQLGOODS_NUMBER: TIntegerField
      FieldName = 'GOODS_NUMBER'
    end
    object MawbSQLGOODS_DESCRIPTION: TStringField
      FieldName = 'GOODS_DESCRIPTION'
    end
    object MawbSQLCBOOK_NUMBER: TStringField
      FieldName = 'CBOOK_NUMBER'
      Size = 10
    end
    object MawbSQLMAWB_ID: TStringField
      FieldName = 'MAWB_ID'
      Size = 15
    end
    object MawbSQLINVOICED: TStringField
      FieldName = 'INVOICED'
      Required = True
      FixedChar = True
      Size = 1
    end
    object MawbSQLSENT_TO_HEAD: TStringField
      FieldName = 'SENT_TO_HEAD'
      Required = True
      FixedChar = True
      Size = 1
    end
    object MawbSQLCUSTOMS_OVERTIME_HOURS: TFloatField
      FieldName = 'CUSTOMS_OVERTIME_HOURS'
    end
    object MawbSQLCUSTOMS_OVERTIME_RATE: TFloatField
      FieldName = 'CUSTOMS_OVERTIME_RATE'
    end
    object MawbSQLSTORAGE_EXPENSES: TFloatField
      FieldName = 'STORAGE_EXPENSES'
    end
    object MawbSQLDELIVERY_EXPENSES: TFloatField
      FieldName = 'DELIVERY_EXPENSES'
    end
    object MawbSQLAMOUNT_NOT_INVOICED: TFloatField
      FieldName = 'AMOUNT_NOT_INVOICED'
    end
    object MawbSQLAMOUNT_INVOICED: TFloatField
      FieldName = 'AMOUNT_INVOICED'
    end
    object MawbSQLDATE_PASSED: TDateField
      FieldName = 'DATE_PASSED'
    end
    object MawbSQLGOODS_WEIGHT: TIntegerField
      FieldName = 'GOODS_WEIGHT'
    end
    object MawbSQLHAWBS_CLEARED_FIRST_TIME: TIntegerField
      FieldName = 'HAWBS_CLEARED_FIRST_TIME'
    end
    object MawbSQLHAWBS_IN_MAWB: TIntegerField
      FieldName = 'HAWBS_IN_MAWB'
    end
    object MawbSQLDOCS_NUMBER: TIntegerField
      FieldName = 'DOCS_NUMBER'
    end
    object MawbSQLDOCS_WEIGHT: TFloatField
      FieldName = 'DOCS_WEIGHT'
    end
    object MawbSQLHIGH_VALUE_NUMBER: TIntegerField
      FieldName = 'HIGH_VALUE_NUMBER'
    end
    object MawbSQLHIGH_VALUE_WEIGHT: TFloatField
      FieldName = 'HIGH_VALUE_WEIGHT'
    end
    object MawbSQLMEDIUM_VALUE_NUMBER: TIntegerField
      FieldName = 'MEDIUM_VALUE_NUMBER'
    end
    object MawbSQLMEDIUM_VALUE_WEIGHT: TFloatField
      FieldName = 'MEDIUM_VALUE_WEIGHT'
    end
    object MawbSQLLOW_VALUE_NUMBER: TIntegerField
      FieldName = 'LOW_VALUE_NUMBER'
    end
    object MawbSQLLOW_VALUE_WEIGHT: TFloatField
      FieldName = 'LOW_VALUE_WEIGHT'
    end
    object MawbSQLCUSTOMS_OVERTIME_RATE_TYPE: TStringField
      FieldName = 'CUSTOMS_OVERTIME_RATE_TYPE'
      FixedChar = True
      Size = 3
    end
    object MawbSQLXML_CONSOLIDATED_ID: TStringField
      FieldName = 'XML_CONSOLIDATED_ID'
      FixedChar = True
      Size = 13
    end
    object MawbSQLROTATION_2: TStringField
      FieldName = 'ROTATION_2'
      FixedChar = True
      Size = 2
    end
    object MawbSQLHMSD: TStringField
      FieldName = 'HMSD'
      FixedChar = True
    end
    object MawbSQLLOW_VALUE_TDID: TStringField
      FieldName = 'LOW_VALUE_TDID'
      FixedChar = True
    end
    object MawbSQLSTATUSC_NUMBER: TIntegerField
      FieldName = 'STATUSC_NUMBER'
    end
    object MawbSQLSTATUSC_WEIGHT: TIntegerField
      FieldName = 'STATUSC_WEIGHT'
    end
    object MawbSQLTDID_NEW: TStringField
      FieldName = 'TDID_NEW'
      FixedChar = True
      Size = 15
    end
    object MawbSQLF63: TStringField
      FieldName = 'F63'
      FixedChar = True
      Size = 15
    end
    object MawbSQLSTATUSC: TStringField
      FieldName = 'STATUSC'
      FixedChar = True
      Size = 15
    end
    object MawbSQLTDID_MEDIUM: TStringField
      FieldName = 'TDID_MEDIUM'
      FixedChar = True
      Size = 15
    end
  end
  object SenderInvoiceSQL: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO SENDER_INVOICE'
      
        '  (FK_HAWB_SERIAL, INVOICE_SERIAL, INVOICE_NUMBER, FK_HAWB_ID, I' +
        'NVOICE_AMOUNT, FREIGHT_AMOUNT, DISCOUNT_AMOUNT, INSURANCE_AMOUNT' +
        ', OTHER_CHARGES_AMOUNT, TOTAL_AMOUNT, CURRENCY, EXCHANGE_RATE, F' +
        'ACTOR, FREIGHT_CYP_AMOUNT, CUSTOMS_VALUE, FK_MAWB_SERIAL, IS_VAL' +
        'ID, NUMBER_OF_HAWB_ITEMS, PRE_DISCOUNT_AMOUNT, DISCOUNT_RATE, FA' +
        'CTOR_NUMERIC)'
      'VALUES'
      
        '  (:FK_HAWB_SERIAL, :INVOICE_SERIAL, :INVOICE_NUMBER, :FK_HAWB_I' +
        'D, :INVOICE_AMOUNT, :FREIGHT_AMOUNT, :DISCOUNT_AMOUNT, :INSURANC' +
        'E_AMOUNT, :OTHER_CHARGES_AMOUNT, :TOTAL_AMOUNT, :CURRENCY, :EXCH' +
        'ANGE_RATE, :FACTOR, :FREIGHT_CYP_AMOUNT, :CUSTOMS_VALUE, :FK_MAW' +
        'B_SERIAL, :IS_VALID, :NUMBER_OF_HAWB_ITEMS, :PRE_DISCOUNT_AMOUNT' +
        ', :DISCOUNT_RATE, :FACTOR_NUMERIC)')
    SQLDelete.Strings = (
      'DELETE FROM SENDER_INVOICE'
      'WHERE'
      
        '  FK_HAWB_SERIAL = :Old_FK_HAWB_SERIAL AND INVOICE_SERIAL = :Old' +
        '_INVOICE_SERIAL')
    SQLUpdate.Strings = (
      'UPDATE SENDER_INVOICE'
      'SET'
      
        '  FK_HAWB_SERIAL = :FK_HAWB_SERIAL, INVOICE_SERIAL = :INVOICE_SE' +
        'RIAL, INVOICE_NUMBER = :INVOICE_NUMBER, FK_HAWB_ID = :FK_HAWB_ID' +
        ', INVOICE_AMOUNT = :INVOICE_AMOUNT, FREIGHT_AMOUNT = :FREIGHT_AM' +
        'OUNT, DISCOUNT_AMOUNT = :DISCOUNT_AMOUNT, INSURANCE_AMOUNT = :IN' +
        'SURANCE_AMOUNT, OTHER_CHARGES_AMOUNT = :OTHER_CHARGES_AMOUNT, TO' +
        'TAL_AMOUNT = :TOTAL_AMOUNT, CURRENCY = :CURRENCY, EXCHANGE_RATE ' +
        '= :EXCHANGE_RATE, FACTOR = :FACTOR, FREIGHT_CYP_AMOUNT = :FREIGH' +
        'T_CYP_AMOUNT, CUSTOMS_VALUE = :CUSTOMS_VALUE, FK_MAWB_SERIAL = :' +
        'FK_MAWB_SERIAL, IS_VALID = :IS_VALID, NUMBER_OF_HAWB_ITEMS = :NU' +
        'MBER_OF_HAWB_ITEMS, PRE_DISCOUNT_AMOUNT = :PRE_DISCOUNT_AMOUNT, ' +
        'DISCOUNT_RATE = :DISCOUNT_RATE, FACTOR_NUMERIC = :FACTOR_NUMERIC'
      'WHERE'
      
        '  FK_HAWB_SERIAL = :Old_FK_HAWB_SERIAL AND INVOICE_SERIAL = :Old' +
        '_INVOICE_SERIAL')
    SQLRefresh.Strings = (
      
        'SELECT FK_HAWB_SERIAL, INVOICE_SERIAL, INVOICE_NUMBER, FK_HAWB_I' +
        'D, INVOICE_AMOUNT, FREIGHT_AMOUNT, DISCOUNT_AMOUNT, INSURANCE_AM' +
        'OUNT, OTHER_CHARGES_AMOUNT, TOTAL_AMOUNT, CURRENCY, EXCHANGE_RAT' +
        'E, FACTOR, FREIGHT_CYP_AMOUNT, CUSTOMS_VALUE, FK_MAWB_SERIAL, IS' +
        '_VALID, NUMBER_OF_HAWB_ITEMS, PRE_DISCOUNT_AMOUNT, DISCOUNT_RATE' +
        ', FACTOR_NUMERIC FROM SENDER_INVOICE'
      'WHERE'
      
        '  FK_HAWB_SERIAL = :FK_HAWB_SERIAL AND INVOICE_SERIAL = :INVOICE' +
        '_SERIAL')
    SQLLock.Strings = (
      'SELECT NULL FROM SENDER_INVOICE'
      'WHERE'
      
        'FK_HAWB_SERIAL = :Old_FK_HAWB_SERIAL AND INVOICE_SERIAL = :Old_I' +
        'NVOICE_SERIAL'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM SENDER_INVOICE'
      ''
      ') q')
    Connection = mainFRm.IBCConnection1
    Transaction = ReadTrans
    UpdateTransaction = WriteTrans
    SQL.Strings = (
      'select * from sender_invoice where fk_hawb_serial = :hawbSerial')
    Active = True
    Left = 304
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'hawbSerial'
        Value = nil
      end>
    object SenderInvoiceSQLFK_HAWB_SERIAL: TIntegerField
      FieldName = 'FK_HAWB_SERIAL'
      Required = True
    end
    object SenderInvoiceSQLINVOICE_SERIAL: TIntegerField
      FieldName = 'INVOICE_SERIAL'
      Required = True
    end
    object SenderInvoiceSQLINVOICE_NUMBER: TStringField
      FieldName = 'INVOICE_NUMBER'
      FixedChar = True
    end
    object SenderInvoiceSQLFK_HAWB_ID: TStringField
      FieldName = 'FK_HAWB_ID'
      FixedChar = True
      Size = 10
    end
    object SenderInvoiceSQLINVOICE_AMOUNT: TFloatField
      FieldName = 'INVOICE_AMOUNT'
    end
    object SenderInvoiceSQLFREIGHT_AMOUNT: TFloatField
      FieldName = 'FREIGHT_AMOUNT'
    end
    object SenderInvoiceSQLDISCOUNT_AMOUNT: TFloatField
      FieldName = 'DISCOUNT_AMOUNT'
    end
    object SenderInvoiceSQLINSURANCE_AMOUNT: TFloatField
      FieldName = 'INSURANCE_AMOUNT'
    end
    object SenderInvoiceSQLOTHER_CHARGES_AMOUNT: TFloatField
      FieldName = 'OTHER_CHARGES_AMOUNT'
    end
    object SenderInvoiceSQLTOTAL_AMOUNT: TFloatField
      FieldName = 'TOTAL_AMOUNT'
    end
    object SenderInvoiceSQLCURRENCY: TStringField
      FieldName = 'CURRENCY'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SenderInvoiceSQLEXCHANGE_RATE: TFloatField
      FieldName = 'EXCHANGE_RATE'
    end
    object SenderInvoiceSQLFACTOR: TFloatField
      FieldName = 'FACTOR'
    end
    object SenderInvoiceSQLFREIGHT_CYP_AMOUNT: TFloatField
      FieldName = 'FREIGHT_CYP_AMOUNT'
    end
    object SenderInvoiceSQLCUSTOMS_VALUE: TFloatField
      FieldName = 'CUSTOMS_VALUE'
    end
    object SenderInvoiceSQLFK_MAWB_SERIAL: TIntegerField
      FieldName = 'FK_MAWB_SERIAL'
    end
    object SenderInvoiceSQLIS_VALID: TStringField
      FieldName = 'IS_VALID'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SenderInvoiceSQLNUMBER_OF_HAWB_ITEMS: TIntegerField
      FieldName = 'NUMBER_OF_HAWB_ITEMS'
    end
    object SenderInvoiceSQLPRE_DISCOUNT_AMOUNT: TFloatField
      FieldName = 'PRE_DISCOUNT_AMOUNT'
    end
    object SenderInvoiceSQLDISCOUNT_RATE: TFloatField
      FieldName = 'DISCOUNT_RATE'
    end
    object SenderInvoiceSQLFACTOR_NUMERIC: TFloatField
      FieldName = 'FACTOR_NUMERIC'
    end
  end
  object HawbItemSQL: TIBCQuery
    KeyFields = 'SERIAL_NUMBER'
    KeyGenerator = 'HAWB_ITEM_KEY_GENERATOR'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO HAWB_ITEM'
      
        '  (SERIAL_NUMBER, FK_HAWB_SERIAL, FK_COUNTRY_ORIGIN, DESCRIPTION' +
        ', FK_RELIEF_CODE, FK_IMPORT_TYPE, INVOICE_VALUE, DUTY_TYPE, TARI' +
        'FF_DESCRIPTION, NET_QUANTITY, IMPORT_DUTY_RATE, RELIEVED_IMPORT_' +
        'DUTY, EXCISE_DUTY_RATE, EXCISE_RELIEVED, TRL_RATE, TRL_RELEIVED,' +
        ' VAT_RATE, VAT_RELEIVED, CUSTOMS_VALUE, CURRENCY_RATE, CURRENCY,' +
        ' FK_MAWB, FK_VAT_CODE, FK_TARIFF_C_CODE, FK_TARIFF_CODE, IMPORT_' +
        'DUTY_RATE_UNIT, IMPORT_DUTY_RATE_QUANT, IMPORT_DUTY_RATE_BASE, D' +
        'UTY_IMPORT_PAY, DUTY_TRL_PAY, DUTY_EXCISE_PAY, DUTY_VAT_PAY, DUT' +
        'Y_IMPORT_TOTAL, DUTY_EXCISE_TOTAL, DUTY_TRL_TOTAL, DUTY_VAT_TOTA' +
        'L, TOTAL_VALUE_FOR_VAT, DUTY_TOTAL_CHARGES, FK_EXCISE_CODE, EURO' +
        '1, EURO2, POSOSTOSIS, EURO_PENDING, FK_SENDER_INVOICE_SERIAL, MU' +
        'LTI_ITEMS_INVOICE, INVOICE_LINE, PRE_DISCOUNT_AMOUNT, WEIGHT_NET' +
        ', UNIT)'
      'VALUES'
      
        '  (:SERIAL_NUMBER, :FK_HAWB_SERIAL, :FK_COUNTRY_ORIGIN, :DESCRIP' +
        'TION, :FK_RELIEF_CODE, :FK_IMPORT_TYPE, :INVOICE_VALUE, :DUTY_TY' +
        'PE, :TARIFF_DESCRIPTION, :NET_QUANTITY, :IMPORT_DUTY_RATE, :RELI' +
        'EVED_IMPORT_DUTY, :EXCISE_DUTY_RATE, :EXCISE_RELIEVED, :TRL_RATE' +
        ', :TRL_RELEIVED, :VAT_RATE, :VAT_RELEIVED, :CUSTOMS_VALUE, :CURR' +
        'ENCY_RATE, :CURRENCY, :FK_MAWB, :FK_VAT_CODE, :FK_TARIFF_C_CODE,' +
        ' :FK_TARIFF_CODE, :IMPORT_DUTY_RATE_UNIT, :IMPORT_DUTY_RATE_QUAN' +
        'T, :IMPORT_DUTY_RATE_BASE, :DUTY_IMPORT_PAY, :DUTY_TRL_PAY, :DUT' +
        'Y_EXCISE_PAY, :DUTY_VAT_PAY, :DUTY_IMPORT_TOTAL, :DUTY_EXCISE_TO' +
        'TAL, :DUTY_TRL_TOTAL, :DUTY_VAT_TOTAL, :TOTAL_VALUE_FOR_VAT, :DU' +
        'TY_TOTAL_CHARGES, :FK_EXCISE_CODE, :EURO1, :EURO2, :POSOSTOSIS, ' +
        ':EURO_PENDING, :FK_SENDER_INVOICE_SERIAL, :MULTI_ITEMS_INVOICE, ' +
        ':INVOICE_LINE, :PRE_DISCOUNT_AMOUNT, :WEIGHT_NET, :UNIT)')
    SQLDelete.Strings = (
      'DELETE FROM HAWB_ITEM'
      'WHERE'
      '  SERIAL_NUMBER = :Old_SERIAL_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE HAWB_ITEM'
      'SET'
      
        '  SERIAL_NUMBER = :SERIAL_NUMBER, FK_HAWB_SERIAL = :FK_HAWB_SERI' +
        'AL, FK_COUNTRY_ORIGIN = :FK_COUNTRY_ORIGIN, DESCRIPTION = :DESCR' +
        'IPTION, FK_RELIEF_CODE = :FK_RELIEF_CODE, FK_IMPORT_TYPE = :FK_I' +
        'MPORT_TYPE, INVOICE_VALUE = :INVOICE_VALUE, DUTY_TYPE = :DUTY_TY' +
        'PE, TARIFF_DESCRIPTION = :TARIFF_DESCRIPTION, NET_QUANTITY = :NE' +
        'T_QUANTITY, IMPORT_DUTY_RATE = :IMPORT_DUTY_RATE, RELIEVED_IMPOR' +
        'T_DUTY = :RELIEVED_IMPORT_DUTY, EXCISE_DUTY_RATE = :EXCISE_DUTY_' +
        'RATE, EXCISE_RELIEVED = :EXCISE_RELIEVED, TRL_RATE = :TRL_RATE, ' +
        'TRL_RELEIVED = :TRL_RELEIVED, VAT_RATE = :VAT_RATE, VAT_RELEIVED' +
        ' = :VAT_RELEIVED, CUSTOMS_VALUE = :CUSTOMS_VALUE, CURRENCY_RATE ' +
        '= :CURRENCY_RATE, CURRENCY = :CURRENCY, FK_MAWB = :FK_MAWB, FK_V' +
        'AT_CODE = :FK_VAT_CODE, FK_TARIFF_C_CODE = :FK_TARIFF_C_CODE, FK' +
        '_TARIFF_CODE = :FK_TARIFF_CODE, IMPORT_DUTY_RATE_UNIT = :IMPORT_' +
        'DUTY_RATE_UNIT, IMPORT_DUTY_RATE_QUANT = :IMPORT_DUTY_RATE_QUANT' +
        ', IMPORT_DUTY_RATE_BASE = :IMPORT_DUTY_RATE_BASE, DUTY_IMPORT_PA' +
        'Y = :DUTY_IMPORT_PAY, DUTY_TRL_PAY = :DUTY_TRL_PAY, DUTY_EXCISE_' +
        'PAY = :DUTY_EXCISE_PAY, DUTY_VAT_PAY = :DUTY_VAT_PAY, DUTY_IMPOR' +
        'T_TOTAL = :DUTY_IMPORT_TOTAL, DUTY_EXCISE_TOTAL = :DUTY_EXCISE_T' +
        'OTAL, DUTY_TRL_TOTAL = :DUTY_TRL_TOTAL, DUTY_VAT_TOTAL = :DUTY_V' +
        'AT_TOTAL, TOTAL_VALUE_FOR_VAT = :TOTAL_VALUE_FOR_VAT, DUTY_TOTAL' +
        '_CHARGES = :DUTY_TOTAL_CHARGES, FK_EXCISE_CODE = :FK_EXCISE_CODE' +
        ', EURO1 = :EURO1, EURO2 = :EURO2, POSOSTOSIS = :POSOSTOSIS, EURO' +
        '_PENDING = :EURO_PENDING, FK_SENDER_INVOICE_SERIAL = :FK_SENDER_' +
        'INVOICE_SERIAL, MULTI_ITEMS_INVOICE = :MULTI_ITEMS_INVOICE, INVO' +
        'ICE_LINE = :INVOICE_LINE, PRE_DISCOUNT_AMOUNT = :PRE_DISCOUNT_AM' +
        'OUNT, WEIGHT_NET = :WEIGHT_NET, UNIT = :UNIT'
      'WHERE'
      '  SERIAL_NUMBER = :Old_SERIAL_NUMBER')
    SQLRefresh.Strings = (
      
        'SELECT SERIAL_NUMBER, FK_HAWB_SERIAL, FK_COUNTRY_ORIGIN, DESCRIP' +
        'TION, FK_RELIEF_CODE, FK_IMPORT_TYPE, INVOICE_VALUE, DUTY_TYPE, ' +
        'TARIFF_DESCRIPTION, NET_QUANTITY, IMPORT_DUTY_RATE, RELIEVED_IMP' +
        'ORT_DUTY, EXCISE_DUTY_RATE, EXCISE_RELIEVED, TRL_RATE, TRL_RELEI' +
        'VED, VAT_RATE, VAT_RELEIVED, CUSTOMS_VALUE, CURRENCY_RATE, CURRE' +
        'NCY, FK_MAWB, FK_VAT_CODE, FK_TARIFF_C_CODE, FK_TARIFF_CODE, IMP' +
        'ORT_DUTY_RATE_UNIT, IMPORT_DUTY_RATE_QUANT, IMPORT_DUTY_RATE_BAS' +
        'E, DUTY_IMPORT_PAY, DUTY_TRL_PAY, DUTY_EXCISE_PAY, DUTY_VAT_PAY,' +
        ' DUTY_IMPORT_TOTAL, DUTY_EXCISE_TOTAL, DUTY_TRL_TOTAL, DUTY_VAT_' +
        'TOTAL, TOTAL_VALUE_FOR_VAT, DUTY_TOTAL_CHARGES, FK_EXCISE_CODE, ' +
        'EURO1, EURO2, POSOSTOSIS, EURO_PENDING, FK_SENDER_INVOICE_SERIAL' +
        ', MULTI_ITEMS_INVOICE, INVOICE_LINE, PRE_DISCOUNT_AMOUNT, WEIGHT' +
        '_NET, UNIT FROM HAWB_ITEM'
      'WHERE'
      '  SERIAL_NUMBER = :SERIAL_NUMBER')
    SQLLock.Strings = (
      'SELECT NULL FROM HAWB_ITEM'
      'WHERE'
      'SERIAL_NUMBER = :Old_SERIAL_NUMBER'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM HAWB_ITEM'
      ''
      ') q')
    Connection = mainFRm.IBCConnection1
    Transaction = ReadTrans
    UpdateTransaction = WriteTrans
    SQL.Strings = (
      'select * from hawb_item where serial_number = :serialNumber')
    Active = True
    Left = 304
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'serialNumber'
        Value = nil
      end>
    object HawbItemSQLSERIAL_NUMBER: TIntegerField
      FieldName = 'SERIAL_NUMBER'
    end
    object HawbItemSQLFK_HAWB_SERIAL: TIntegerField
      FieldName = 'FK_HAWB_SERIAL'
      Required = True
    end
    object HawbItemSQLFK_COUNTRY_ORIGIN: TIntegerField
      FieldName = 'FK_COUNTRY_ORIGIN'
    end
    object HawbItemSQLDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 40
    end
    object HawbItemSQLFK_RELIEF_CODE: TStringField
      FieldName = 'FK_RELIEF_CODE'
      FixedChar = True
      Size = 5
    end
    object HawbItemSQLFK_IMPORT_TYPE: TStringField
      FieldName = 'FK_IMPORT_TYPE'
      Size = 1
    end
    object HawbItemSQLINVOICE_VALUE: TFloatField
      FieldName = 'INVOICE_VALUE'
    end
    object HawbItemSQLDUTY_TYPE: TStringField
      FieldName = 'DUTY_TYPE'
      FixedChar = True
      Size = 1
    end
    object HawbItemSQLTARIFF_DESCRIPTION: TStringField
      FieldName = 'TARIFF_DESCRIPTION'
      Size = 50
    end
    object HawbItemSQLNET_QUANTITY: TIntegerField
      FieldName = 'NET_QUANTITY'
    end
    object HawbItemSQLIMPORT_DUTY_RATE: TFloatField
      FieldName = 'IMPORT_DUTY_RATE'
    end
    object HawbItemSQLRELIEVED_IMPORT_DUTY: TFloatField
      FieldName = 'RELIEVED_IMPORT_DUTY'
    end
    object HawbItemSQLEXCISE_DUTY_RATE: TFloatField
      FieldName = 'EXCISE_DUTY_RATE'
    end
    object HawbItemSQLEXCISE_RELIEVED: TFloatField
      FieldName = 'EXCISE_RELIEVED'
    end
    object HawbItemSQLTRL_RATE: TFloatField
      FieldName = 'TRL_RATE'
    end
    object HawbItemSQLTRL_RELEIVED: TFloatField
      FieldName = 'TRL_RELEIVED'
    end
    object HawbItemSQLVAT_RATE: TFloatField
      FieldName = 'VAT_RATE'
    end
    object HawbItemSQLVAT_RELEIVED: TFloatField
      FieldName = 'VAT_RELEIVED'
    end
    object HawbItemSQLCUSTOMS_VALUE: TFloatField
      FieldName = 'CUSTOMS_VALUE'
    end
    object HawbItemSQLCURRENCY_RATE: TFloatField
      FieldName = 'CURRENCY_RATE'
    end
    object HawbItemSQLCURRENCY: TStringField
      FieldName = 'CURRENCY'
      FixedChar = True
      Size = 3
    end
    object HawbItemSQLFK_MAWB: TIntegerField
      FieldName = 'FK_MAWB'
    end
    object HawbItemSQLFK_VAT_CODE: TIntegerField
      FieldName = 'FK_VAT_CODE'
    end
    object HawbItemSQLFK_TARIFF_C_CODE: TStringField
      FieldName = 'FK_TARIFF_C_CODE'
      FixedChar = True
      Size = 17
    end
    object HawbItemSQLFK_TARIFF_CODE: TStringField
      FieldName = 'FK_TARIFF_CODE'
      Size = 17
    end
    object HawbItemSQLIMPORT_DUTY_RATE_UNIT: TStringField
      FieldName = 'IMPORT_DUTY_RATE_UNIT'
      FixedChar = True
      Size = 12
    end
    object HawbItemSQLIMPORT_DUTY_RATE_QUANT: TFloatField
      FieldName = 'IMPORT_DUTY_RATE_QUANT'
    end
    object HawbItemSQLIMPORT_DUTY_RATE_BASE: TFloatField
      FieldName = 'IMPORT_DUTY_RATE_BASE'
    end
    object HawbItemSQLDUTY_IMPORT_PAY: TFloatField
      FieldName = 'DUTY_IMPORT_PAY'
    end
    object HawbItemSQLDUTY_TRL_PAY: TFloatField
      FieldName = 'DUTY_TRL_PAY'
    end
    object HawbItemSQLDUTY_EXCISE_PAY: TFloatField
      FieldName = 'DUTY_EXCISE_PAY'
    end
    object HawbItemSQLDUTY_VAT_PAY: TFloatField
      FieldName = 'DUTY_VAT_PAY'
    end
    object HawbItemSQLDUTY_IMPORT_TOTAL: TFloatField
      FieldName = 'DUTY_IMPORT_TOTAL'
    end
    object HawbItemSQLDUTY_EXCISE_TOTAL: TFloatField
      FieldName = 'DUTY_EXCISE_TOTAL'
    end
    object HawbItemSQLDUTY_TRL_TOTAL: TFloatField
      FieldName = 'DUTY_TRL_TOTAL'
    end
    object HawbItemSQLDUTY_VAT_TOTAL: TFloatField
      FieldName = 'DUTY_VAT_TOTAL'
    end
    object HawbItemSQLTOTAL_VALUE_FOR_VAT: TFloatField
      FieldName = 'TOTAL_VALUE_FOR_VAT'
    end
    object HawbItemSQLDUTY_TOTAL_CHARGES: TFloatField
      FieldName = 'DUTY_TOTAL_CHARGES'
    end
    object HawbItemSQLFK_EXCISE_CODE: TStringField
      FieldName = 'FK_EXCISE_CODE'
      FixedChar = True
      Size = 5
    end
    object HawbItemSQLEURO1: TStringField
      FieldName = 'EURO1'
      FixedChar = True
    end
    object HawbItemSQLEURO2: TStringField
      FieldName = 'EURO2'
      FixedChar = True
    end
    object HawbItemSQLPOSOSTOSIS: TStringField
      FieldName = 'POSOSTOSIS'
      FixedChar = True
      Size = 1
    end
    object HawbItemSQLFK_SENDER_INVOICE_SERIAL: TIntegerField
      FieldName = 'FK_SENDER_INVOICE_SERIAL'
    end
    object HawbItemSQLMULTI_ITEMS_INVOICE: TStringField
      FieldName = 'MULTI_ITEMS_INVOICE'
      FixedChar = True
      Size = 1
    end
    object HawbItemSQLINVOICE_LINE: TIntegerField
      FieldName = 'INVOICE_LINE'
    end
    object HawbItemSQLPRE_DISCOUNT_AMOUNT: TFloatField
      FieldName = 'PRE_DISCOUNT_AMOUNT'
    end
    object HawbItemSQLWEIGHT_NET: TFloatField
      FieldName = 'WEIGHT_NET'
    end
    object HawbItemSQLUNIT: TStringField
      FieldName = 'UNIT'
      FixedChar = True
      Size = 3
    end
    object HawbItemSQLEURO_PENDING: TStringField
      FieldName = 'EURO_PENDING'
      FixedChar = True
      Size = 1
    end
  end
end
