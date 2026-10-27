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
fig,axs=plt.subplots(1,2,figsize=(6.1,2.5),sharey=True)
for ax,idx,title in [(axs[0],range(5),'(a) 入力約5 V'),(axs[1],range(5,9),'(b) 入力約10 V')]:
 for rows,key,label,c,mark in [(A,'eta_reference_pct','測定A','#2465a8','o'),(B,'eta_pct','測定B','#b64d27','s')]:
  ax.plot([abs(rows[j]['Vout_V'])/rows[j]['Vin_V'] for j in idx],[rows[j][key] for j in idx],marker=mark,color=c,label=label,lw=1.2,ms=4)
 ax.set(xlabel='電圧比 |Vout| / Vin',title=title,ylim=(55,76));ax.grid(alpha=.25);ax.legend(frameon=False,fontsize=9)
axs[0].set_ylabel('効率概算 η (%)');fig.tight_layout();fig.savefig(I/'efficiency.svg');plt.close(fig)
fig,axs=plt.subplots(1,2,figsize=(6.1,2.55))
for ax,n in [(axs[0],8),(axs[1],9)]:
 p=next((S/'research/20261027_lossA_run13/_cache').glob(f'*ss{n:02d}*csv'));a=np.loadtxt(p,delimiter=',',skiprows=14);m=(a[:,0]>=0)&(a[:,0]<=200e-6);a=a[m][::25];ax.plot(a[:,0]*1e6,a[:,4],color='#2465a8',lw=1)
 ax.set(xlabel='時間 t (μs)',ylabel='L1電流 (A)',title=f'({"a" if n==8 else "b"}) A・ss{n:02d}',ylim=(0,1.3),xlim=(0,200));ax.grid(alpha=.25)
fig.tight_layout();fig.savefig(I/'inductor_current.svg');plt.close(fig)
# Reproduce covariance diagnostic without assigning it to a physical loss correction.
p=S/'research/20261027_lossB_run13/_cache/RigolDS20.csv';a=np.loadtxt(p,delimiter=',',skiprows=1);v=a[:,4];i=a[:,3];cov=lambda x,y:float(np.mean((x-x.mean())*(y-y.mean())))
mask=abs(v-v.mean())<.5;audit={'full_cov_W':cov(v,i),'excluded_points':int((~mask).sum()),'total_points':len(v),'masked_cov_W':cov(v[mask],i[mask]),'policy':'Diagnostic sensitivity, not adopted correction or measured loss'}
(D/'analysis/cout_diagnostic.json').write_text(json.dumps(audit,indent=2))
for a,b in zip(A,B):assert a['Duty_percent']==b['Duty_percent'] and a['supply_set_V']==b['supply_set_V']
print('Figures and source summary saved')
