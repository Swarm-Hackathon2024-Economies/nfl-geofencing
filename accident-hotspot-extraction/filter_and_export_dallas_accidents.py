import pandas as pd
import json

# CSVファイルのパス
csv_file = "US_Accidents_March23.csv"

# ダラス〜フォートワースエリアの経緯度の範囲
DALLAS_LAT_MIN = 32.5
DALLAS_LAT_MAX = 33.2
DALLAS_LON_MIN = -97.5
DALLAS_LON_MAX = -96.5

# 対象年
TARGET_YEARS = [2021]

# 季節の定義
def get_season(month):
    if month in [3, 4, 5]:
        return 'spring'
    elif month in [6, 7, 8]:
        return 'summer'
    elif month in [9, 10, 11]:
        return 'fall'
    else:
        return 'winter'

# 時間帯の定義
def get_time_of_day(hour):
    if 6 <= hour < 18:
        return 'daytime'
    else:
        return 'nighttime'

# JSON出力用の空の辞書
output_data = {
    'spring_daytime': [],
    'spring_nighttime': [],
    'summer_daytime': [],
    'summer_nighttime': [],
    'fall_daytime': [],
    'fall_nighttime': [],
    'winter_daytime': [],
    'winter_nighttime': []
}

# チャンクサイズの指定（1回に読み込む行数）
chunk_size = 500000

# CSVファイルをチャンクごとに読み込む
print("CSVファイルをチャンクごとに処理しています...")
for chunk in pd.read_csv(csv_file, chunksize=chunk_size):
    print(f"チャンクを処理中... {len(chunk)} 件のデータを読み込みました。")
    
    # 'Start_Time' を datetime 型に変換
    chunk['Start_Time'] = pd.to_datetime(chunk['Start_Time'], errors='coerce')

    # 年フィルタ: 2021年と2023年のみ
    chunk = chunk[chunk['Start_Time'].dt.year.isin(TARGET_YEARS)]
    
    if chunk.empty:
        continue
    
    # ダラス〜フォートワースエリアのデータにフィルタリング
    df_filtered = chunk[(chunk['Start_Lat'] >= DALLAS_LAT_MIN) & (chunk['Start_Lat'] <= DALLAS_LAT_MAX) &
                        (chunk['Start_Lng'] >= DALLAS_LON_MIN) & (chunk['Start_Lng'] <= DALLAS_LON_MAX)].copy()
    
    if df_filtered.empty:
        continue
    
    # 季節と時間帯のカラムを追加
    df_filtered.loc[:, 'Season'] = df_filtered['Start_Time'].dt.month.apply(get_season)
    df_filtered.loc[:, 'Time_of_Day'] = df_filtered['Start_Time'].dt.hour.apply(get_time_of_day)

    # 緯度、経度、開始時間の情報だけを取得
    df_filtered = df_filtered[['Start_Lat', 'Start_Lng', 'Start_Time', 'Season', 'Time_of_Day']]

    # データを季節と時間帯ごとに分類し、出力データに追加
    for index, row in df_filtered.iterrows():
        key = f"{row['Season']}_{row['Time_of_Day']}"
        output_data[key].append({
            'latitude': row['Start_Lat'],
            'longitude': row['Start_Lng'],
            'start_time': row['Start_Time'].strftime('%Y-%m-%d %H:%M:%S')
        })

# JSONファイルに出力
print("データをJSONファイルに出力しています...")
for key, data in output_data.items():
    filename = f'dallas_{key}.json'
    with open(filename, 'w') as f:
        json.dump(data, f, indent=4)
    print(f"{filename} に {len(data)} 件のデータを書き込みました。")

print("すべてのデータの処理とJSON出力が完了しました。")
