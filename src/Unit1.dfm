object Form1: TForm1
  Left = 607
  Top = 285
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Jabber Host'
  ClientHeight = 252
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 18
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object Label2: TLabel
    Left = 16
    Top = 88
    Width = 101
    Height = 13
    Caption = 'Authentication String:'
  end
  object Label3: TLabel
    Left = 16
    Top = 186
    Width = 25
    Height = 13
    Caption = 'User:'
  end
  object Label4: TLabel
    Left = 16
    Top = 218
    Width = 49
    Height = 13
    Caption = 'Password:'
  end
  object Label14: TLabel
    Left = 192
    Top = 20
    Width = 163
    Height = 13
    Caption = 'Copyright (c) 2011 Opt-In Software'
  end
  object Label5: TLabel
    Left = 192
    Top = 44
    Width = 90
    Height = 13
    Cursor = crHandPoint
    Caption = 'www.optinsoft.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label5Click
  end
  object Button1: TButton
    Left = 16
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 48
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '9999'
  end
  object Button3: TButton
    Left = 312
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 112
    Width = 369
    Height = 57
    ParentColor = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
    WordWrap = False
  end
  object Edit2: TEdit
    Left = 56
    Top = 184
    Width = 249
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 5
  end
  object Edit3: TEdit
    Left = 80
    Top = 216
    Width = 225
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 6
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = IdTCPServer1Execute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 136
    Top = 88
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 168
    Top = 88
  end
end
