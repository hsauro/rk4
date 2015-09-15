object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'RK4'
  ClientHeight = 484
  ClientWidth = 840
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object memo: TMemo
    Left = 106
    Top = 41
    Width = 734
    Height = 443
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 840
    Height = 41
    Align = alTop
    Alignment = taRightJustify
    BevelOuter = bvNone
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 14
      Width = 98
      Height = 13
      Caption = 'RK4 Test Application'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 106
    Height = 443
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 38
      Width = 44
      Height = 13
      Caption = 'Step Size'
    end
    object Label2: TLabel
      Left = 8
      Top = 86
      Width = 84
      Height = 13
      Caption = 'Number of Steps:'
    end
    object btnRun: TButton
      Left = 8
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = btnRunClick
    end
    object edtStepSize: TEdit
      Left = 8
      Top = 54
      Width = 75
      Height = 21
      TabOrder = 1
      Text = '0.05'
    end
    object edtNumberOfSteps: TEdit
      Left = 8
      Top = 102
      Width = 75
      Height = 21
      TabOrder = 2
      Text = '100'
    end
  end
end
