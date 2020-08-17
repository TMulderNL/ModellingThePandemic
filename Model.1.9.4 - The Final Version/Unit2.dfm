object Form2: TForm2
  Left = 740
  Top = 187
  Caption = 'Model Information'
  ClientHeight = 531
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    439
    531)
  PixelsPerInch = 96
  TextHeight = 13
  object StaticText1: TStaticText
    Left = 40
    Top = 48
    Width = 259
    Height = 17
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'R0 = Transmisibility * Contact Rate * Illness Duration'
    TabOrder = 0
  end
  object StaticText2: TStaticText
    Left = 40
    Top = 71
    Width = 329
    Height = 17
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 
      'R0 = Transmisibility * (Contact Rate * Probability) * Illness Du' +
      'ration'
    TabOrder = 1
  end
end
