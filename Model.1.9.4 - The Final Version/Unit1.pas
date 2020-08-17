unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.DateUtils, System.Variants,
  System.Classes, Vcl.Graphics, Unit2,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, System.Math,
  Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Shape1: TShape;
    Shape3: TShape;
    VarOutput_Label: TLabel;
    NumbOutput_Label: TLabel;
    Simulatieduur_Label: TLabel;
    Label17: TLabel;
    IllnessLabel: TLabel;
    IntialcasesLabel: TLabel;
    Label12: TLabel;
    ContactVariation_Label: TLabel;
    Populatie_Label: TLabel;
    ContactSd_Label: TLabel;
    ContactGemiddelde_Label: TLabel;
    IncubationLabel: TLabel;
    VoorSD_Label: TLabel;
    IllnessValue_Label1: TLabel;
    IllnessValue_Label2: TLabel;
    IncubationValue_Label1: TLabel;
    IncubationValue_Label2: TLabel;
    Label39: TLabel;
    InfoBox: TLabel;
    Label1: TLabel;
    ContactSd: TLabel;
    ContactGemiddelde: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    SCOverview: TLabel;
    Label22: TLabel;
    Label3: TLabel;
    CRinfoLabel: TLabel;
    VarOutput_Veld: TEdit;
    NumbOutput_Veld: TEdit;
    Dagen_Veld: TEdit;
    AantalSimulaties_Veld: TEdit;
    IllnessMean_Veld1: TEdit;
    Bereik_Veld1: TEdit;
    Incubatietijd_Veld1: TEdit;
    InitialCases_Veld1: TEdit;
    Verdeling_Veld1: TEdit;
    Populatie_Veld1: TEdit;
    Sterfkans_Veld1: TEdit;
    DaySCinput: TEdit;
    TransmissibilityStart: TEdit;
    ContactRateStart: TEdit;
    ContactRateSCinput: TEdit;
    TransmissibilitySCinput: TEdit;
    IllnessWeibullShape_Veld1: TEdit;
    IncubationWeibullShape_Veld1: TEdit;
    SocialChangeInput: TButton;
    SocialChangeClear: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    Main1: TMenuItem;
    Runsimulation1: TMenuItem;
    exit1: TMenuItem;
    RetrieveButton: TButton;
    InputButton: TButton;
    Label40: TLabel;
    Label38: TLabel;
    RunInput_Veld: TEdit;
    Label37: TLabel;
    ScrollBox2: TScrollBox;
    SCDay: TLabel;
    SCTransmissibility: TLabel;
    SCContactRate: TLabel;
    SCR0: TLabel;
    Label10: TLabel;
    InitialCasesCheckBox: TCheckBox;
    IncubationCheckBox: TCheckBox;
    IllnessCheckBox: TCheckBox;
    InitialCasesValue_Label: TLabel;
    IncubationWeibullMeanCheckBox: TCheckBox;
    IllnessWeibullMeanCheckBox: TCheckBox;
    ContactVariationCheckBox: TCheckBox;
    ProgramInfo1: TMenuItem;
    SuperspreaderStartCheckBox: TCheckBox;
    CRStartProbability: TEdit;
    Label2: TLabel;
    SuperspreaderCheckBox: TCheckBox;
    CRProbability: TEdit;
    DayWeekOut: TEdit;
    Label4: TLabel;
    SimulationNumbers_CheckBox: TCheckBox;
    Label5: TLabel;
    TransmissibilityStartCheckBox: TCheckBox;
    TransmissibilityStartShape: TEdit;
    Label6: TLabel;
    TransmissibilityStartWeibullMeanCheckBox: TCheckBox;
    Shape2: TShape;
    Shape4: TShape;
    Shape5: TShape;
    TransmissibilitySCShape: TEdit;
    TransmissibilitySCWeibullMeanCheckBox: TCheckBox;
    TransmissibilitySCCheckBox: TCheckBox;
    Label7: TLabel;
    ContactRateStartWeibullCheckBox: TCheckBox;
    ContactRateWeibullCheckBox: TCheckBox;
    ContactRateStartShape: TEdit;
    TransInfoLabel: TLabel;
    ContactRateStartWeibullMeanCheckBox: TCheckBox;
    ContactRateWeibullMeanCheckBox: TCheckBox;
    ContactRateShape: TEdit;
    procedure exit1Click(Sender: TObject);
    procedure Runsimulation1Click(Sender: TObject);
    procedure InputButtonClick(Sender: TObject);
    procedure RetrieveButtonClick(Sender: TObject);
    procedure SocialChangeInputClick(Sender: TObject);
    procedure SocialChangeClearClick(Sender: TObject);
    procedure InitialCasesCheckBoxClick(Sender: TObject);
    procedure IncubationCheckBoxClick(Sender: TObject);
    procedure IllnessCheckBoxClick(Sender: TObject);
    procedure ContactVariationCheckBoxClick(Sender: TObject);
    procedure ProgramInfo1Click(Sender: TObject);
    procedure SuperspreaderStartCheckBoxClick(Sender: TObject);
    procedure SuperspreaderCheckBoxClick(Sender: TObject);
    procedure SimulationNumbers_CheckBoxClick(Sender: TObject);
    procedure TransmissibilityStartCheckBoxClick(Sender: TObject);
    procedure TransmissibilitySCCheckBoxClick(Sender: TObject);
    procedure ContactRateStartWeibullCheckBoxClick(Sender: TObject);
    procedure ContactRateWeibullCheckBoxClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  maxruns = 2;
  maxdays = 1000;
  maxsimulations = 10000;
  maxpopulation = 1000000;

  maxSC = 50;
  maxvariables = 10;
  maxreachPoisson = 100;
  maxreachWeibull = 100;
  maxreachNormal = 100;

var
{$REGION 'Declaring Variables'}
  data
    : array [1 .. maxruns, 1 .. maxpopulation, 1 .. 4] of integer;                // data[run,persoon,1] is 0 als iemand gezond is, > 0 geeft het aantal dagen sinds besmetting aan
                                                                                  // data[run,persoon,2] is 0: gezond, 1: incubatie, 2: symptomen, 3: gezond, 4: dood
  dist_contact,                                                                   // data[run,persoon,3] is persoonlijke ziekteduur
  dist_initial                                                                    // data[run,persoon,4] is persoonlijke incubatietijd
    : array [1 .. maxruns, 0 .. maxreachPoisson] of extended;

  dist_weibull
    : array [1 .. maxruns, 1 .. maxvariables, 0 .. maxreachWeibull] of extended;  // the second position is to store for which variable the distribution is made

  dist_weibull_mean,
  dist_normal_mean
    : array [1 .. maxruns, 1 .. maxvariables] of extended;

  dist_normal
    : array [1 .. maxruns, 1 .. maxvariables, 0 .. maxreachNormal] of extended;  // the second position is to store for which variable the distribution is made

  healthy,
  dead,
  healed,
  infected
    : array [1 .. maxruns, 1 .. maxsimulations, 1 .. maxdays] of extended;        // run, simulation, day

  mhealthy,
  minfected
    : array [1 .. maxruns, 1 .. maxdays] of extended;                             // run, day

  transstep
    : extended;

  currentinput,
  SCmoment,
  run
    : integer;

  inputcount: integer = 0;
  SCcount: array [1 .. maxruns] of integer = (1,1);

  R0,
  mean,
  somsq
    : array [1 .. maxruns] of extended;

  dayoutput
    : array [1 .. maxruns, 1 .. maxsimulations, 1 .. maxdays] of string;

  d,
  simnumstr
    : string;

  uitvoer
    : text;

  // variables to be outputted in textbox

  poissontoggle,
  incubationWeibullToggle,
  incubationWeibullmeanToggle,
  illnessWeibullToggle,
  illnessWeibullmeanToggle,
  contactvariationToggle,
  incubation,
  ziekteduur,
  initialcases,
  verdelingtipe,
  bereik,
  bevolking
    : array [1 .. maxruns] of integer;

  illnessWeibullShape,
  incubationWeibullShape,
  sterfkans
    : array [1 .. maxruns] of extended;

  DaySC
    : array [1 .. maxruns, 1 .. maxSC] of integer;

  ContactRateSC,                                                                   // Run, SCmoment, [Toggle, Contact Rate, Probability]
  TransmissibilitySC
    : array [1 .. maxruns, 1 .. maxSC, 1..6] of extended;

  Nsimulatie,
  dagen,
  showsimulationnumbers,
  seed
    : integer;

  dayweekoutput
    : string;
  // end output variables

