from pathlib import Path
import json,shutil,gzip
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
plt.rcParams.update({'font.family':'MS Gothic','font.size':10,'axes.unicode_minus':False,'svg.fonttype':'path'})
S=Path(r'F:\Lab\SEPIC_Spice');D=Path(r'F:\Lab\rinko');I=D/'img/20261027'
A=json.loads((S/'research/20261027_lossA_run13/summary.json').read_text())['conditions'];B=json.loads((S/'research/20261027_lossB_run13/summary.json').read_text())['conditions']
(D/'analysis/measurement_summary.json').write_text(json.dumps({'A':A,'B':B,'run15':json.loads((S/'research/20261027_voltage3_run15/results.json').read_text())},ensure_ascii=False,indent=2),encoding='utf-8')
shutil.copy2(S/'research/20261021_edlc_followup/inverting_measurement_circuit.png',I/'circuit_measurement.png')
shutil.copy2(S/'research/20261027_voltage3_run15/data/IBB_MSO_5Vin_lossA_200R_5kHz_run15_ss03_200us.png',I/'voltage_check_run15.png')
# Each SVG is one independent 4:3 plot. Typst imgN controls composition.
plt.rcParams.update({'font.size':11})
def single_plot():
 fig,ax=plt.subplots(figsize=(4,3))
 fig.subplots_adjust(left=.19,right=.97,bottom=.23,top=.95)
 return fig,ax
for idx,name in [(range(5),'5V'),(range(5,9),'10V')]:
 fig,ax=single_plot()
 for rows,key,label,c,mark in [(A,'eta_reference_pct','測定A','#2465a8','o'),(B,'eta_pct','測定B','#b64d27','s')]:
  ax.plot([abs(rows[j]['Vout_V'])/rows[j]['Vin_V'] for j in idx],[rows[j][key] for j in idx],marker=mark,color=c,label=label,lw=1.2,ms=4)
 ax.set(xlabel='電圧比 |Vout| / Vin',ylabel='効率概算 η (%)',ylim=(55,76),xlim=(.4,1.55))
 ax.grid(alpha=.25);ax.legend(frameon=False,fontsize=10)
 fig.savefig(I/f'efficiency_{name}.svg');plt.close(fig)
for n in [8,9]:
 fig,ax=single_plot()
 p=next((S/'research/20261027_lossA_run13/_cache').glob(f'*ss{n:02d}*csv'));a=np.loadtxt(p,delimiter=',',skiprows=14);m=(a[:,0]>=0)&(a[:,0]<=200e-6);a=a[m][::25]
 ax.plot(a[:,0]*1e6,a[:,4],color='#2465a8',lw=1)
 ax.set(xlabel='時間 t (μs)',ylabel='L1電流 (A)',ylim=(0,1.3),xlim=(0,200));ax.grid(alpha=.25)
 fig.savefig(I/f'inductor_current_ss{n:02d}.svg');plt.close(fig)
# Reproduce covariance diagnostic without assigning it to a physical loss correction.
p=S/'research/20261027_lossB_run13/_cache/RigolDS20.csv';a=np.loadtxt(p,delimiter=',',skiprows=1);v=a[:,4];i=a[:,3];cov=lambda x,y:float(np.mean((x-x.mean())*(y-y.mean())))
mask=abs(v-v.mean())<.5;audit={'full_cov_W':cov(v,i),'excluded_points':int((~mask).sum()),'total_points':len(v),'masked_cov_W':cov(v[mask],i[mask]),'policy':'Diagnostic sensitivity, not adopted correction or measured loss'}
(D/'analysis/cout_diagnostic.json').write_text(json.dumps(audit,indent=2))
for a,b in zip(A,B):assert a['Duty_percent']==b['Duty_percent'] and a['supply_set_V']==b['supply_set_V']
print('Figures and source summary saved')
