unit GeneralProcedures;
interface
uses classes,sysutils;
const
         MAXW=3;
Type
  TItemType=(itMawb,itHawb,itInvoice,itItem,itSender);
  TDataType=(DTString, DTInteger,DTFloat, DTDate);

TTagRecord = Record
   TagName:String;
   TableName:String;
   FieldName:String;
   FIeldValue:String;
   IsNull:Boolean;
   IsSpecialTag:Boolean;
End;

TStackItem=class
 private
   FState:String;
   FItemType:TITemType;
 published
   property State :String Read Fstate write Fstate;
   property ItemType :TItemType Read FItemType write FItemType;
   Constructor Create(aState:string; aItemType:TItemType); overload;
 end;

TTag=class
  private
    FTagName : string;       //this is used as the key
    FFieldType: TDataType;  // to help convert to the data type
    FIsSpecialTag:boolean;    // NO content in this kind of tag elements
    FTableName:String;
    FFieldName:String;
    FFieldValue:String;
    FIsNull:Boolean;       // the value is null
  public
    constructor Create(TagName,TableName,FieldName,FIeldValue:String;IsSpecialTag:Boolean);Overload;

  published

    property TheTag: string read FTagName write FTagName;
    constructor Create(TagName,TableName,FieldName:String;IsSpecialTag:Boolean);Overload;
    function ReadTag: TTagRecord;
    function GetFullName: string;
  end;


TTableValues=class
// It is a stringlist and  holds the tags corresponding to the fields of the table along with their field names and values of one record.
  private
    AStringList:TStringList;
    Position:Integer;
  public

    Function AddNode(Const TagName,TableName,FieldName,FieldValue:String;IgnoreValue:Boolean):Boolean;overload;
  published

    constructor Create; overload;
    Destructor  Destroy; overload;

    Function AddNode(Const TagName,TableName,FieldName:String;IgnoreValue:Boolean):Boolean;  overload;
    function FindNode(TagName:String;Var TagRecord:TTagRecord): Boolean;
    function GoFirstNode: Boolean;
    function GetNextNode(Var TagRecord:TTagRecord): Boolean;

    function UpdateValue(TagName:String;FIeldValue:string): Boolean;
    {
    Procedure CleanValues;
    }
  end;

Function ConvertDate(TheString:String):TdateTime;


implementation

Function ConvertDate(TheString:String):TdateTime;
Var
    TheDate:TDateTime;
     Year,Month,Day:String;
Begin
     ShortDateFormat:='yyyy-mm-dd';
     DateSeparator:='-';
     try
        TheDate:=StrToDate(TheString);
     except
           TheDate:=int(Now);
     end;
     If TheDate < IncMonth(Now,-24) then begin
           TheDate:=IncMonth(Now,-4);
     end;
     ShortDateFormat:='dd/mm/yyyy';
     Result:=TheDate;
End;



//************************************************************
//* StackItem***********************************************************
//************************************************************

Constructor TStackItem.Create(aState:String;aItemType:TITemType);
Begin
        Inherited Create;
        FState:=aState;
        FItemType:=aItemType;
end;

//************************************************************
//* Tag ***********************************************************
//************************************************************
constructor Ttag.Create(TagName,TableName,FieldName:String;IsSpecialTag:Boolean);
begin
        Inherited Create;
        FTagName:=TagName;
        FTableName:=TableName;
        FFieldName:=FieldName;
        FIsSpecialTag:=IsSpecialTag;
End;

constructor Ttag.Create(TagName,TableName,FieldName,FieldValue:String;IsSpecialTag:Boolean);
begin
        Inherited Create;
        FTagName:=TagName;
        FTableName:=TableName;
        FFieldName:=FieldName;
        FFieldValue:=FieldValue;
        IsSpecialTag:=IsSpecialTag;
End;


function TtAG.GetFullName: string;
begin
  Result := FTagName+ ' -- '+FFieldName;// Or FLastName + ', ' + FFirstName
end;

function TtAG.ReadTag: TTagRecord;
begin

        Result.TagName:=FTagName;
        Result.TableName:=self.FTableName;
        Result.FieldName:=self.FFieldName;
        Result.FIeldValue:=Self.FFieldValue;
        Result.IsNull:=self.FIsNull;
        Result.IsSpecialTag:=self.FIsSpecialTag;