{$ENDREGION}

{$REGION 'Distributions'}

procedure verd_contact(tipe, bereik_contact: integer);
var
  i, j: integer;
  som: extended;
begin
  j := bereik_contact;
  mean[run] := 0.0;
  somsq[run] := 0.0;

  if tipe = 1 then       // truncated cauchy
  begin
    som := 0.0;

    for i := 0 to j do
    begin
      dist_contact[run,i] := 1.0 / (i * i + 20.0);
      som := som + dist_contact[run,i];
      mean[run] := mean[run] + i * dist_contact[run,i];
      somsq[run] := somsq[run] + i * i * dist_contact[run,i];
    end;

    mean[run] := mean[run] / som;
    somsq[run] := sqrt(somsq[run] / som - mean[run] * mean[run]);

    for i := 0 to j do
    begin
      dist_contact[run,i] := dist_contact[run,i] / som;
      if i > 0 then
        dist_contact[run,i] := dist_contact[run,i - 1] + dist_contact[run,i];
    end;

    Form1.ContactGemiddelde.Caption := floattostr(Round(mean[currentinput]*100)/100);
    Form1.ContactSd.Caption := floattostr(Round(somsq[currentinput]*100)/100);

  end;

  if tipe = 2 then       // exponentieel
  begin
    som := 0.0;

    for i := 0 to j do
    begin
      dist_contact[run,i] := exp(-i/10);
      som := som + dist_contact[run,i];
      mean[run] := mean[run] + i * dist_contact[run,i];
      somsq[run] := somsq[run] + i * i * dist_contact[run,i];
    end;

    mean[run] := mean[run] / som;
    somsq[run] := somsq[run] / som;

    for i := 0 to j do
    begin
      dist_contact[run,i] := dist_contact[run,i] / som;
      if i > 0 then
        dist_contact[run,i] := dist_contact[run,i - 1] + dist_contact[run,i];
    end;

    Form1.ContactGemiddelde.Caption := floattostr(Round(mean[currentinput]*100)/100);
    Form1.ContactSd.Caption := floattostr(Round(somsq[currentinput]*100)/100);

  end;
end;

procedure verd_initial(mean: integer);                                            //dit is de poisson verdeling hoe ik die erin verwerkt heb
 var
  i, reach: integer;
  factorial: extended;

begin
  reach := maxreachPoisson;                                                                       // length of array
  factorial := 1;

  for i := 1 to reach-1 do
    begin
      factorial := i * factorial;
      dist_initial[run,i] := ((power(mean,i))*exp(-mean))/factorial;
    end;

  for i := 1 to reach-1 do
    begin
      dist_initial[run,i] := dist_initial[run,i-1] + dist_initial[run,i];
    end;

  dist_initial[run,reach] := 1;

end;

procedure verd_weibull(v: integer; scale, shape, stepvalue: extended);
var
  i, repetitions: integer;
  sum, meanvalue, x, value: extended;
  //valuearray: array [1 .. maxreachweibull];
begin
  repetitions := maxreachweibull;
  sum := 0;
  meanvalue := 0;

    for i := 1 to repetitions-1 do
      begin                                                                       //(shape/scale)*power(step/scale,shape-1)*exp(-(power(step/scale,shape)))  == (k/λ(x/λ)^k-1)(e^-(x/λ)^k)
        x := stepvalue * i;
        dist_weibull[run,v,i] := 1-exp(-(power(x/scale,shape)));                  // 1-(e^-(x/λ)^k)  <-- This is apperently already the commumaltive function

        value := (shape/scale)*power(x/scale,shape-1)*exp(-(power(x/scale,shape))); // However to calculate the mean I need to have every single value
        sum := sum + value;
        meanvalue := meanvalue + x * value;
      end;

    //for i := 2 to repetitions-1 do
    //  begin
    //    dist_weibull[run,v,i] := dist_weibull[run,v,i-1] + dist_weibull[run,v,i]
    //  end;

    //if shape <= 1 then                                                            // What was this for? Don't think I'm using this but it will do something..
    //  begin
    //    for x := 1 to repetitions-1 do
    //      begin
    //        dist_weibull[run,v,x] := dist_weibull[run,v,x-1]/som
    //      end;
    //  end;

    dist_weibull_mean[run,v] := meanvalue/sum;
    dist_weibull[run,v,repetitions] := 1;                                               // Cumulative Weibull distribution might not reach 1 by itself

end;


procedure verd_normal(v: integer; mean, sd, stepvalue: extended);                   // NOT USED IN PROGRAM AT THIS POINT IN TIME   & NOT yet TESTED
//var
//  i, repetitions: integer;
//  som, meanvalue, x: extended;
begin
(*
  repetitions := maxreachnormal;
  som := 0;
  meanvalue := 0;
  x := stepvalue;

    for i := 1 to repetitions-1 do
      begin
        dist_normal[run,v,x] := ( 2/( sqrt(2*Pi)*mean )) * ( exp(-0.5(power(x-mean)/sd,2))); // ( 2/( sqrt(2*pi)*σ ) * e^(-0.5( (x-μ)/σ )^2
        som := som + dist_normal[run,v,x];
        meanvalue := meanvalue + x * dist_normal[run,v,x];
        x := stepvalue * i;
      end;

    for x := 2 to repetitions-1 do
      begin
        dist_normal[run,v,x] := dist_normal[run,v,x-1] + dist_normal[run,v,x]
      end;


    dist_normal_mean[run,v] := meanvalue/som;
    dist_normal[run,v,repetitions] := 1;
*)
end;

{$ENDREGION}

{$REGION 'Model Calculations'}

procedure ziek(aantal: integer);                                                  // random worden "aantal" mensen gevonden en die worden besmet
var
  i, illnessduration, incubationperiod, persoon, meanvalue: integer;
  R, frac: extended;
begin

  for i := 1 to aantal do
    begin
      if (illnessWeibullToggle[run] = 1) AND (illnessWeibullmeanToggle[run] = 0) then      // Determine the duration of illness for this person
        begin
          R := random;
          illnessduration := -1;
          repeat
            inc(illnessduration);
          until dist_weibull[run,1,illnessduration] >= R;                         // 1: place where the weibull distribution for illness duration is stored
        end
      else if illnessWeibullmeanToggle[run] = 1 then
        begin
          meanvalue := trunc(dist_weibull_mean[run,1]);
          frac := dist_weibull_mean[run,1] - meanvalue;
          if random <= frac then
            inc(meanvalue);
          illnessduration := meanvalue;
        end
      else illnessduration := ziekteduur[run];

      if (incubationWeibullToggle[run] = 1) AND (incubationWeibullmeanToggle[run] = 0) then  // Determine the duration of incubation for this person
        begin
          R := random;
          incubationperiod := -1;
          repeat
            inc(incubationperiod);
          until dist_weibull[run,2,incubationperiod] >= R;                        // 2: place where the weibull distribution for the incubation period is stored
        end
      else if incubationWeibullmeanToggle[run] = 1 then
        begin
          meanvalue := trunc(dist_weibull_mean[run,2]);
          frac := dist_weibull_mean[run,2] - meanvalue;
          if random <= frac then
            inc(meanvalue);
          incubationperiod := meanvalue;
        end
      else incubationperiod := incubation[run];

      persoon := trunc(random * bevolking[run]) + 1;                              // selecteer persoon at random uit de bevolking
      if data[run,persoon, 1] = 0 then                                            // als iemand niet ziek is besmet hem >> die wordt dus ook ziek, naar mate meer mensen ziek/besmet zijn geweest worden er minder nieuwe mensen ziek
        begin
          data[run,persoon, 1] := 1;
          data[run,persoon, 3] := incubationperiod + illnessduration;             //this defines the day when someone should be 'healthy' again starting form the first day he got infected
          data[run,persoon, 4] := incubationperiod;
        end;

    end;

