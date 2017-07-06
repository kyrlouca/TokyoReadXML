unit G_generalProcs;
//********** Add in the Implentation uses the form with the Database Connection
//*************************************************
//ksfillComboF1(cn,ComboBox,'table','fieldStored','FieldShown','orderbyField',ShowNoneOption);
// Last two params are optional, you can ommit order by and show none option
// remember to set map displayed value if you want to show other value
//**************************************************
interface

uses DBAccess, IBC, Data.DB, MemDS,IBCClasses,Forms,G_KyriacosTypes
, Messages, SysUtils, Classes, Graphics, Controls,  Dialogs,
  StdCtrls,RzDBRGrp,WwDBComb;

type
  Txxx =(trRead,trWrite);

procedure gpShowModal(AMyFormClass: TFormClass);
function IndexOfSList(str :String; strArray: array of String):integer;
Function GetSortInfo(TheTable:TIBCQuery ;Var SortInfo:TSortInfo):Boolean;
Function SortGrid(TheTable:TIBCQUery;AFieldName:String;SortInfo:TSortInfo):Boolean;
Function GetOneSystemParameter(TheKey,TheDescription:String;var Int1,Int2:Integer;var Num1:Double; Var Str1,str2:String):Boolean;
Function GetTheSystemParameter(Const Key:String):TParameterREcord;
Function ConvertDate(Const TheString:String):Tdate;
Function MyFormatDotFloat(Const DotAmount1 :String):double;
Procedure ksfillComboF1(Const connection: TIBCConnection; ComboBox: TwwDbComboBox;Const tableName,fieldstored,fieldShown:String; orderBy:String='';ShowEmpty:Boolean =false;ShowAll:boolean=false );

function ksfillRadioGroup(Const connection: TIBCConnection; RadioGroup:TrzDBRadioGroup;Const tableName,fieldValue,fieldShow:String;Const AllOption:Boolean ):TStrings;


implementation

uses G_KyrSQL,U_ClairDML;

function IndexOfSList(str :String; strArray: array of String):Integer;
var
  i:Integer;
begin
result:=-1;
  for I:= low(StrArray) to high(StrArray) do begin
    if str = strArray[i] then begin
      result:=i;
      break;
    end;

  end;

end;



procedure gpShowModal(AMyFormClass: TFormClass);
var
 form: TForm;
begin
//  form := AMyFormClass.Create(Application); // you can use nil if you Free it in here
  try
    form := AMyFormClass.Create(nil); // you can use nil if you Free it in here
    form.ShowModal;
  finally
//    form.Release; // generally better than Free for a Form
    form.free; // generally better than Free for a Form
  end;
end;



Function GetSortInfo(TheTable:TIBCQuery ;Var SortInfo:TSortInfo):Boolean;
Var
        CurrentSort:String;
        TheFieldName:String;
        AString:String;
begin

        CurrentSort:=Trim(TheTable.GetOrderBy);
        SortInfo.IsSorted:= CurrentSOrt>'';
        SortInfo.IsSortedAsc := Not (Pos('DESC',CurrentSort)>0);
        SortInfo.CurrentSortClause:=CurrentSort;

        AString:= StringReplace(CurrentSort,'DESC','',[rfReplaceAll, rfIgnoreCase]);
        AString:= StringReplace(CurrentSort,'ASC','',[rfReplaceAll, rfIgnoreCase]);
        SortInfo.CurrentSortField:=Trim(AString);
                if (theTable.FindField('serial_number') <> Nil) then begin
                        SOrtInfo.SerialNumber:=TheTable.FieldByName('Serial_number').AsInteger;
                end;


End;


Function SortGrid(TheTable:TIBCQUery;AFieldName:String;SortInfo:TSortInfo):Boolean;

Begin
// check the current field (as provided by click title button event)
// then sort ACS or DESC as the opposite of the current sort of the current field.
        GetSortInfo(TheTable,Sortinfo);
//        TheTable:=SortInfo.Table;

        TheTable.ControlsDisabled;
        TheTable.close;

         TheTable:=SortInfo.Table;
         If AFieldName=SortInfo.CurrentSortField then begin
                If SOrtInfo.IsSortedAsc then begin
                        TheTable.SetOrderBy(AFieldName + ' DESC');
                end else begin
                        TheTable.SetOrderBy(AFieldName + ' ASC');
                end;
         end else begin
                        TheTable.SetOrderBy(AFieldName + ' ASC');
         end;

        TheTable.open;
        if (theTable.FindField('serial_number') <> Nil) then begin
                TheTable.Locate('serial_Number',SOrtInfo.SerialNumber,[]);
        end;

        TheTable.EnableControls;

End;



Function GetOneSystemParameter(TheKey,TheDescription:String;var Int1,Int2:Integer;var Num1:Double; Var Str1,str2:String):Boolean;
Var
        x1:Double;
        qr:TksQuery;
        cn:TIBCConnection;
Begin
  cn:=ClairDML.CabCOnnection;
  try
    qr:=TksQuery.Create(cn,' select *  from System_Parameters where parameter_id= :TheKey');
    qr.ParambyName('TheKey').Value:=TheKey;
    qr.Open;
        If not qr.IsEmpty then begin
        Int1:=qr.FieldByName('Int_1').asInteger;
        Int2:=qr.FieldByName('Int_2').asInteger;
        Num1:=qr.FieldByName('Num_1').asFloat;
        Str1:=qr.FieldByName('Str_1').asString;
        Str2:=qr.FieldByName('Str_2').asString;
        End;
    result:=not qr.IsEmpty;
    qr.Close;
  finally
    qr.Free;
