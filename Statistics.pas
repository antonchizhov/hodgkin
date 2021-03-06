unit Statistics;

interface
uses Init,t_dtO,mathMyO,Unit13;
procedure AnalyseStatistics(NewValue :double);

implementation
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

const nt_corr_max=4000;
type
     ghyst=array[-1..1000] of longint;
     corr_vect=array[0..nt_corr_max] of double;
var
     n_corr,nt_corr,nStat               : integer;
     a_ghyst,b_ghyst,Mean,Variance      : double;
     ggm                                : ghyst;
     corr,xC,spectr                     : corr_vect;


procedure SetGhystogramm(xi, { random value }
                         a,b :real; { limits of value}
                         n_intervals :integer; { amount of intervals }
                         var ggm :ghyst { points in intervals });
var
    i,j          : integer;
begin
  a_ghyst:=a;  b_ghyst:=b;   { remember limits }
  ggm[-1]:=n_intervals;                     { 'ggm[-1]'-amount of intervals }
  if (xi>=a) and (xi<=b) then begin
    if ggm[0]=0 then begin
       for j:=1 to n_intervals do ggm[j]:=0;
       ggm[0]:=1;
    end;
    i:=trunc((xi-a)/(b-a)*n_intervals)+1;   { 'xi' is in interval 'i' }
    ggm[0]:=ggm[0]+1;                       { 'ggm[0]' - amount of points }
    ggm[i]:=ggm[i]+1;
  end;
end;

procedure CalculateSpectr;
var  nw,nt   :integer;
     w,t,f,fc:real;
     bbb     :text;
begin
  for nw:=1 to nt_corr do begin
      w:=1/(nw*dt);
      spectr[nw]:=0;
      for nt:=1 to nt_corr do begin
          t:=(nt{-0.5})*dt;
          f:=(corr[nt]+corr[nt{-1}])/2;
          fc:=0.54+0.46*cos(pi*nt/nt_corr);
          spectr[nw]:=spectr[nw]+f*fc*cos(2*pi*w*t)*dt/2/pi;
      end;
  end;
  { Write correlation }
  assign(bbb,'spectr.dat');  rewrite(bbb);
    for nw:=1 to nt_corr do
        writeln(bbb,1/(nw*dt):8:4,' ',spectr[nw]:9:5);
  close(bbb);
end;

procedure Correlation(x_new :real);
var  k :integer;
begin
  { Initial values for 'xC' }
  if nStat<=nt_corr then begin
      xC[nStat]:=x_new;
      corr[nStat]:=0;
      n_corr:=0;
  end else begin
      n_corr:=n_corr+1;
      { Rename values }
      for k:=0 to nt_corr-1 do  xC[k]:=xC[k+1];
      { New value }
      xC[nt_corr]:=x_new;
      { Add to correlation }
      for k:=0 to nt_corr do  corr[k]:=(corr[k]*(n_corr-1)+xC[0]*xC[k])/n_corr;
  end;
end;

procedure AnalyseStatistics(NewValue :double);
var
    i,n                 :integer;
    a,b,xi,z,tau        :double;
    t1                  :string;
begin
  { Initial conditions }
  { IfStartStat = ??? or 0 when not active, 13 at the start, 14 when active Statistics }
  if (IfStartStat<>13)and(IfStartStat<>14) then IfStartStat:=13;
  if (nt<=1)or(IfStartStat=13) then begin
      IfStartStat:=14;
      nStat:=0;
      Mean     :=0;
      Variance :=0;
      for i:=0 to ggm[-1] do begin
          ggm[i]:=0;
      end;
      Form13.Series1.Clear;
      Form13.Series2.Clear;
  end;
  { Mean value and dispertion }
  nStat:=nStat+1;
  Mean     :=(Mean     *(nStat-1) +     NewValue )/nStat;
  Variance :=(Variance *(nStat-1) + sqr(NewValue))/nStat;
  { Add current value to the ghystogramm and correlation function }
  a      :=           Form13.DDSpinEdit4.Value;
  b      :=           Form13.DDSpinEdit1.Value;
  n      :=     trunc(Form13.DDSpinEdit2.Value); {number of intervals}
  nt_corr:=imin(trunc(Form13.DDSpinEdit3.Value),nt_corr_max);
  SetGhystogramm(NewValue,a,b,n,ggm);
  Correlation(NewValue);
  { Draw the ghystogramm and correlation function }
  if (trunc(nt/10/n_Draw)=nt/10/n_Draw) then begin
      { Write Mean and Variance }
      str(Mean:9:2,t1);
      Form13.Label2.Caption:=' Mean = '+t1;
      str(sqrt(abs(Variance-sqr(Mean))):9:2,t1);
      Form13.Label3.Caption:=' Dispersion = '+t1;
      { Draw the ghystogramm }
      if ggm[0]>0 then begin
         Form13.Series1.Clear;
         for i:=1 to ggm[-1] do begin
             xi:=a_ghyst+(b_ghyst-a_ghyst)/ggm[-1]*(i-1);
             Form13.Series1.AddXY(xi,ggm[i]/ggm[0]);
         end;
      end;
      { Draw the correlation function }
      Form13.Series2.Clear;
      for i:=0 to nt_corr do begin
          z:=(corr[i]-Mean*Mean)/(Variance-Mean*Mean);
          Form13.Series2.AddXY(i*dt*1e3,z);
      end;
      { Calculate and draw tau }
      if (n_corr>nt_corr+20)and(corr[0]>0) then begin
          tau:=2*dt/(1-(corr[2]-Mean*Mean)/(corr[0]-Mean*Mean));
          str(tau*1e3:9:2,t1);
          Form13.Label1.Caption:=' tau = '+t1;
      end;
  end;
  Application.ProcessMessages;
end;

end.