end;

procedure initieelbesmet(poisson, cases: integer);                                // dit is de procedure waar er een random getal wordt genereerd en om die manier een hoeveelheid mensen
var                                                                               // uit de poisson distributie wordt gehaald.
  i: integer;
  X: extended;
begin

  if poisson = 1 then
    begin
      X := random;
      i := -1;
      repeat
        inc(i);
      until dist_initial[run, i] >= X;
    end
  else
    begin
       i := cases;
    end;

  ziek(i);                                                                        // START procedure ZIEK met aantal personen dat besmet is op het begin
end;

procedure besmet(persoon: integer);
var
  i, j, weibullcount, contactrate, meanvalue: integer;
  X, R, transmissibility, frac: extended;

begin

  if (transmissibilitySC[run,SCmoment,1] = 1) AND (transmissibilitySC[run,SCmoment,4] = 0) then // Determine the transmissibility for this event/person
    begin
      R := random;
      weibullcount := 0;
      repeat
        inc(weibullcount);
      until dist_weibull[run,3,weibullcount] >= R;                                // 3: place where the weibull distribution for the transmissibility is stored
      transmissibility := weibullcount * transstep;
    end
  else if transmissibilitySC[run,SCmoment,4] = 1 then
    begin
      transmissibility := dist_weibull_mean[run,3];
    end
  else transmissibility := transmissibilitySC[run,SCmoment,2];

  if (ContactRateSC[run,SCmoment,4] = 1) AND (ContactRateSC[run,SCmoment,6] = 0) then   // Determine the amount of contacts for this event/person
    begin
      R := random;
      contactrate := -1;
      repeat
        inc(contactrate);
      until dist_weibull[run,4,contactrate] >= R;                                 // 4: place where the weibull distribution for the contact rate is stored
    end
  else if ContactRateSC[run,SCmoment,6] = 1 then
    begin
      meanvalue := trunc(dist_weibull_mean[run,4]);
      frac := dist_weibull_mean[run,4] - meanvalue;
      if random <= frac then
        inc(meanvalue);
      contactrate := meanvalue;
    end
  else contactrate := round(ContactRateSC[run,SCmoment,2]);

  if ContactRateSC[run,SCmoment,1] = 0 then                                       // No Superspreaders
    R0[run] := transmissibility * contactrate
  else begin                                                                      // Apply Superspreaders
    if random <= ContactRateSC[run,SCmoment,3] then begin
      R0[run] := transmissibility * contactrate
    end else R0[run] := 0;
  end;

  if R0[run] <> 0 then
    begin
      if contactvariationToggle[run] = 1 then
        begin
          X := random;
          i := -1;
          repeat
            inc(i);
          until dist_contact[run,i] >= X;

          j := trunc(i * R0[run] / mean[run]);
          frac := i * R0[run] / mean[run] - j;
          if random <= frac then
            inc(j);
        end
      else
        begin
          j := trunc(R0[run]);
          frac := R0[run] - j;
          if random <= frac then
            inc(j);
        end;

      ziek(j);                                                                    // START procedure ZIEK met aantal personen dat besmet is geraakt (gebaseerd op de distrubtie enzo)
    end
end;

procedure markov(persoon: integer);                                               // dit is de procedure die de overgang van een persoon naar een andere toestand regelt

begin

  if (data[run,persoon, 1] > 0) then                                              // 0 = gezond, 1 = niet besmettelijk, 2 = wel besmettelijk, 3 = genezen, 4 = dood
    begin
      if (data[run,persoon, 1] < data[run,persoon, 4]) then                       // 4: place where incubation period is stored, defined at the start of the illness
        begin
          inc(data[run,persoon, 1]);                                              // 1: place where duration since infection is stored
          data[run,persoon, 2] := 1;                                              // 2: place where 'healthy'(0), 'non-infectious'(1), 'infectious'(2), 'healed'(3), and 'dead'(4) is stored
        end

      else if (data[run,persoon, 1] < data[run,persoon, 3]) then                  // 3: place where illness duration is stored, defined at the start of the illness
        begin
          inc(data[run,persoon, 1]);
          data[run,persoon, 2] := 2;                                              // 2 = wel besmettelijk
          besmet(persoon);                                                        // START procedure BESMET met persoon (dit zal anderen gaan besmetten)

          if (random < sterfkans[run]) then                                       // The longer someone is ill the higher the cumulative chance of dying, right?
            begin
              data[run,persoon, 1] := 1000;
              data[run,persoon, 2] := 4;                                          // 4 = dood
            end;
        end

      else if (data[run,persoon, 1] < 1000) then
        begin
          inc(data[run,persoon, 1]);
          data[run,persoon, 2] := 3;                                              // 3 = genezen
        end;
    end;
end;

procedure statistiek(dag, simulatie: integer);
var
  gezond, besmet, overleden, genezen, i: integer;
begin
  gezond := 0;
  besmet := 0;
  overleden := 0;
  genezen := 0;

  for i := 1 to bevolking[run] do                                                 // 0 = gezond, 1 = niet besmettelijk, 2 = wel besmettelijk, 3 = genezen, 4 = dood
    begin
      if data[run,i, 2] = 0 then
        inc(gezond)
      else if data[run,i, 2] = 1 then
        inc(besmet)
      else if data[run,i, 2] = 2 then
        inc(besmet)
      else if data[run,i, 2] = 3 then
        inc(genezen)
      else if data[run,i, 2] = 4 then
        inc(overleden)
    end;

  healthy[run,simulatie,dag]  := healthy[run,simulatie,dag] + gezond;             // update de gegevens per dag en per simulatie
  infected[run,simulatie,dag]  := infected[run,simulatie,dag] + besmet;
  dead[run,simulatie,dag]    := dead[run,simulatie,dag]   + overleden;
  healed[run,simulatie,dag] := healed[run,simulatie,dag]+ genezen;

  d := ', ';
  dayoutput[run,simulatie,dag] := concat(
    floattostr(healthy[run,simulatie,dag])  ,d,
    floattostr(infected[run,simulatie,dag])  ,d,
    floattostr(dead[run,simulatie,dag])    ,d,
    floattostr(healed[run,simulatie,dag])
  );

end;

procedure writefile();
var
  day, simulatie, week, weeks: integer;
begin
    if dayweekoutput = 'day' then begin
        for day := 1 to dagen do begin
            for simulatie := 1 to Nsimulatie do begin
                if showsimulationnumbers = 1 then
                    writeln(uitvoer, day, ',', dayoutput[1,simulatie,day], ',', dayoutput[2,simulatie,day], ',', simulatie)
                else if showsimulationnumbers = 0 then
                    writeln(uitvoer, day, ',', dayoutput[1,simulatie,day], ',', dayoutput[2,simulatie,day])
            end;
        end;
    end
    else if dayweekoutput = 'week' then begin
        week := 0;
        day := 7;
        weeks := trunc(dagen/7);
        repeat
            week := week+1;
            for simulatie := 1 to Nsimulatie do begin
                if showsimulationnumbers = 1 then
                    writeln(uitvoer, week, ',', dayoutput[1,simulatie,day], ',', dayoutput[2,simulatie,day], ',', simulatie)
                else if showsimulationnumbers = 0 then
                    writeln(uitvoer, week, ',', dayoutput[1,simulatie,day], ',', dayoutput[2,simulatie,day])
            end;
            day := day+7;
        until (week = weeks);
    end
    else showmessage('Something went wrong in procedure writefile');

end;

{$ENDREGION}

{$REGION 'Extra Field Outputs'}

