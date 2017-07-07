object mainFRm: TmainFRm
  Left = 0
  Top = 0
  Caption = 'mainFRm'
  ClientHeight = 423
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 304
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 304
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object IBCConnection1: TIBCConnection
    Database = 'C:\Data\DelphiProjects\Tariffs\TARIFF.FDB'
    ClientLibrary = 'C:\Data\DelphiProjects\TokyoReadXML\Programs\GDS32.DLL'
    Port = '3050'
    Username = 'SYSDBA'
    Server = 'localHost'
    Connected = True
    LoginPrompt = False
    Left = 104
    Top = 56
    EncryptedPassword = '92FF9EFF8CFF8BFF9AFF8DFF94FF9AFF86FF'
  end
end
