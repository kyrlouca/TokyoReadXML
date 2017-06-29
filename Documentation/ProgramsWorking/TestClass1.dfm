object TestClass1FRM: TTestClass1FRM
  Left = 468
  Top = 146
  Width = 1142
  Height = 656
  Caption = 'TestClass1FRM'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 168
    Top = 56
    Width = 428
    Height = 83
    Caption = 'Test Classes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -75
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 136
    Top = 192
    Width = 97
    Height = 25
    Caption = 'Create Class'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 288
    Width = 273
    Height = 25
    Caption = 'Test Objectlist to be used for stack'
    TabOrder = 1
    OnClick = Button2Click
  end
end
