# 資料と数値の出典

- 編集対象は`main.typ`。`style.typ`の見出し・title・img・tabを直接使用し、定義を上書きしない。
- PDF作成：`typst compile main.typ 1027_電気自動車.pdf`
- `measurement_summary.json`はrun13のA/B各9点と最終確認run15の計算値。単位はキー名に記載。
- 主回路効率は入力保護抵抗の回路側を境界とする。ゲート別電源は除外。
- 図表データ：F:/Lab/SEPIC_Spice/research/20261027_lossA_run13、20261027_lossB_run13、20261027_voltage3_run15。
- `build_figures.py`でグラフを再生成できる。Python環境は同スクリプトが使用するnumpy/matplotlibを含む環境が必要。
- B ss09 Coutの負値を補正値に置き換えない。診断結果はcout_diagnostic.json。表では保留。
- 回路図は測定手順の元画像を変更せず掲載。`style.typ`は変更していない。
- 今後の予定欄はユーザー指定により空欄。
