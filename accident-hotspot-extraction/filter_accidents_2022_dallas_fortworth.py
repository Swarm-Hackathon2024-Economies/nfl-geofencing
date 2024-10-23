import pandas as pd

# CSVファイルの読み込み
input_csv = "US_Accidents_March23.csv"
output_csv = "filtered_accidents_2022_dallas_fortworth.csv"

# ダラス〜フォートワースエリアの緯度・経度範囲
DALLAS_LAT_MIN = 32.5
DALLAS_LAT_MAX = 33.2
DALLAS_LON_MIN = -97.5
DALLAS_LON_MAX = -96.5

# CSVデータの読み込み
print("CSVファイルを読み込んでいます...")
df = pd.read_csv(input_csv)

# 'Start_Time'をdatetime型に変換
df['Start_Time'] = pd.to_datetime(df['Start_Time'], errors='coerce')

# 2022年のデータでフィルタリング
df_2022 = df[df['Start_Time'].dt.year == 2022]

# ダラス〜フォートワースエリアの緯度経度でフィルタリング
df_filtered = df_2022[
    (df_2022['Start_Lat'] >= DALLAS_LAT_MIN) & (df_2022['Start_Lat'] <= DALLAS_LAT_MAX) &
    (df_2022['Start_Lng'] >= DALLAS_LON_MIN) & (df_2022['Start_Lng'] <= DALLAS_LON_MAX)
]

# 必要なカラムのみ選択
result = df_filtered[['Start_Lat', 'Start_Lng', 'Start_Time']]

# CSVに出力
result.to_csv(output_csv, index=False)

print(f"{output_csv} にデータが保存されました。")
