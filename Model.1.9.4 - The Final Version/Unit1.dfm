object Form1: TForm1
  Left = 100
  Top = 187
  Caption = 'Modelling the pandemic'
  ClientHeight = 822
  ClientWidth = 727
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    727
    822)
  PixelsPerInch = 96
  TextHeight = 13
  object Label40: TLabel
    Left = 126
    Top = 10
    Width = 8
    Height = 16
    Caption = '2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label38: TLabel
    Left = 105
    Top = 12
    Width = 13
    Height = 13
    Caption = 'of '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label37: TLabel
    Left = 42
    Top = 10
    Width = 30
    Height = 16
    Caption = 'Run:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object ScrollBox1: TScrollBox
    Left = -2
    Top = 48
    Width = 730
    Height = 781
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      726
      777)
    object Shape1: TShape
      Left = 16
      Top = 536
      Width = 692
      Height = 204
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 666
    end
    object Shape3: TShape
      Left = 16
      Top = 401
      Width = 691
      Height = 120
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 665
    end
    object VarOutput_Label: TLabel
      Left = 56
      Top = 552
      Width = 96
      Height = 13
      Caption = 'Variables Names:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object NumbOutput_Label: TLabel
      Left = 55
      Top = 581
      Width = 111
      Height = 13
      Caption = 'Variables Numbers: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Simulatieduur_Label: TLabel
      Left = 193
      Top = 440
      Width = 153
      Height = 13
      Caption = 'Total number of simulation Days'
    end
    object Label17: TLabel
      Left = 193
      Top = 413
      Width = 100
      Height = 13
      Caption = 'Number of Simulaties'
    end
    object IllnessLabel: TLabel
      Left = 198
      Top = 79
      Width = 107
      Height = 13
      Caption = 'Illness duration (days)'
      ParentShowHint = False
      ShowHint = True
    end
    object IntialcasesLabel: TLabel
      Left = 198
      Top = 26
      Width = 101
      Height = 13
      Caption = 'Initial Cases (people)'
    end
    object Label12: TLabel
      Left = 198
      Top = 106
      Width = 80
      Height = 13
      Caption = 'Dying probability'
    end
    object ContactVariation_Label: TLabel
      Left = 198
      Top = 138
      Width = 227
      Height = 13
      Caption = 'Effective R Variation ( used to be Contact Var.)'
    end
    object Populatie_Label: TLabel
      Left = 198
      Top = 165
      Width = 98
      Height = 13
      Caption = 'Total population size'
    end
    object ContactSd_Label: TLabel
      Left = 427
      Top = 138
      Width = 27
      Height = 13
      Caption = 'Sd. ='
      Visible = False
    end
    object ContactGemiddelde_Label: TLabel
      Left = 512
      Top = 138
      Width = 36
      Height = 13
      Caption = 'Gem. ='
      Visible = False
    end
    object IncubationLabel: TLabel
      Left = 198
      Top = 52
      Width = 124
      Height = 13
      Hint = 'In this model this period is non-infectious'
      Caption = 'Incubation period* (days)'
      ParentShowHint = False
      ShowHint = True
    end
    object VoorSD_Label: TLabel
      Left = 40
      Top = 201
      Width = 22
      Height = 13
      Caption = 'Day'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object IllnessValue_Label1: TLabel
      Left = 109
      Top = 79
      Width = 15
      Height = 13
      Caption = '     '
    end
    object IllnessValue_Label2: TLabel
      Left = 173
      Top = 79
      Width = 13
      Height = 13
      Caption = '(k)'
      Visible = False
    end
    object IncubationValue_Label1: TLabel
      Left = 109
      Top = 54
      Width = 15
      Height = 13
      Caption = '     '
    end
    object IncubationValue_Label2: TLabel
      Left = 173
      Top = 51
      Width = 13
      Height = 13
      Caption = '(k)'
      Visible = False
    end
    object Label39: TLabel
      Left = 553
      Top = 413
      Width = 143
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Run-Independent Values '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      ExplicitLeft = 527
    end
    object InfoBox: TLabel
      Left = 56
      Top = 629
      Width = 210
      Height = 13
      Caption = '[Available after the program has been run].'
    end
    object Label1: TLabel
      Left = 56
      Top = 610
      Width = 150
      Height = 13
      Caption = 'Simple statistics:  (means)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ContactSd: TLabel
      Left = 465
      Top = 138
      Width = 12
      Height = 13
      Caption = '...'
      Visible = False
    end
    object ContactGemiddelde: TLabel
      Left = 556
      Top = 138
      Width = 12
      Height = 13
      Caption = '...'
      Visible = False
    end
    object Label15: TLabel
      Left = 47
      Top = 235
      Width = 6
      Height = 13
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 109
      Top = 202
      Width = 96
      Height = 13
      Hint = 'Fraction of contacted people that get infected.'
      Caption = 'Transmissibility*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 369
      Top = 202
      Width = 74
      Height = 13
      Caption = 'Contact Rate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SCOverview: TLabel
      Left = 17
      Top = 303
      Width = 46
      Height = 11
      Caption = 'Overview:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label22: TLabel
      Left = 523
      Top = 301
      Width = 18
      Height = 13
      Caption = 'R0 '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 648
      Top = 552
      Width = 48
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Outputs '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      ExplicitLeft = 622
    end
    object CRinfoLabel: TLabel
      Left = 453
      Top = 203
      Width = 52
      Height = 11
      Caption = '(people/day)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 27
      Top = 10
      Width = 22
      Height = 11
      Caption = 'Distr.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object InitialCasesValue_Label: TLabel
      Left = 109
      Top = 31
      Width = 15
      Height = 13
      Caption = '     '
    end
    object Label2: TLabel
      Left = 293
      Top = 203
      Width = 34
      Height = 11
      Hint = 'Super Spreaders Distribution'
      Caption = 'Su.Sp.*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 193
      Top = 467
      Width = 143
      Height = 13
      Hint = 
        'The simulation is always calculated per day, but the output can ' +
        'also be simplified to weeks.'
      Caption = 'Output per "Day" or "Week" *'
      ParentShowHint = False
      ShowHint = True
    end
    object Label5: TLabel
      Left = 193
      Top = 492
      Width = 189
      Height = 13
      Hint = 
        'A new column will be added in the data file to show the simulati' +
        'on number'
      Caption = 'Simulation Numbers included in Output*'
      ParentShowHint = False
      ShowHint = True
    end
    object Label6: TLabel
      Left = 74
      Top = 204
      Width = 29
      Height = 11
      Caption = 'Weibull'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Shape2: TShape
      Left = 69
      Top = 200
      Width = 2
      Height = 97
    end
    object Shape4: TShape
      Left = 276
      Top = 200
      Width = 2
      Height = 97
    end
    object Shape5: TShape
      Left = 26
      Top = 221
      Width = 525
      Height = 2
    end
    object Label7: TLabel
      Left = 330
      Top = 203
      Width = 29
      Height = 11
      Caption = 'Weibull'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object TransInfoLabel: TLabel
      Left = 211
      Top = 204
      Width = 22
      Height = 11
      Caption = '(rate)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object TransmissibilityStart: TEdit
      Left = 110
      Top = 231
      Width = 85
      Height = 21
      TabOrder = 15
      Text = '0.0417'
    end
    object VarOutput_Veld: TEdit
      Left = 172
      Top = 549
      Width = 255
      Height = 21
      Hint = 'Output Field'
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 30
    end
    object NumbOutput_Veld: TEdit
      Left = 172
      Top = 576
      Width = 255
      Height = 21
      Hint = 'Output Field'
      ParentColor = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 31
    end
    object Dagen_Veld: TEdit
      Left = 52
      Top = 437
      Width = 50
      Height = 21
      NumbersOnly = True
      TabOrder = 28
      Text = '150'
    end
    object AantalSimulaties_Veld: TEdit
      Left = 52
      Top = 410
      Width = 50
      Height = 21
      NumbersOnly = True
      TabOrder = 26
      Text = '1000'
    end
    object IllnessMean_Veld1: TEdit
      Left = 54
      Top = 77
      Width = 49
      Height = 21
      Hint = 
        'The duration from ending of the incubation period until healthy.' +
        ' Infectous period.'
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Text = '10'
    end
    object Bereik_Veld1: TEdit
      Left = 133
      Top = 135
      Width = 34
      Height = 21
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      Text = '50'
      Visible = False
    end
    object Incubatietijd_Veld1: TEdit
      Left = 54
      Top = 50
      Width = 50
      Height = 21
      Hint = 'Duration of incubation period'
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '6'
    end
    object InitialCases_Veld1: TEdit
      Left = 54
      Top = 23
      Width = 49
      Height = 21
      Hint = 'Number of infected cases at the start of the simulation'
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '10'
    end
    object Verdeling_Veld1: TEdit
      Left = 53
      Top = 135
      Width = 50
      Height = 21
      Hint = '1: Truncated Cauchy Distribution, 2: Exponential distribtuion, '
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Text = '1'
      Visible = False
    end
    object Populatie_Veld1: TEdit
      Left = 54
      Top = 162
      Width = 49
      Height = 21
      Hint = 'The size of the total population'
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      Text = '10000'
    end
    object Sterfkans_Veld1: TEdit
      Left = 54
      Top = 103
      Width = 49
      Height = 21
      Hint = 'Probability per day of an infected person to die'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      Text = '0.001'
    end
    object DaySCinput: TEdit
      Left = 35
      Top = 260
      Width = 28
      Height = 21
      TabOrder = 19
    end
    object ContactRateStart: TEdit
      Left = 370
      Top = 231
      Width = 85
      Height = 21
      Hint = 'Infected people per day'
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      Text = '6'
    end
    object ContactRateSCinput: TEdit
      Left = 370
      Top = 261
      Width = 85
      Height = 21
      Hint = 'Infected people per day'
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 22
    end
    object TransmissibilitySCinput: TEdit
      Left = 110
      Top = 261
      Width = 85
      Height = 21
      TabOrder = 20
    end
    object IllnessWeibullShape_Veld1: TEdit
      Left = 133
      Top = 77
      Width = 34
      Height = 21
      Hint = 'Shape parameter of the Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Text = '2'
      Visible = False
    end
    object IncubationWeibullShape_Veld1: TEdit
      Left = 133
      Top = 50
      Width = 34
      Height = 21
      Hint = 'Shape parameter of the Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = '2'
      Visible = False
    end
    object SocialChangeInput: TButton
      Left = 596
      Top = 257
      Width = 112
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Input Social Change'
      TabOrder = 24
      OnClick = SocialChangeInputClick
    end
    object SocialChangeClear: TButton
      Left = 594
      Top = 360
      Width = 112
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Clear Social Changes'
      TabOrder = 25
      OnClick = SocialChangeClearClick
    end
    object ScrollBox2: TScrollBox
      Left = 16
      Top = 320
      Width = 552
      Height = 65
      TabOrder = 27
      object SCDay: TLabel
        Left = 25
        Top = 3
        Width = 12
        Height = 13
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object SCTransmissibility: TLabel
        Left = 87
        Top = 3
        Width = 12
        Height = 13
        Caption = '...'
      end
      object SCContactRate: TLabel
        Left = 281
        Top = 3
        Width = 12
        Height = 13
        Caption = '...'
      end
      object SCR0: TLabel
        Left = 505
        Top = 3
        Width = 12
        Height = 13
        Caption = '...'
      end
    end
    object InitialCasesCheckBox: TCheckBox
      Left = 32
      Top = 27
      Width = 16
      Height = 17
      Hint = 'Poisson Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = InitialCasesCheckBoxClick
    end
    object IncubationCheckBox: TCheckBox
      Left = 32
      Top = 52
      Width = 16
      Height = 17
      Hint = 'Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = IncubationCheckBoxClick
    end
    object IllnessCheckBox: TCheckBox
      Left = 32
      Top = 78
      Width = 12
      Height = 17
      Hint = 'Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = IllnessCheckBoxClick
    end
    object IncubationWeibullMeanCheckBox: TCheckBox
      Left = 438
      Top = 50
      Width = 155
      Height = 17
      Caption = 'Use distribution '#956' as constant'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
    object IllnessWeibullMeanCheckBox: TCheckBox
      Left = 438
      Top = 73
      Width = 155
      Height = 17
      Caption = 'Use distribution '#956' as constant'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      Visible = False
    end
    object ContactVariationCheckBox: TCheckBox
      Left = 31
      Top = 137
      Width = 16
      Height = 17
      Hint = 'Logarithmic or Cuachy'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = ContactVariationCheckBoxClick
    end
    object SuperspreaderStartCheckBox: TCheckBox
      Left = 299
      Top = 233
      Width = 12
      Height = 17
      Hint = 'Superspreaders'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      OnClick = SuperspreaderStartCheckBoxClick
    end
    object CRStartProbability: TEdit
      Left = 415
      Top = 231
      Width = 40
      Height = 21
      Hint = 'Probability of someone being a superspreader'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      Text = '0.1'
      Visible = False
    end
    object SuperspreaderCheckBox: TCheckBox
      Left = 299
      Top = 261
      Width = 12
      Height = 17
      Hint = 'Superspreaders - Skewed Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      OnClick = SuperspreaderCheckBoxClick
    end
    object CRProbability: TEdit
      Left = 416
      Top = 261
      Width = 40
      Height = 21
      Hint = 'Probability of someone being a superspreader'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 23
      Visible = False
    end
    object DayWeekOut: TEdit
      Left = 52
      Top = 464
      Width = 50
      Height = 21
      Hint = 'Choose "Day" or "Week"'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 29
      Text = 'Day'
    end
    object SimulationNumbers_CheckBox: TCheckBox
      Left = 71
      Top = 491
      Width = 11
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 32
      OnClick = SimulationNumbers_CheckBoxClick
    end
    object TransmissibilityStartCheckBox: TCheckBox
      Left = 84
      Top = 234
      Width = 15
      Height = 17
      Hint = 'Weibull Distribution'
      TabOrder = 33
      OnClick = TransmissibilityStartCheckBoxClick
    end
    object TransmissibilityStartShape: TEdit
      Left = 155
      Top = 231
      Width = 40
      Height = 21
      Hint = 'Shape parameter (k) of the Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 34
      Text = '2'
      Visible = False
    end
    object TransmissibilityStartWeibullMeanCheckBox: TCheckBox
      Left = 211
      Top = 233
      Width = 49
      Height = 17
      Hint = 'Use distribution '#956' as constant'
      Caption = 'Use '#956'*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 35
      Visible = False
    end
    object TransmissibilitySCShape: TEdit
      Left = 155
      Top = 261
      Width = 40
      Height = 21
      Hint = 'Shape parameter (k) of the Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 36
      Visible = False
    end
    object TransmissibilitySCWeibullMeanCheckBox: TCheckBox
      Left = 211
      Top = 262
      Width = 47
      Height = 17
      Hint = 'Use distribution '#956' as constant'
      Caption = 'Use '#956'*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 37
      Visible = False
    end
    object TransmissibilitySCCheckBox: TCheckBox
      Left = 84
      Top = 262
      Width = 15
      Height = 17
      Hint = 'Weibull Distribution'
      TabOrder = 38
      OnClick = TransmissibilitySCCheckBoxClick
    end
    object ContactRateStartWeibullCheckBox: TCheckBox
      Left = 337
      Top = 233
      Width = 12
      Height = 17
      TabOrder = 39
      OnClick = ContactRateStartWeibullCheckBoxClick
    end
    object ContactRateWeibullCheckBox: TCheckBox
      Left = 337
      Top = 261
      Width = 12
      Height = 17
      TabOrder = 40
      OnClick = ContactRateWeibullCheckBoxClick
    end
    object ContactRateStartShape: TEdit
      Left = 415
      Top = 231
      Width = 40
      Height = 21
      Hint = 'Shape parameter (k) of Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 41
      Text = '2'
      Visible = False
    end
    object ContactRateStartWeibullMeanCheckBox: TCheckBox
      Left = 470
      Top = 233
      Width = 54
      Height = 17
      Hint = 'Use Weibull distribution '#956' as constant'
      Caption = 'Use '#956'*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 42
      Visible = False
    end
    object ContactRateWeibullMeanCheckBox: TCheckBox
      Left = 470
      Top = 262
      Width = 48
      Height = 17
      Hint = 'Use Weibull distribution '#956' as constant'
      Caption = 'Use '#956'*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 43
      Visible = False
    end
    object ContactRateShape: TEdit
      Left = 416
      Top = 261
      Width = 40
      Height = 21
      Hint = 'Shape parameter (k) of Weibull Distribution'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 44
      Visible = False
    end
  end
  object RetrieveButton: TButton
    Left = 298
    Top = 7
    Width = 190
    Height = 25
    Caption = 'Unable to retrieve values yet'
    TabOrder = 3
    OnClick = RetrieveButtonClick
  end
  object InputButton: TButton
    Left = 190
    Top = 8
    Width = 94
    Height = 25
    Caption = 'Input Values'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = InputButtonClick
  end
  object RunInput_Veld: TEdit
    Left = 78
    Top = 7
    Width = 17
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Text = '1'
  end
  object OpenDialog1: TOpenDialog
    Left = 549
    Top = 674
  end
  object SaveDialog1: TSaveDialog
    Left = 493
    Top = 674
  end
  object MainMenu1: TMainMenu
    Left = 445
    Top = 674
    object Main1: TMenuItem
      Caption = 'Main'
      object Runsimulation1: TMenuItem
        Caption = 'Run model'
        OnClick = Runsimulation1Click
      end
      object ProgramInfo1: TMenuItem
        Caption = 'Program Info'
        OnClick = ProgramInfo1Click
      end
      object exit1: TMenuItem
        Caption = 'exit'
        OnClick = exit1Click
      end
    end
  end
end