end;



//***************************************************************
// TTableValues
// It is a stringlist. stringlists were used because they provide a mapping function of a string to an object
// I wanted to construct a mapping of tags to a Set of Fields such as the tag, fieldname, the next state, etc
// A stringlist cannot use a Record as an object and therefore i needed classes
// 2. The TTag class is just an object with the tag information.
//
//***************************************************************


constructor TTableValues.Create;
begin
        Inherited Create;
        AStringList:=TStringList.Create;
End;

Destructor TTableValues.Destroy;
Var
        i:Integer;
        aTag:TTag;
begin
        for i:=0 to AStringList.Count-1 do begin
                aTag:=TTag(aStringList.Objects[i]);
                aTag.Free;
        end;
        If Assigned(AStringList) then
                 aStringList.Free;
        Inherited destroy;

End;


Function TTableValues.AddNode(Const TagName,TableName,FieldName:String;IgnoreValue:Boolean):Boolean;
begin
//SL.AddObject('ab', TTag.Create('tag1','mawb',TgMawb) );
        //creates a tag object and assigns it to the appropirate stringList of the Array
        aStringList.AddObject(TagName,TTag.Create(TagName,TableName,FieldName,IgnoreValue));
End;

Function TTableValues.AddNode(Const TagName,TableName,FieldName,FIeldValue:String;IgnoreValue:Boolean):Boolean;
begin
//SL.AddObject('ab', TTag.Create('tag1','mawb',TgMawb) );
        //creates a tag object and assigns it to the appropirate stringList of the Array
        aStringList.AddObject(TagName,TTag.Create(TagName,TableName,FieldName,FieldValue,IgnoreValue));
End;



function TTableValues.FindNode(TagName:String;Var TagRecord:TTagRecord): Boolean;
Var
        ATagRecord:TTagRecord;
        ATag:TTag;
        SL:TStringList;
        Index:Integer;
Begin
   SL:=aStringList;
   INdex:=SL.Indexof(TagName);
   if index>= 0 then begin
        aTag:=TTag(SL.Objects[Index]);
   end;

   Result:= Index>=0;
   If Result then begin
         TagRecord:= aTag.ReadTag;
   end;
End;

function TTableValues.GoFirstNode: Boolean;
Begin
        POsition:=-1; // GetNextRecord will now fetch the First Record

End;


function TTableValues.GetNextNode(Var TagRecord:TTagRecord): Boolean;
Var
        ATagRecord:TTagRecord;
        ATag:TTag;
        SL:TStringList;
        Index:Integer;
        MaxCount:Integer;
Begin

   SL:=AStringList;
   MaxCount:=SL.Count;
   Result:= Position< (MaxCount-1 ); //return false if read pass the last record

   If Result then begin
        Index:=POsition+1;
        POsition:=Index;
        aTag:=TTag(SL.Objects[Index]);
        TagRecord:= aTag.ReadTag;
   end;

End;




{
Procedure TTableValues.CleanValues;
Var
        SL:TStringList;
        State:TgState;
        i:Integer;
        aTag:TTag;
        TheFieldType:TDataType;
begin

For State:= TgMawb to TgItem do begin
        SL:=FSLArray[State];
        for i:=0 to SL.Count-1 do begin
                aTag:=TTag(SL.Objects[i]);
                atag.FIsNull:=True;
                TheFieldType:=aTag.FFieldType;
        end;
end;
End;
}

function TTableValues.UpdateValue(TagName:String;FIeldValue:string): Boolean;
Var
        ATagRecord:TTagRecord;
        ATag:TTag;
        SL:TStringList;
        Index:Integer;
Begin
        SL:=aStringList;
        Index:=SL.IndexOf(TagName);
        Result:=Index>=0;
        If Result then begin
                aTag:=TTag(SL.Objects[Index]);
                aTag.FFieldValue:=FieldValue;
                aTag.FIsNull:=False;
        end else begin
                // do i need to raise an exception ??

                 Raise Exception.CreateFmt('tag :%s was not created first', [TagName ]);
                //aTag.FIsNull:=True;
        end;

End;




end.
