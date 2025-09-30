import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import japanize


japanize.japanize()

plt.rcParams['xtick.direction'] = 'in'
plt.rcParams['ytick.direction'] = 'in'

# 1A.csvファイルを読み込み
data1A = pd.read_csv('1A.csv')
time1A = data1A['Time(s)'].values
voltage1A = data1A['CH1V'].values

# 2A.csvファイルを読み込み
data2A = pd.read_csv('2A.csv')
time2A = data2A['Time(s)'].values
voltage2A = data2A['CH1V'].values

# 1A.csvのFFT処理
dt1A = time1A[1] - time1A[0]
fs1A = 1 / dt1A
N1A = len(voltage1A)
fft_voltage1A = np.fft.fft(voltage1A)
fft_freq1A = np.fft.fftfreq(N1A, dt1A)
positive_freq_mask1A = fft_freq1A >= 0
freq_positive1A = fft_freq1A[positive_freq_mask1A]
fft_magnitude1A = np.abs(fft_voltage1A[positive_freq_mask1A])
fft_magnitude_db1A = 20 * np.log10(fft_magnitude1A + 1e-12)

# 2A.csvのFFT処理
dt2A = time2A[1] - time2A[0]
fs2A = 1 / dt2A
N2A = len(voltage2A)
fft_voltage2A = np.fft.fft(voltage2A)
fft_freq2A = np.fft.fftfreq(N2A, dt2A)
positive_freq_mask2A = fft_freq2A >= 0
freq_positive2A = fft_freq2A[positive_freq_mask2A]
fft_magnitude2A = np.abs(fft_voltage2A[positive_freq_mask2A])
fft_magnitude_db2A = 20 * np.log10(fft_magnitude2A + 1e-12)

# グラフを作成
plt.figure(figsize=(6, 4))

plt.plot(freq_positive1A, fft_magnitude_db1A, label='接続', alpha=0.8)
plt.plot(freq_positive2A, fft_magnitude_db2A, label='開放', alpha=0.8)
plt.xlabel('Frequency (Hz)')
plt.ylabel('Magnitude (dB)')
plt.legend()
plt.grid(True)
plt.xlim(0, 1000)  # X軸の範囲: 0から1000Hz
plt.ylim(-20, 80)  # Y軸の範囲: -20から80dB
plt.xticks(np.arange(0, 1001, 100))  # 100Hz間隔でメジャーティック
plt.gca().set_xticks(np.arange(0, 1001, 20), minor=True)  # 20Hz間隔でマイナーティック
plt.grid(True, which='major', alpha=0.7)  # メジャーグリッド
plt.grid(True, which='minor', alpha=0.3)  # マイナーグリッド

plt.tight_layout()

# SVGファイルとして保存
plt.savefig('A.svg', format='svg', dpi=300, bbox_inches='tight')
print("FFTグラフをA.svgとして保存しました")

plt.show()