procedure fieldoutput();
var
  r, j: integer;
  output, DayStr, CRStr, TraStr, ICstr1, IPstr1, IDstr1, ICstr2, IPstr2, IDstr2, CVstr: array [1 .. 2] of string;
  e, f: string;
begin
  d := '; ';
  e := ', ';
  f := 'Constant';

  Form1.VarOutput_Veld.text :=
    'Initial Cases; IC - Distribution; Incubation Period; IP - Distribution; Illness Duration; ID - Distribution; Effective R Variation; Death rate; Total population size; Day; ContactRate; Transmissibility; Simulations; Days; Output per; Random Seed';

  for r := 1 to 2 do
    begin
      for j := 1 to SCcount[run] do
        begin
          DayStr[r] := DayStr[r] + FloatToStr(DaySC[r,j]);

          if TransmissibilitySC[r,j,1] = 1 then begin
            TraStr[r] := TraStr[r] +
                         'μ: '+ FloatToStr(round(dist_weibull_mean[r,3]*1000)/1000)+
                       ' (λ:' + FloatToStr(TransmissibilitySC[r,j,2]) +
                        ' k:' + FloatToStr(TransmissibilitySC[r,j,3]) + ')';
            if TransmissibilitySC[r,j,4] = 1 then begin
              TraStr[r] := TraStr[r] +' (as '+f+')';
            end;
          end else TraStr[r] := TraStr[r] + FloatToStr(TransmissibilitySC[r,j,2]);
          //TraStr[r] := TraStr[r] + FloatToStr(TransmissibilitySC[r,j,2]);

          if ContactRateSC[r,j,4] = 1 then begin
            CRStr[r] := CRStr[r] +
                         'μ: '+ FloatToStr(round(dist_weibull_mean[r,4]*100)/100)+
                       ' (λ:' + FloatToStr(ContactRateSC[r,j,2]) +
                        ' k:' + FloatToStr(ContactRateSC[r,j,5]) + ')';
            if ContactRateSC[r,j,6] = 1 then begin
              CRStr[r] := CRStr[r] +' (as '+f+')';
            end;
          end else CRStr[r] := CRStr[r] + FloatToStr(ContactRateSC[r,j,2]);

          //CRStr[r] := CRStr[r] + FloatToStr(ContactRateSC[r,j,2]) ;
          if ContactRateSC[r,j,1] = 1 then begin
            CRStr[r] := CRStr[r]+ ' - ' +FloatToStr(ContactRateSC[r,j,3]);
          end;

          if j <> SCcount[run] then begin
            DayStr[r] := DayStr[r] + e;
            TraStr[r] := TraStr[r] + e;
            CRStr[r] := CRStr[r] + e
          end
        end;

      if poissontoggle[r] = 1 then begin
        ICstr1[r] := 'μ: '+inttostr(initialcases[r]);
        ICstr2[r] := 'Poisson';
      end else begin
        ICstr1[r] := inttostr(initialcases[r]);
        ICstr2[r] := f;
      end;

      if incubationWeibullToggle[r] = 1 then begin
        IPstr1[r] := 'μ: '+FloattoStr(round(dist_weibull_mean[r,2]*100)/100)+' (λ:'+inttostr(incubation[r])+', k:'+FloatToStr(incubationWeibullShape[r])+')';
        IPstr2[r] := 'Weibull';
        if incubationWeibullMeanToggle[r] = 1 then
          IPstr2[r] := IPstr2[r] +' Mean ('+f+')'
      end else begin
        IPstr1[r] := inttostr(incubation[r]);
        IPstr2[r] := f;
      end;

      if illnessWeibullToggle[r] = 1 then begin
        IDstr1[r] := 'μ: '+FloattoStr(round(dist_weibull_mean[r,1]*100)/100)+' (λ: '+inttostr(ziekteduur[r])+', k:'+FloatToStr(illnessWeibullShape[r])+')';
        IDstr2[r] := 'Weibull';
        if illnessWeibullMeanToggle[r] = 1 then
          IDstr2[r] := IDstr2[r] +' Mean ('+f+')'
      end else begin
        IDstr1[r] := inttostr(ziekteduur[r]);
        IDstr2[r] := f;
      end;

      if contactvariationToggle[r] = 1 then begin
        if verdelingtipe[r] = 1
          then CVstr[r] := 'Cauchy (reach: '+IntToStr(bereik[r])+')'
          else CVstr[r] := 'Exponential (reach: '+IntToStr(bereik[r])+')';
      end else begin
        CVstr[r] := ' - ';
      end;

      if DayStr[r] = '1' then DayStr[r] := 'No Social Changes';      

      output[r] := concat(
        ICstr1[r], d, ICstr2[r], d, IPstr1[r], d, IPstr2[r], d, IDstr1[r], d, IDstr2[r], d, CVstr[r], d, floattostr(sterfkans[r]), d, inttostr(bevolking[r]), d, DayStr[r], d, CRStr[r], d, TraStr[r], d, inttostr(Nsimulatie), d, inttostr(dagen), d, dayweekoutput, d, inttostr(seed)
        );
    end;

  Form1.NumbOutput_Veld.text := concat(output[1],' ~ ',output[2]);

end;

procedure runinfo();
var
  r, s, d: Integer;
  minhealthy, maxinfected, maxinfectedday: array [1 .. 2] of extended;
  info, healthyStr, infectedStr, dayStr: string;
  IncWeiMeanStr, IllWeiMeanStr: array [1..2] of string;
begin

  for r := 1 to 2 do
    begin
      minhealthy[r] :=  bevolking[r];
      maxinfected[r] := 0;

      for d := 1 to dagen do
        begin

          for s := 1 to Nsimulatie do
            begin
              mhealthy[r,d] := mhealthy[r,d] + healthy[r,s,d];
              minfected[r,d] := minfected[r,d] + infected[r,s,d];
            end;
          mhealthy[r,d] := mhealthy[r,d]/Nsimulatie;
          minfected[r,d] := minfected[r,d]/Nsimulatie;

          if minfected[r,d] > maxinfected[r] then
            begin
              maxinfected[r] := minfected[r,d];
              maxinfectedday[r] := d;
            end;
          if mhealthy[r,d] < minhealthy[r] then
            minhealthy[r] := mhealthy[r,d];
        end;

      if incubationWeibullToggle[r] = 1
        then IncWeiMeanStr[r] := 'Run '+IntToStr(r)+ ': '+FloattoStr(round(dist_weibull_mean[r,2]*100)/100)
        else IncWeiMeanStr[r] := 'Run '+IntToStr(r)+ ':   -    ';
      if illnessWeibullToggle[r] = 1
        then IllWeiMeanStr[r] := 'Run '+IntToStr(r)+ ': '+FloattoStr(round(dist_weibull_mean[r,1]*100)/100)
        else IllWeiMeanStr[r] := 'Run '+IntToStr(r)+ ':   -    ';

      healthyStr := FloatToStr(minhealthy[r]);
      infectedStr := FloatToStr(maxinfected[r]);
      dayStr := FloatToStr(maxinfectedday[r]);
      info := info + 'Run '+IntToStr(r)+': Most infected on day '+dayStr+' with '+infectedStr+' ppl., ended with '+healthyStr+' healthy ppl. left.'+char(10);

    end;

  info := info + char(10) + 'Incubation Weibull Mean = ' + IncWeiMeanStr[1] + ', ' + IncWeiMeanStr[2]
               + char(10) + 'Illness Weibull Mean =        ' + IllWeiMeanStr[1] + ', ' + IllWeiMeanStr[2];

  Form1.InfoBox.Caption := info;

end;

{$ENDREGION}

{$REGION 'Checkboxes'}

procedure InitialCasesCheckBoxProcedure();
begin
    if Form1.InitialCasesCheckBox.Checked then begin
    Form1.InitialCasesValue_Label.Caption := '(μ)';
    Form1.IntialcasesLabel.Caption := 'Initial Cases (people) (Poisson Distribution)';
  end else begin
    Form1.InitialCasesValue_Label.Caption := '';
    Form1.IntialcasesLabel.Caption := 'Initial Cases (people)';
  end;
