from pathlib import Path
import json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
D=Path(__file__).resolve().parents[1];I=D/'img/20261027';records=json.loads((D/'analysis/loss_shares.json').read_text(encoding='utf-8'))['values']
plt.rcParams.update({'font.family':'MS Gothic','font.size':11,'axes.unicode_minus':False,'svg.fonttype':'path'})
for kind in ['A','B']:
 subset=[r for r in records if r['measurement']==kind];keys=list(dict.fromkeys(r['component'] for r in subset));assert len(keys)==4
 labels=['L1端子','MOSFET' if kind=='A' else 'ダイオード','Cin','Cout'];colors=['#2465a8','#d17800','#31935a','#ad4483']
 for vin in [5,10]:
  conditions=list(dict.fromkeys(tuple(r['condition']) for r in subset if r['condition'][0]==vin));x=np.arange(len(conditions));bottom=np.zeros(len(x));fig,ax=plt.subplots(figsize=(4,3));fig.subplots_adjust(left=.18,right=.98,bottom=.25,top=.95)
  for key,label,color in zip(keys,labels,colors):
   vals=[]
   for cond in conditions:
    r=next(r for r in subset if tuple(r['condition'])==cond and r['component']==key);vals.append(r['share_percent'] if r['displayed'] and r['share_percent']>=0 else 0)
   vals=np.array(vals);ax.bar(x,vals,bottom=bottom,label=label,color=color,width=.64,edgecolor='white',linewidth=.4);bottom+=vals
  ax.set_xticks(x,[f'{c[1]:g}' for c in conditions]);ax.set(xlabel='出力電圧 (V)',ylabel='全体損失に対する割合 (%)',ylim=(0,100));ax.set_yticks(range(0,101,20));ax.set_axisbelow(True);ax.grid(axis='y',alpha=.25)
  ax.legend(loc='lower center',ncol=2,frameon=True,facecolor='white',framealpha=.9,edgecolor='none',fontsize=8.5,columnspacing=.8,handlelength=1.2,labelspacing=.2)
  fig.savefig(I/f'loss_share_{kind}_{vin}V.svg');plt.close(fig)
print('Four independent 4:3 loss-share plots generated from unrounded table data.')
