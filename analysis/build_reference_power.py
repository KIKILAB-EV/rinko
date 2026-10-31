from pathlib import Path
import json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
D=Path(__file__).resolve().parents[1];S=Path('F:/Lab/SEPIC_Spice/research');O=D/'img/20261027';A=json.loads((D/'analysis/measurement_summary.json').read_text(encoding='utf-8'))['A'];B=json.loads((D/'analysis/measurement_summary.json').read_text(encoding='utf-8'))['B']
plt.rcParams.update({'font.family':'MS Gothic','font.size':11,'axes.unicode_minus':False,'svg.fonttype':'path'})
curves={k:[] for k in ['icin','l1power','mospower','diodepower','cinpower','coutpower']};audit=[]
for j in range(9):
 n=j+1;ad=S/'20261027_lossA_run13';p=next((ad/'_cache').glob(f'*ss{n:02d}*csv'));x=np.loadtxt(p,delimiter=',',skiprows=14);z=json.loads((ad/'results'/p.with_suffix('.json').name).read_text());t=x[:,0];v=x[:,3];th=(np.percentile(v,10)+np.percentile(v,90))/2;e=np.flatnonzero((v[:-1]>=th)&(v[1:]<th))+1;e=e[(t[e]>-.0005)&(t[e]<.0005)];start=e[np.argmin(abs(t[e]))];sel=(t>=t[start])&(t<t[start]+200e-6);q=(t[sel]-t[start])*1e6;base=z['reference_OFFmean']
 lp=(x[sel,1]-base[0])*(x[sel,4]-base[3])*1000;mp=x[sel,3]*(x[sel,2]-z['MOS_OFFmean_A'])*1000
 for key,y in [('l1power',lp),('mospower',mp)]:
  count=len(y)//25;curves[key].append((q[:count*25].reshape(-1,25).mean(1),y[:count*25].reshape(-1,25).mean(1),A[j]['Vout_V']))
 bd=S/'20261027_lossB_run13';p=next((bd/'_cache').glob(f'*ss{n:02d}*csv'));x=np.loadtxt(p,delimiter=',',skiprows=14);z=json.loads((bd/'results'/p.with_suffix('.json').name).read_text());t=x[:,0];v=x[:,3];th=(np.percentile(v,10)+np.percentile(v,90))/2;e=np.flatnonzero((v[:-1]>=th)&(v[1:]<th))+1;e=e[(t[e]>-.0005)&(t[e]<.0005)];start=e[np.argmin(abs(t[e]))];sel=(t>=t[start])&(t<t[start]+200e-6);q=(t[sel]-t[start])*1e6;off=z['mean'][1]-z['I_diode_reversePlateau_A'];y=x[sel,3]*(x[sel,2]-off)*1000;count=len(y)//25;curves['diodepower'].append((q[:count*25].reshape(-1,25).mean(1),y[:count*25].reshape(-1,25).mean(1),B[j]['Vout_V']))
 h=np.loadtxt(ad/'_cache'/f'RigolDS{n}.csv',delimiter=',',skiprows=1);t=h[:,0];sel=(t>=0)&(t<200e-6);q=t[sel]*1e6;v=h[:,1]-np.mean(h[:,1]);i=h[:,2]-np.mean(h[:,2]);vo=h[:,4]-np.mean(h[:,4]);io=h[:,3]-np.mean(h[:,3]);curves['icin'].append((q,i[sel],A[j]['Vout_V']));curves['cinpower'].append((q,(v*i)[sel]*1000,A[j]['Vout_V']));curves['coutpower'].append((q,(vo*io)[sel]*1000,A[j]['Vout_V']))
 audit.append({'condition':n,'MOS_current_offset_A':z.get('MOS_OFFmean_A'),'diode_reverse_current_offset_A':off,'DHO_source':str(ad/'_cache'/f'RigolDS{n}.csv')})
targets=[-2.5,-3.75,-5,-6.25,-7.5,-5,-7.5,-10,-12.5]
colors=['#2465a8','#d17800','#31935a','#ad4483','#333333']
for key,traces in curves.items():
 low=min(y.min() for _,y,_ in traces);high=max(y.max() for _,y,_ in traces);pad=(high-low)*.07
 for ids,name in [(range(5),'5V'),(range(5,9),'10V')]:
  fig,ax=plt.subplots(figsize=(4,3));fig.subplots_adjust(left=.23,right=.94,bottom=.23,top=.95)
  for j,c in zip(ids,colors):
   q,y,vo=traces[j];ax.plot(q,y,color=c,lw=.95,label=f'{targets[j]:g} V')
  ax.set(xlabel='時間 t (μs)',ylabel='Cin電流 (A)' if key=='icin' else '端子瞬時電力 (mW)',xlim=(0,200),ylim=(low-pad,high+pad));ax.grid(alpha=.25);ax.axhline(0,color='#777777',lw=.5)
  legend_location='lower left' if key in ('icin','l1power','coutpower') else 'upper left'
  ax.legend(loc=legend_location,ncol=2,frameon=True,facecolor='white',framealpha=.9,edgecolor='none',fontsize=8.5,columnspacing=.8,handlelength=1.5,labelspacing=.2)
  fig.savefig(O/f'reference_{key}_{name}.svg');plt.close(fig)
(D/'analysis/reference_power_audit.json').write_text(json.dumps({'plots':12,'dimensions_in':[4,3],'power_label':'Terminal instantaneous power, not pure irreversible loss','MSO_display':'0.2 us bin average of native voltage-current products','DHO_display':'native exported 2 us samples, AC centered covariance products','current_display':'Cin AC current, mean removed','records':audit},indent=2),encoding='utf-8')
print('12 separate reference graphs generated.')