end;

procedure IncubationCheckBoxProcedure();
begin
  if Form1.IncubationCheckBox.Checked then begin
    Form1.IncubationValue_Label1.Caption := '(λ)';
    Form1.IncubationWeibullShape_Veld1.Visible := True;
    Form1.Incubatietijd_Veld1.Hint := 'Scale parameter of the Weibull Distribution';
    Form1.IncubationValue_Label2.Visible := True;
    Form1.IncubationLabel.Caption := 'Incubation period (days) (Weibull Distributed)';
    Form1.IncubationWeibullMeanCheckBox.Visible := True;
  end else begin
    Form1.Incubatietijd_Veld1.Hint := 'Duration of incubation period';
    Form1.IncubationValue_Label1.Caption := '';
    Form1.IncubationWeibullShape_Veld1.Visible := False;
    Form1.IncubationValue_Label2.Visible := False;
    Form1.IncubationLabel.Caption := 'Incubation period (days)';
    Form1.IncubationWeibullMeanCheckBox.Visible := False;
    Form1.IncubationWeibullMeanCheckBox.Checked := False;
  end;
end;

procedure IllnessCheckBoxProcedure();
begin
  if Form1.IllnessCheckBox.Checked then begin
    Form1.IllnessValue_Label1.Caption := '(λ)';
    Form1.IllnessWeibullShape_Veld1.Visible := True;
    Form1.IllnessValue_Label2.Visible := True;
    Form1.IllnessLabel.Caption := 'Illness duration (days) (Weibull Distributed)';
    Form1.IllnessMean_Veld1.Hint := 'Scale parameter of the Weibull Distribution';
    Form1.IllnessWeibullMeanCheckBox.Visible := True;
  end else begin
    Form1.IllnessValue_Label1.Caption := '';
    Form1.IllnessWeibullShape_Veld1.Visible := False;
    Form1.IllnessValue_Label2.Visible := False;
    Form1.IllnessLabel.Caption := 'Illness duration (days)';
    Form1.IllnessMean_Veld1.Hint := 'The duration from ending of the incubation period until healthy. Infectous period.';
    Form1.IllnessWeibullMeanCheckBox.Visible := False;
    Form1.IllnessWeibullMeanCheckBox.Checked := False;
  end;
end;

procedure ContactVariationCheckBoxProcedure();
begin
  if Form1.ContactVariationCheckBox.Checked then begin
    Form1.Verdeling_Veld1.Visible := True;
    Form1.Bereik_Veld1.Visible := True;
    Form1.ContactVariation_Label.Caption := 'Effective R Variation (1: Cuachy. 2: Expo., Reach)';
    Form1.ContactSd_Label.Visible := True;
    Form1.ContactSd.Visible := True;
    Form1.ContactGemiddelde_Label.Visible := True;
    Form1.ContactGemiddelde.Visible := True;
  end else begin
    Form1.Verdeling_Veld1.Visible := False;
    Form1.Bereik_Veld1.Visible := False;
    Form1.ContactVariation_Label.Caption := 'Effective R Variation';
    Form1.ContactSd_Label.Visible := False;
    Form1.ContactSd.Visible := False;
    Form1.ContactGemiddelde_Label.Visible := False;
    Form1.ContactGemiddelde.Visible := False;
  end;
end;

procedure bothsuperspreadercheckboxes();
begin
  if Form1.SuperspreaderStartCheckBox.Checked OR Form1.SuperspreaderCheckBox.Checked then begin
    Form1.CRinfoLabel.caption := '(people/day - probability)';
  end else begin
    Form1.CRinfoLabel.caption := '(people/day)';
  end;
end;

procedure bothsuperspreadAndWeibull();
var
  A1, A2, B1, B2, BothFirstRow, BothSecondRow, OrFirstRow, OrSecondRow, BothSuperSpread, BothWeibull, OrSuperSpread, OrWeibull: boolean;
begin
  A1 := Form1.SuperspreaderStartCheckBox.Checked;                   //  A  B
  A2 := Form1.SuperspreaderCheckBox.Checked;                        //1 X  X
  B1 := Form1.ContactRateStartWeibullCheckBox.Checked;              //2 X  X
  B2 := Form1.ContactRateWeibullCheckBox.Checked;

  BothFirstRow    := A1 AND B1;
  OrFirstRow      := A1 OR  B1;

  BothSecondRow   := A2 AND B2;
  OrSecondRow     := A2 OR  B2;

  BothSuperSpread := A1 AND A2;
  OrSuperSpread   := A1 OR  A2;

  BothWeibull     := B1 AND B2;
  OrWeibull       := B1 OR  B2;

  if BothFirstRow then begin
    Form1.CRStartProbability.Left := 460;
    Form1.ContactRateStartWeibullMeanCheckBox.Left := 515;
  end else begin
    Form1.CRStartProbability.Left := 415;
    Form1.ContactRateStartWeibullMeanCheckBox.Left := 470;
  end;

  if OrFirstRow then Form1.ContactRateStart.Width := 40 else
    Form1.ContactRateStart.Width := 85;

  if BothSecondRow then begin
    Form1.CRProbability.Left := 460;
    Form1.ContactRateWeibullMeanCheckBox.Left := 515;
  end else begin
    Form1.CRProbability.Left := 415;
    Form1.ContactRateWeibullMeanCheckBox.Left := 470;
  end;

  if OrSecondRow then Form1.ContactRateSCInput.Width := 40 else
    Form1.ContactRateSCInput.Width := 85;

  if A1 and not (B1) then Form1.ContactRateStart.Hint := 'Contacted people/day, by superspreaders'
  else if B1 then Form1.ContactRateStart.Hint := 'Scale (λ) parameter of the Weibull Distribution';

  if A2 and not (B2) then Form1.ContactRateSCInput.Hint := 'Contacted people/day, by superspreaders'
  else if B1 then Form1.ContactRateSCInput.Hint := 'Scale (λ) parameter of the Weibull Distribution';

  if BothSuperSpread AND BothWeibull then begin
    Form1.CRinfoLabel.caption := '(λ - k - probability)';

  end else if OrSuperSpread AND OrWeibull then begin
    Form1.CRinfoLabel.caption := '(hover over textfield)';

  end else if BothSuperSpread AND not (orWeibull) then begin
    Form1.CRinfoLabel.caption := '(rate - probability)';

  end else if BothWeibull AND not (orSuperSpread) then begin
    Form1.CRinfoLabel.caption := '(λ - k)';

  end else if not (OrSuperSpread) AND not (OrWeibull) then begin
    Form1.CRinfoLabel.caption := '(people/day)'

  end else begin
    Form1.CRinfoLabel.caption := '(hover over textfield)'
  end;

end;

procedure SuperspreaderStartCheckBoxProcedure();
begin
  if Form1.SuperspreaderStartCheckBox.Checked then begin
    Form1.CRStartProbability.Visible := True;
    Form1.ContactRateStart.Width := 40;
    Form1.CRStartProbability.Hint := 'Probability of being a superspreaders, non-superspreaders do not have any contacts';
  end else begin
    Form1.CRStartProbability.Visible := False;
    //Form1.ContactRateStart.Width := 85;
    Form1.ContactRateStart.Hint := 'Contacted people/day';
  end;

  //bothsuperspreadercheckboxes();
  bothsuperspreadAndWeibull();
end;

procedure SuperspreaderCheckBoxProcedure();
begin
  if Form1.SuperspreaderCheckBox.Checked then begin
    Form1.CRProbability.Visible := True;
    Form1.ContactRateSCinput.Width := 40;
    //Form1.ContactRateSCinput.Hint := 'Infected people per day by superspreaders';
    Form1.CRProbability.Hint := 'Probability of being a superspreaders, non-superspreaders do not have any contacts';
  end else begin
    Form1.CRProbability.Visible := False;
    Form1.ContactRateSCinput.Width := 76;
    Form1.ContactRateSCinput.Hint := 'Contacted people/day';
  end;

  //bothsuperspreadercheckboxes();
  bothsuperspreadAndWeibull();
