program Project2;

{%File '..\set_VTh(dVdt)_Lyle.dat'}
{%File '..\set_VTh(dVdt)_Chow.dat'}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  AHPO in '..\AHPO.pas',
  BstO in '..\BstO.pas',
  Calmar_KO in '..\Calmar_KO.pas',
  Calmar_NaO in '..\Calmar_NaO.pas',
  Calmar_NaRO in '..\Calmar_NaRO.pas',
  ChannelO in '..\ChannelO.pas',
  Chow_KO in '..\Chow_KO.pas',
  Chow_NaO in '..\Chow_NaO.pas',
  CondBasedO in '..\CondBasedO.pas',
  CreateNrnO in '..\CreateNrnO.pas',
  Cum_CaHO in '..\Cum_CaHO.pas',
  Cum_CaTO in '..\Cum_CaTO.pas',
  Cum_KAO in '..\Cum_KAO.pas',
  Cum_KDO in '..\Cum_KDO.pas',
  Cum_KO in '..\Cum_KO.pas',
  Cum_NaO in '..\Cum_NaO.pas',
  Cum_NaRO in '..\Cum_NaRO.pas',
  Dest_CaTO in '..\Dest_CaTO.pas',
  Dest_KCaO in '..\Dest_KCaO.pas',
  Dest_KMO in '..\Dest_KMO.pas',
  Dest_KO in '..\Dest_KO.pas',
  HH_CalmarO in '..\HH_CalmarO.pas',
  HH_ChowO in '..\HH_ChowO.pas',
  HH_CumminsO in '..\HH_CumminsO.pas',
  HH_DestO in '..\HH_DestO.pas',
  HH_LyleO in '..\HH_LyleO.pas',
  HH_MigliO in '..\HH_MigliO.pas',
  HH_PassiveO in '..\HH_PassiveO.pas',
  KepecsWang_KCaO in '..\KepecsWang_KCaO.pas',
  LIFNrnO in '..\LIFNrnO.pas',
  Lyle_HO in '..\Lyle_HO.pas',
  Lyle_KAO in '..\Lyle_KAO.pas',
  Lyle_KDO in '..\Lyle_KDO.pas',
  Lyle_KMO in '..\Lyle_KMO.pas',
  Lyle_KO in '..\Lyle_KO.pas',
  Lyle_NaO in '..\Lyle_NaO.pas',
  Lyle_NaRO in '..\Lyle_NaRO.pas',
  Migli_KAO in '..\Migli_KAO.pas',
  Migli_KO in '..\Migli_KO.pas',
  Migli_NaO in '..\Migli_NaO.pas',
  NeuronO in '..\NeuronO.pas',
  NullChannelO in '..\NullChannelO.pas',
  SetNrnParsO in '..\SetNrnParsO.pas',
  ThreshNrnO in '..\ThreshNrnO.pas',
  typeNrnParsO in '..\typeNrnParsO.pas',
  MathMyO in '..\MathMyO.pas',
  t_dtO in '..\t_dtO.pas',
  ThresholdO in '..\ThresholdO.pas',
  ADPO in '..\ADPO.pas',
  Naundorf_NaO in '..\Naundorf_NaO.pas',
  HH_NaundorfO in '..\HH_NaundorfO.pas',
  Naundorf_KO in '..\Naundorf_KO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
