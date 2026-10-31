from pathlib import Path
import json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
D=Path(__file__).resolve().parents[1];I=D/'img/20261027';S=Path('F:/Lab/SEPIC_Spice/research/20261027_lossA_run13/_cache')
A=json.loads((D/'analysis/measurement_summary.json').read_text(encoding='utf-8'))['A']
plt.rcParams.update({'font.family':'MS Gothic','font.size':11,'axes.unicode_minus':False,'svg.fonttype':'path'})
targets=[-2.5,-3.75,-5,-6.25,-7.5,-5,-7.5,-10,-12.5]
colors=['#2465a8','#d17800','#31935a','#ad4483','#333333'];audit=[]
for inds,name,ymax in [(range(5),'5V',1.30),(range(5,9),'10V',1.30)]:
 fig,ax=plt.subplots(figsize=(4,4.1));fig.subplots_adjust(left=.19,right=.97,bottom=.15,top=.97)
 for j,c in zip(inds,colors):
  p=next(S.glob(f'*ss{j+1:02d}*csv'));a=np.loadtxt(p,delimiter=',',skiprows=14);t=a[:,0];v=a[:,3]
  threshold=(np.percentile(v,10)+np.percentile(v,90))/2
  edges=np.flatnonzero((v[:-1]>=threshold)&(v[1:]<threshold))+1
  edges=edges[(t[edges]>-.0005)&(t[edges]<.0005)];assert len(edges)>0
  edge=edges[np.argmin(abs(t[edges]))];t0=t[edge];sel=(t>=t0)&(t<t0+200e-6)
  ax.plot((t[sel][::25]-t0)*1e6,a[sel,4][::25],lw=1,color=c,label=f"{targets[j]:g} V")
  audit.append({'condition':j+1,'source':str(p),'on_edge_s':float(t0),'threshold_V':float(threshold),'display_decimation':25,'current_scale_factor':1})
 ax.set(xlabel='時間 t (μs)',ylabel='L1電流 (A)',xlim=(0,200),ylim=(0,ymax));ax.set_yticks(np.arange(0,1.21,.2));ax.grid(alpha=.25);ax.legend(frameon=False,fontsize=9,loc='upper left',handlelength=1.7,labelspacing=.25)
 fig.savefig(I/f'inductor_current_overlay_{name}.svg');fig.savefig(D/f'.build/inductor_current_overlay_{name}.png',dpi=180);plt.close(fig)
(D/'analysis/inductor_overlay_audit.json').write_text(json.dumps(audit,indent=2),encoding='utf-8')
print('9 traces plotted; aligned to falling Vds edge (MOSFET on).')