end;

Procedure ContactRateStartWeibullCheckBoxProcedure();
begin
  if Form1.ContactRateStartWeibullCheckBox.Checked then begin
    Form1.ContactRateStartShape.Visible := True;
    Form1.ContactRateStart.Width := 40;
    Form1.ContactRateStartWeibullMeanCheckBox.Visible := True;
  end else begin
    Form1.ContactRateStartShape.Visible := False;
    Form1.ContactRateStartWeibullMeanCheckBox.Visible := False;
    Form1.ContactRateStartWeibullMeanCheckBox.Checked := False;
  end;

  bothsuperspreadAndWeibull();
end;

Procedure ContactRateWeibullCheckBoxProcedure();
begin
  if Form1.ContactRateWeibullCheckBox.Checked then begin
    Form1.ContactRateShape.Visible := True;
    Form1.ContactRateStart.Width := 40;
    Form1.ContactRateWeibullMeanCheckBox.Visible := True;
  end else begin
    Form1.ContactRateShape.Visible := False;
    Form1.ContactRateWeibullMeanCheckBox.Visible := False;
    Form1.ContactRateWeibullMeanCheckBox.Checked := False;
  end;
  bothsuperspreadAndWeibull();
end;

procedure TransmissibilityStartCheckBoxProcedure();
begin
  if Form1.TransmissibilityStartCheckBox.Checked then begin
    Form1.TransmissibilityStart.Width := 40; //85
    Form1.TransmissibilityStart.Hint := 'Scale (λ) parameter of the Weibull Distribution';
    Form1.TransmissibilityStartShape.Visible := True;
    Form1.TransmissibilityStartWeibullMeanCheckBox.Visible := True;
    Form1.TransInfoLabel.Caption := '(λ - k)';
  end else begin
    Form1.TransmissibilityStart.Width := 85; //85
    Form1.TransmissibilityStart.Hint := 'Transmissibility Rate, rate at which contacted people are infected';
    Form1.TransmissibilityStartShape.Visible := False;
    Form1.TransmissibilityStartWeibullMeanCheckBox.Visible := False;
    Form1.TransmissibilityStartWeibullMeanCheckBox.Checked := False;
    Form1.TransInfoLabel.Caption := '(rate)';
  end;
end;

procedure TransmissibilitySCCheckBoxProcedure();
begin
  if Form1.TransmissibilitySCCheckBox.Checked then begin
    Form1.TransmissibilitySCInput.Width := 40; //85
    Form1.TransmissibilitySCInput.Hint := 'Scale (λ) parameter of the Weibull Distribution';
    Form1.TransmissibilitySCShape.Visible := True;
    Form1.TransmissibilitySCWeibullMeanCheckBox.Visible := True;
  end else begin
    Form1.TransmissibilitySCInput.Width := 85; //85
    Form1.TransmissibilitySCInput.Hint := 'Transmissibility, rate at which contacted people are infected';
    Form1.TransmissibilitySCShape.Visible := False;
    Form1.TransmissibilitySCWeibullMeanCheckBox.Visible := False;
    Form1.TransmissibilitySCWeibullMeanCheckBox.Checked := False;
  end;
end;

///---///

procedure TForm1.InitialCasesCheckBoxClick(Sender: TObject);
begin
  InitialCasesCheckBoxProcedure();
end;

procedure TForm1.IncubationCheckBoxClick(Sender: TObject);
begin
  IncubationCheckBoxProcedure();
end;

procedure TForm1.IllnessCheckBoxClick(Sender: TObject);
begin
  IllnessCheckBoxProcedure();
end;

procedure TForm1.ContactVariationCheckBoxClick(Sender: TObject);
begin
  ContactVariationCheckBoxProcedure();
end;

procedure TForm1.SuperspreaderStartCheckBoxClick(Sender: TObject);
begin
  SuperspreaderStartCheckBoxProcedure();
end;

procedure TForm1.ContactRateStartWeibullCheckBoxClick(Sender: TObject);
begin
  ContactRateStartWeibullCheckBoxProcedure();
end;

procedure TForm1.ContactRateWeibullCheckBoxClick(Sender: TObject);
begin
  ContactRateWeibullCheckBoxProcedure();
end;

procedure TForm1.SuperspreaderCheckBoxClick(Sender: TObject);
begin
  SuperspreaderCheckBoxProcedure();
end;

procedure TForm1.TransmissibilityStartCheckBoxClick(Sender: TObject);
begin
  TransmissibilityStartCheckBoxProcedure();
end;

procedure TForm1.TransmissibilitySCCheckBoxClick(Sender: TObject);
begin
   TransmissibilitySCCheckBoxProcedure();
end;


procedure TForm1.SimulationNumbers_CheckBoxClick(Sender: TObject);
begin
  if SimulationNumbers_CheckBox.Checked then begin
    showsimulationnumbers := 1;
    simnumstr := ',Simulation';
  end
  else begin
    showsimulationnumbers := 0;
    simnumstr := '';
  end;

end;

{$ENDREGION}

{$REGION 'SocialChange'}

procedure socialchangeoverview(r: integer);
var
  i, j: integer;
  dayStr, transStr, transMeanStr, CrStr, CrMeanStr, SuperSpreadStr, R0Str, RExtra: string;
begin

  i := SCcount[r];

  for j := 1 to i do
  begin
    dayStr :=  FloatToStr(DaySC[r,j]) + char(10) + dayStr;

    if TransmissibilitySC[r,j,1] = 1 then begin
      if TransmissibilitySC[r,j,4] = 1 then transMeanStr := '(Mean)' else transMeanStr := '';
      transStr := 'λ: '+ FloatToStr(TransmissibilitySC[r,j,2]) +char(9)+
                  'k: '+ FloatToStr(TransmissibilitySC[r,j,3]) +char(9)+
                         transMeanStr +char(10) + transStr;
      RExtra := '~';
    end else begin
      transStr := FloatToStr(TransmissibilitySC[r,j,2]) + char(10) + transStr;
      RExtra := '';
    end;

    if ContactRateSC[r,j,1] = 1 then SuperSpreadStr := char(9) + FloatToStr(ContactRateSC[r,j,3]*100)+'%' else SuperSpreadStr := '';

    if ContactRateSC[r,j,4] = 1 then begin
      if ContactRateSC[r,j,6] = 1 then CrMeanStr := char(9)+'(Mean)' else CrMeanStr := '';

      CrStr    := 'λ: '+ FloatToStr(ContactRateSC[r,j,2]) +char(9)+
                  'k: '+ FloatToStr(ContactRateSC[r,j,5]) +
                         CrMeanStr + SuperSpreadStr + char(10) + CrStr;
      RExtra := '~';
    end else begin
      CrStr := FloatToStr(ContactRateSC[r,j,2]) + char(9) + SuperSpreadStr + char(10) + CrStr;
    end;

    if ContactRateSC[r,j,1] = 1
      then R0Str := RExtra + FloatToStr( TransmissibilitySC[r,j,2]*(ContactRateSC[r,j,2]*ContactRateSC[r,j,3])*ziekteduur[r]) + char(10) + R0Str
      else R0Str := RExtra + FloatToStr( TransmissibilitySC[r,j,2]*ContactRateSC[r,j,2]*ziekteduur[r]) + char(10) + R0Str;

  end;

  Form1.SCDay.Caption := dayStr;
  Form1.SCTransmissibility.Caption := transStr;
  Form1.SCContactRate.Caption := CrStr;
  Form1.SCR0.Caption := R0Str;

  Form1.SCOverview.Caption := 'Overview: (Run '+IntToStr(r)+' )';

end;

procedure TForm1.SocialChangeClearClick(Sender: TObject);
var
  i, r: integer;
