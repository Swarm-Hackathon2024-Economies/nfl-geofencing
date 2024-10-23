import pandas as pd
from pyproj import Transformer

# CSVファイルの読み込み
input_csv = "input-aadt.csv"
output_csv = "aadt.csv"
df = pd.read_csv(input_csv)

# Web Mercator (EPSG:3857) から WGS84 (EPSG:4326) への変換
transformer = Transformer.from_crs("EPSG:3857", "EPSG:4326")

# x, y を経度と緯度に変換
df[['longitude', 'latitude']] = df.apply(
    lambda row: pd.Series(transformer.transform(row['x'], row['y'])),
    axis=1
)

# 過去4年間のカウントをマージ（最新のデータを優先）
df['AADT'] = df[['AADT_RPT_HIST_01_QTY', 'AADT_RPT_HIST_02_QTY', 'AADT_RPT_HIST_03_QTY', 'AADT_RPT_HIST_04_QTY']].bfill(axis=1).iloc[:, 0]

# AADTの欠損データを削除
df = df.dropna(subset=['AADT'])

# AADTを整数に変換
df['AADT'] = df['AADT'].astype(int)

# 必要なカラムのみ選択
result = df[['longitude', 'latitude', 'AADT']]

# 結果をCSVに出力
result.to_csv(output_csv, index=False)

print(f"{output_csv}に変換されたデータが保存されました。")
