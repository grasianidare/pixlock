object fMain: TfMain
  Left = 286
  Top = 117
  BorderStyle = bsDialog
  Caption = 'PixLocker - Reloaded'
  ClientHeight = 194
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 8
    Top = 125
    Width = 54
    Height = 44
    AutoSize = False
    Caption = 'F2 to lock / unlock position'
    WordWrap = True
  end
  object pnCor: TPanel
    Left = 12
    Top = 70
    Width = 50
    Height = 49
    Caption = 'pnCor'
    TabOrder = 0
  end
  object pcOptions: TPageControl
    Left = 68
    Top = 70
    Width = 199
    Height = 119
    ActivePage = tbAbout
    Style = tsFlatButtons
    TabOrder = 1
    object tsData: TTabSheet
      Caption = 'Data'
      object gbRGB: TGroupBox
        Left = 8
        Top = 0
        Width = 81
        Height = 89
        Caption = 'RGB'
        TabOrder = 0
        object Label2: TLabel
          Left = 5
          Top = 21
          Width = 20
          Height = 13
          Caption = 'Red'
        end
        object Label3: TLabel
          Left = 5
          Top = 41
          Width = 29
          Height = 13
          Caption = 'Green'
        end
        object Label4: TLabel
          Left = 5
          Top = 61
          Width = 21
          Height = 13
          Caption = 'Blue'
        end
        object lblRed: TLabel
          Left = 38
          Top = 21
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label2'
        end
        object lblGreen: TLabel
          Left = 38
          Top = 41
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label3'
        end
        object lblBlue: TLabel
          Left = 38
          Top = 61
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
      end
      object GroupBox1: TGroupBox
        Left = 95
        Top = 0
        Width = 97
        Height = 89
        Caption = 'HSB'
        TabOrder = 1
        object Label5: TLabel
          Left = 5
          Top = 21
          Width = 20
          Height = 13
          Caption = 'Hue'
        end
        object Label6: TLabel
          Left = 5
          Top = 41
          Width = 48
          Height = 13
          Caption = 'Saturation'
        end
        object Label7: TLabel
          Left = 5
          Top = 61
          Width = 52
          Height = 13
          Caption = 'Luminance'
        end
        object lblHue: TLabel
          Left = 57
          Top = 21
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label2'
        end
        object lblSat: TLabel
          Left = 57
          Top = 41
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label3'
        end
        object lblBri: TLabel
          Left = 57
          Top = 61
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
      end
    end
    object tsOptions: TTabSheet
      Caption = 'Options'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 57
        Height = 13
        Caption = 'Interval (ms)'
      end
      object Label8: TLabel
        Left = 16
        Top = 72
        Width = 33
        Height = 13
        Caption = 'Radius'
      end
      object CbEnabled: TCheckBox
        Left = 100
        Top = 14
        Width = 97
        Height = 17
        Caption = 'Enabled'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CbEnabledClick
      end
      object edClock: TJvSpinEdit
        Left = 16
        Top = 14
        Width = 57
        Height = 21
        ButtonKind = bkClassic
        Decimal = 0
        MaxValue = 100000.000000000000000000
        MinValue = 5.000000000000000000
        Value = 100.000000000000000000
        TabOrder = 1
        OnChange = edClockChange
      end
      object EdRadius: TJvSpinEdit
        Left = 55
        Top = 64
        Width = 57
        Height = 21
        ButtonKind = bkClassic
        Decimal = 0
        MaxValue = 5000.000000000000000000
        MinValue = 1.000000000000000000
        Value = 10.000000000000000000
        TabOrder = 2
        OnChange = EdRadiusChange
      end
      object CbCalculate: TCheckBox
        Left = 8
        Top = 45
        Width = 129
        Height = 17
        Caption = 'Calculate media pixel'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = CbCalculateClick
      end
    end
    object tbAbout: TTabSheet
      Caption = 'About'
      ImageIndex = 2
      object Label9: TLabel
        Left = 3
        Top = 3
        Width = 123
        Height = 13
        Caption = 'PixLock V2 Reloaded'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 4
        Top = 16
        Width = 128
        Height = 13
        Caption = 'Grasiani Da R'#233' dos Santos'
      end
      object Label11: TLabel
        Left = 4
        Top = 30
        Width = 142
        Height = 13
        Caption = 'grasianisantos@yahoo.com.br'
      end
      object Label12: TLabel
        Left = 4
        Top = 56
        Width = 167
        Height = 13
        Caption = 'Version 2.11 - Release Candidate 2'
      end
      object Label14: TLabel
        Left = 4
        Top = 72
        Width = 182
        Height = 13
        Caption = 'Thanks Malow! - Now with madExcept'
      end
    end
  end
  object pnRed: TPanel
    Left = 12
    Top = 8
    Width = 255
    Height = 14
    BevelOuter = bvNone
    Caption = 'pnRed'
    Color = clRed
    ParentBackground = False
    TabOrder = 2
  end
  object pnGreen: TPanel
    Left = 12
    Top = 25
    Width = 255
    Height = 14
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clGreen
    ParentBackground = False
    TabOrder = 3
  end
  object pnBlue: TPanel
    Left = 12
    Top = 43
    Width = 255
    Height = 14
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clBlue
    ParentBackground = False
    TabOrder = 4
  end
  object tmGetPixelColor: TTimer
    OnTimer = tmGetPixelColorTimer
    Left = 224
    Top = 8
  end
end