end;

End;


Function GetTheSystemParameter(Const Key:String):TParameterREcord;
Var
        x1:Double;
        qr:TksQuery;
        cn:TIBCConnection;
Begin
  cn:=ClairDML.CabCOnnection;
  try
    qr:=TksQuery.Create(cn,' select *  from System_Parameters where parameter_id= :TheKey');
    qr.ParambyName('TheKey').Value:= Key;
    qr.Open;
    If  qr.IsEmpty then begin
      Result.P_ID:='';
    end;
    with qr do begin
        Result.P_ID :=qr.FieldByName('PARAMETER_ID').assTRING;
        Result.P_Integer1:=FieldByName('Int_1').asInteger;
        Result.P_Integer2:=FieldByName('Int_2').asInteger;
        Result.P_String1:=FieldByName('Str_1').asString;
        Result.P_String2:=FieldByName('Str_2').asString;
        Result.P_String3:=FieldByName('Str_3').asString;
        Result.P_String4:=FieldByName('Str_4').asString;
        Result.P_Float1:=FieldByName('NUM_1').asFloat;
        Result.P_Float2:=FieldByName('NUM_2').asFloat;
     end;
  finally
    qr.Free;
  end;

End;



Function ConvertDate(Const TheString:String):Tdate;
Var
    TheDate:TDate;
     Year,Month,Day:Integer;
     PcFormat:String;
Begin
//     ShortDateFormat:='dd/mm/yyyy';

//  PcFormat:=ShortDateFormat;

        day:=StrToIntDef(copy(TheString,1,2),-1);
        month:=StrToIntDef(copy(TheString,4,2),-1);
        Year:=StrToIntDef(copy(TheString,7,4),-1);
  try
       TheDate:=encodeDate(Year,month,day);
  except
        TheDate:=encodeDate(1999,12,31);
   end;
   result:=TheDate;
End;


Function MyFormatDotFloat(Const DotAmount1 :String):double;
// getting a string with DOT decimal and convert it to the localized format
Var
        PCSeparator: Char;
        AmountLocal:double;
        AmountStr:String;
        astr:string;
begin
        PCSeparator:=FormatSettings.DecimalSeparator;
        AmountStr:=StringReplace ( DotAmount1,',','',[rfReplaceAll] );

        If (PcSeparator='.') then begin
                try
                        AmountLocal:=StrToFloat(AmountStr);
                except
                        AmountLocal:=0;
                end;
        end else begin
        //Local pc has a different decimal separator than DOT // and our string is DOT
                try
                        try
                                FormatSettings.DecimalSeparator := '.';
                                AmountLocal := StrtoFloat(AmountStr);
                        except on E:exception do
                                AmountLocal:=0;
                        end;
                finally
                        FormatSettings.DecimalSeparator := PCSeparator;
                end;
        end;
        result:= AmountLocal;

end;


function ksfillRadioGroup(Const connection: TIBCConnection; RadioGroup:TrzDBRadioGroup;Const tableName,fieldValue,fieldShow:String;Const AllOption:Boolean ):TStrings;

//   function TV_HawbFRM.setClearanceInstructions():boolean;
var
  qr :TksQuery;
  str:String;
  cVal:String;
  cDesc:String;
begin

  Try
    str:='select '+ fieldValue+ ', '+fieldShow+ ' from '+tableName;

    qr:=TksQuery.Create(connection,str);
    qr.Open;
    RadioGroup.Items.Clear;
    RadioGroup.Values.Clear;
    if AllOption then begin
      RadioGroup.Items.Add('All');
      RadioGroup.Values.Add('Show All');
    end;

    while not qr.Eof do begin
     cVal:=qr.FieldByName(fieldValue).AsString;
      cDesc:=qr.FieldByName(FieldShow).AsString;
      RadioGroup.Items.Add(cDesc);
      RadioGroup.Values.Add(cVal);
      qr.Next;
    end;

  Finally
    qr.Free;
  End;

end;


Procedure ksfillComboF1(Const connection: TIBCConnection; ComboBox: TwwDbComboBox;Const tableName,fieldstored,fieldShown:String; orderBy:String='';ShowEmpty:Boolean =false;ShowAll:boolean=false );
 var
  tableSQL: TksQUery;
  str:String;
  val:String;
begin
 try
  ComboBox.Items.Clear;
  if (trim(fieldShown)>'') then begin
    str:='select '+ fieldStored+ ', '+fieldShown+ ' from '+tableName;
  end else begin
    str:='select '+ fieldStored+ ' from '+tableName;
  end;

  if (trim(orderBy)>'') then begin
    str :=Str + ' order by '+orderBy;
  end;


  if ShowEmpty then begin
    ComboBox.Items.Add('None');
  end;

  if ShowAll then begin
    ComboBox.Items.Add('All');
  end;

  tableSQL:=TksQuery.Create(connection,str);
  With TableSQL do begin
    Open;
    While ( NOT TableSQL.Eof)do begin
                val:=TableSQL.fieldbyName(fieldStored).AsString;
                if Trim(FieldShown)>'' then begin
                  val:=TableSQL.fieldbyName(fieldShown).AsString+#9+val;
                end;
                ComboBox.Items.add(val);
                TableSQL.Next;
    end;
    close;
  end;
 finally
  tableSQL.Free;
 end;


 end;


end.