begin
  r := strToInt( RunInput_Veld.text );
  for i := 2 to 50 do
    begin
      DaySC[r,i] := 0;
      TransmissibilitySC[r,i,1] := 0;     // Weibull Dist. Checkbox
      TransmissibilitySC[r,i,2] := 0;     // Main value (rate or scale parameter)
      TransmissibilitySC[r,i,3] := 0;     // Shape paramter
      TransmissibilitySC[r,i,4] := 0;     // Weibull mean Checkbox
      TransmissibilitySC[r,i,5] := 0;     // not-used
      TransmissibilitySC[r,i,6] := 0;     // not-used

      ContactRateSC[r,i,1] := 0;          // Superspreaders Checkbox
      ContactRateSC[r,i,2] := 0;          // Main value (rate or scale parameter)
      ContactRateSC[r,i,3] := 0;          // Superspreader probability
      ContactRateSC[r,i,4] := 0;          // Weibull Dist. Checkbox
      ContactRateSC[r,i,5] := 0;          // Shape parameter
      ContactRateSC[r,i,6] := 0;          // Weibull mean Checkbox
    end;
  SCcount[r] := 1;
  socialchangeoverview(r);
end;

procedure SocialChangeStartInput(r: integer);
begin
  DaySC[r,1]                := 1;
  TransmissibilitySC[r,1,2] := strToFloat(  Form1.TransmissibilityStart.text        );
  ContactRateSC[r,1,2]      := strToFloat(  Form1.ContactRateStart.text             );

  if Form1.SuperspreaderStartCheckBox.Checked = TRUE then begin
    ContactRateSC[r,1,1] := 1;
    ContactRateSC[r,1,3] := strToFloat( Form1.CRStartProbability.text );
  end else ContactRateSC[r,1,1] := 0;

  if Form1.ContactRateStartWeibullCheckBox.Checked = TRUE then begin
    ContactRateSC[r,1,4] := 1;
    ContactRateSC[r,1,5] := strToFloat( Form1.ContactRateStartShape.text );
    if Form1.ContactRateStartWeibullMeanCheckBox.Checked
      then ContactRateSC[r,1,6] := 1
      else ContactRateSC[r,1,6] := 0;
  end else ContactRateSC[r,1,4] := 0;

  if Form1.TransmissibilityStartCheckBox.Checked = TRUE then begin
    TransmissibilitySC[r,1,1] := 1;
    TransmissibilitySC[r,1,3] := strToFloat( Form1.TransmissibilityStartShape.text );
    if Form1.TransmissibilityStartWeibullMeanCheckBox.Checked
      then TransmissibilitySC[r,1,4] := 1
      else TransmissibilitySC[r,1,4] := 0;
  end else TransmissibilitySC[r,1,1] := 0;

end;

procedure TForm1.SocialChangeInputClick(Sender: TObject);
var
  i, r: integer;
begin

  r          := strToInt(    RunInput_Veld.text        );
  SocialChangeStartInput(r);

  if (DaySCinput.text = '') OR (TransmissibilitySCinput.text = '') OR (ContactRateSCinput.text = '') then
    showmessage('Must not be empty.')
  else begin

    SCcount[r] := SCcount[r]+1;
    i          := SCcount[r];

    DaySC[r,i]                := strToInt(    DaySCinput.text                );
    TransmissibilitySC[r,i,2] := strToFloat(  TransmissibilitySCinput.text   );
    ContactRateSC[r,i,2]      := strToFloat(  ContactRateSCinput.text        );

    if SuperspreaderCheckBox.Checked then begin
      ContactRateSC[r,i,1]    := 1;
      ContactRateSC[r,i,3]    := strToFloat( CRProbability.text );
    end else ContactRateSC[r,i,1] := 0;

    if ContactRateWeibullCheckbox.Checked then begin
      ContactRateSC[r,i,4] := 1;
      ContactRateSC[r,i,5] := strToFloat( ContactRateShape.text );
      if ContactRateWeibullMeanCheckBox.Checked
        then ContactRateSC[r,i,6] := 1
        else ContactRateSC[r,i,6] := 0;
    end else ContactRateSC[r,i,4] := 0;

    if TransmissibilitySCCheckbox.Checked then begin
      TransmissibilitySC[r,i,1] := 1;
      TransmissibilitySC[r,i,3] := strToFloat( TransmissibilitySCShape.text );
      if TransmissibilitySCWeibullMeanCheckBox.Checked
        then TransmissibilitySC[r,i,4] := 1
        else TransmissibilitySC[r,i,4] := 0;
    end else TransmissibilitySC[r,i,1] := 0;

    socialchangeoverview(r);
  end
end;

{$ENDREGION}

{$REGION 'Input & Retrieve'}

procedure TForm1.InputButtonClick(Sender: TObject);
var
  r: integer;

begin

  if (inputcount < 2) then inputcount := inputcount+1;

  currentinput              := strToInt(    RunInput_Veld.text                );

  r := currentinput;

  ziekteduur[r]             := strToInt(    IllnessMean_Veld1.text            );
  illnessWeibullShape[r]    := strToFloat(  IllnessWeibullShape_Veld1.text    );

  incubation[r]             := strToInt(    Incubatietijd_Veld1.text          );
  incubationWeibullShape[r] := strToFloat(  IncubationWeibullShape_Veld1.text );

  sterfkans[r]              := strToFloat(  Sterfkans_Veld1.text              );

  initialcases[r]           := strToInt(    InitialCases_Veld1.Text           );
  bevolking[r]              := strToInt(    Populatie_Veld1.text              );

  verdelingtipe[r]          := strToInt(    Verdeling_Veld1.Text              );
  bereik[r]                 := strToInt(    Bereik_Veld1.text                 );

  SocialChangeStartInput(r);

  if InitialCasesCheckBox.Checked then poissontoggle[r] := 1 else poissontoggle[r] := 0;
  if IncubationCheckBox.Checked then incubationWeibullToggle[r] := 1 else incubationWeibullToggle[r]:= 0;
  if IllnessCheckBox.Checked then illnessWeibullToggle[r] := 1 else illnessWeibullToggle[r] := 0;
  if ContactVariationCheckBox.Checked then contactvariationToggle[r] :=1 else contactvariationToggle[r] := 0;


  if IncubationWeibullMeanCheckBox.Checked then incubationWeibullmeanToggle[r] := 1 else incubationWeibullmeanToggle[r] := 0;
  if IllnessWeibullMeanCheckBox.Checked then illnessWeibullmeanToggle[r] := 1 else illnessWeibullmeanToggle[r] := 0;

  showmessage('Succesfully inputed the values for Run '+inttostr(r));

  if (inputcount = 2) then RetrieveButton.Caption := 'Retrieve Values from Run 1';

  socialchangeoverview(r);

  //-Change Run-//

  if (currentinput = 1) then  Form1.RunInput_Veld.text := '2'
  else                        Form1.RunInput_Veld.text := '1';

end;

procedure TForm1.RetrieveButtonClick(Sender: TObject);
var
  r: integer;
begin

  if (inputcount < 2) then
    //showmessage('You have not inputted two sets of run variables yet')
  else
    begin
      if (currentinput = 1) then
        begin
          r := 2;
          RetrieveButton.Caption := 'Retrieve Values from Run 1';
        end
      else
        begin
          r := 1;
          RetrieveButton.Caption := 'Retrieve Values from Run 2';
        end;

      Form1.RunInput_Veld.text := IntToStr(r);

      Form1.IllnessMean_Veld1.text            := IntToStr(    ziekteduur[r]             );
      Form1.IllnessWeibullShape_Veld1.text    := FloatToStr(  illnessWeibullShape[r]    );

      Form1.Incubatietijd_Veld1.text          := IntToStr(    incubation[r]);
      Form1.IncubationWeibullShape_Veld1.text := FloatToStr(  incubationWeibullShape[r] );

      Form1.Sterfkans_Veld1.text              := FloatToStr(  sterfkans[r]              );

      Form1.InitialCases_Veld1.Text           := IntToStr(    initialcases[r]           );
      Form1.Populatie_Veld1.text              := IntToStr(    bevolking[r]              );

      Form1.Verdeling_Veld1.Text              := IntToStr(    verdelingtipe[r]          );
      Form1.Bereik_Veld1.text                 := IntToStr(    bereik[r]                 );

      Form1.TransmissibilityStart.text        := FloatToStr(  TransmissibilitySC[r,1,2]);
      Form1.ContactRateStart.text             := FloatToStr(  ContactRateSC[r,1,2]);

      Form1.ContactGemiddelde.Caption         := floattostr(  round(mean[r]*100)/100    );
      Form1.ContactSd.Caption                 := floattostr(  round(somsq[r]*100)/100   );

      socialchangeoverview(r);

      if incubationWeibullmeanToggle[r] = 1 then IncubationWeibullMeanCheckBox.Checked := TRUE else IncubationWeibullMeanCheckBox.Checked := FALSE;
      if illnessWeibullmeanToggle[r] = 1 then IllnessWeibullMeanCheckBox.Checked := TRUE else IllnessWeibullMeanCheckBox.Checked := FALSE;

      if poissontoggle[r] = 1 then InitialCasesCheckBox.Checked := TRUE else InitialCasesCheckBox.Checked := FALSE;
         InitialCasesCheckBoxProcedure();
      if incubationWeibullToggle[r] = 1 then IncubationCheckBox.Checked := TRUE else IncubationCheckBox.Checked := FALSE;
         IncubationCheckBoxProcedure();
      if illnessWeibullToggle[r] = 1 then IllnessCheckBox.Checked := TRUE else IllnessCheckBox.Checked := FALSE;
         IllnessCheckBoxProcedure();
      if contactvariationToggle[r] = 1 then ContactVariationCheckBox.Checked := TRUE else ContactVariationCheckBox.Checked := FALSE;
         contactvariationCheckBoxProcedure();

      if TransmissibilitySC[r,1,1] = 1 then TransmissibilityStartCheckBox.Checked := TRUE else TransmissibilityStartCheckBox.Checked := FALSE;
         TransmissibilityStartCheckBoxProcedure();
      if TransmissibilitySC[r,1,4] = 1 then TransmissibilityStartWeibullMeanCheckBox.Checked := TRUE else TransmissibilityStartWeibullMeanCheckBox.Checked := FALSE;
         TransmissibilityStartCheckBoxProcedure();

      if ContactRateSC[r,1,1] = 1 then SuperspreaderStartCheckBox.Checked := TRUE else SuperspreaderStartCheckBox.Checked := FALSE;
         superspreaderStartCheckBoxProcedure();
      if ContactRateSC[r,1,4] = 1 then ContactRateStartWeibullCheckBox.Checked := TRUE else ContactRateStartWeibullCheckBox.Checked := FALSE;
         ContactRateStartWeibullCheckBoxProcedure();
      if ContactRateSC[r,1,6] = 1 then ContactRateStartWeibullMeanCheckBox.Checked := TRUE else ContactRateStartWeibullMeanCheckBox.Checked := FALSE;




      if (currentinput = 1) then currentinput := 2
      else currentinput := 1;
    end;

end;

{$ENDREGION}

{$REGION 'Run & Exit'}

function CapFirstLetter(str: string): string;
begin
  Result := Uppercase(Copy(str,1,1))+Lowercase(Copy(str,2,Length(str)));
end;

procedure newrandomseed();
var
  day, ms: integer;
begin
  ms := MillisecondOfTheDay(Now);
  day := trunc(Now);
  seed := day*ms;
  randseed := seed;
end;

procedure TForm1.ProgramInfo1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.exit1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.Runsimulation1Click(Sender: TObject);
var
  simulationrun, persoon, dag, simulatie, SCmomentPrev: integer;
  i: Integer;
begin
  saveDialog1.Filter := 'CSV file|*.csv|Text file|*.txt';
  saveDialog1.DefaultExt := 'csv';

  dayweekoutput := lowercase(DayWeekOut.text);

  if (inputcount < 2) then
      showmessage('You have not inputted two sets of run variables yet')
  else if Not (dayweekoutput = 'day') and Not (dayweekoutput = 'week')  then
      showmessage('Choose either "Day" or "Week" as output format')
  else if SaveDialog1.execute then
  begin
    assignfile(uitvoer, SaveDialog1.filename);

    rewrite(uitvoer);
    writeln(uitvoer, CapFirstLetter(dayweekoutput)+',Healthy1,Infected1,Dead1,Cured1,'+
                                                    'Healthy2,Infected2,Dead2,Cured2'+simnumstr);

    newrandomseed();                                                                // Run NewRandomSeed Procedure

    dagen      := strToInt( Dagen_Veld.text             );
    Nsimulatie := strToInt( AantalSimulaties_Veld.text  );

    for simulationrun := 1 to 2 do                                                  // Run the program twice with seperate variables
      begin

        run := simulationrun;

        if bevolking[run] > maxpopulation then
          showmessage('te grote bevolking pas aan');

        verd_contact(verdelingtipe[run], bereik[run]);                              // START procedure VERD_CONTACT (verdeling van hoeveel contacten mensen hebben)
        verd_initial(initialcases[run]);                                            // START procedure VERD_INITIAL (poisson verdeling van initieel aantal zieken)
        verd_weibull(1, ziekteduur[run], illnessWeibullShape[run], 1);                 // START procedure VERD_WEIBULL (Weibull verdeling voor de ziekteduur)
        verd_weibull(2, incubation[run], incubationWeibullShape[run], 1);              // START procedure VERD_WEIBULL (Weibull verdeling voor de incubatietijd)

        for i := 1 to 50 do
          if DaySC[run,i] = 0 then DaySC[run,i] := dagen+1;

        for simulatie := 1 to Nsimulatie do
          begin

            for dag := 1 to dagen do
              begin
                healthy[run,simulatie,dag] := 0.0;
                  mhealthy[run,dag] := 0.0;
                infected[run,simulatie,dag] := 0.0;
                  minfected[run,dag] := 0.0;
                dead[run,simulatie,dag] := 0.0;
                healed[run,simulatie,dag] := 0.0;
              end;

            for persoon:=1 to bevolking[run] do                                     // reset the data array to zero (not affected)
              begin
                data[run,persoon,1]:=0;
                data[run,persoon,2]:=0;
                data[run,persoon,3]:=0;
              end;

            initieelbesmet(poissontoggle[run],initialcases[run]);                   // START procedure INITIEELBESMET
            SCmomentPrev := 0;

            for dag := 1 to dagen do
              begin
                SCmoment := 0;
                repeat
                  SCmoment := SCmoment+1;
                until (dag>=DaySC[run,SCmoment]) AND (dag<DaySC[run,SCmoment+1]);

                if not (SCmomentPrev = SCmoment) then begin                        // Only recalculate Weibull when SCmoment changes and the distribution is actually needed
                  if TransmissibilitySC[run,SCmoment,1] = 1 then begin
                    if TransmissibilitySC[run,SCmoment,2] < 0.02
                      then transstep := 0.001
                      else transstep := 0.01;
                    verd_weibull(3, TransmissibilitySC[run,SCmoment,2], TransmissibilitySC[run,SCmoment,3], transstep);  // START procedure VERD_WEIBULL for Transmissibilty
                  end;
                  if ContactRateSC[run,SCmoment,4] = 1 then
                    verd_weibull(4, ContactRateSC[run,SCmoment,2], ContactRateSC[run,SCmoment,5], 1);                    // START procedure VERD_WEIBULL for Contact Rate
                end;

                for persoon := 1 to bevolking[run] do
                  begin
                    markov(persoon);                                              // START procedure MARKOV met persoon uit bevolking
                  end;

                SCmomentPrev := SCmoment;
                statistiek(dag, simulatie);                                       // START procedure STATISTIEK met dag
              end;
          end;

      end;


    writefile();

    fieldoutput();
    closefile(uitvoer);
    runinfo();
    ShowMessage('The simulations have been saved, you can continue working!');

  end
  //else showmessage('File not saved. Model has not run.');

end;

{$ENDREGION}

end.
