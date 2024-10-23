import pandas as pd
import json

# CSVファイルのパスを指定
csv_file_path = 'accidents_with_traffic_data.csv'
json_file_path = 'accidents_with_traffic_data_filtered.json'

# CSVファイルを読み込む
df = pd.read_csv(csv_file_path)

# AADTの欠損値を0に置き換え、整数に変換
df['AADT'] = df['AADT'].fillna(0).astype(float).astype(int)

# AADTが2,000以下のデータに絞り込む
df_filtered = df[df['AADT'] <= 2000]

# DataFrameをJSONに変換
json_data = df_filtered.to_json(orient='records', lines=False)

# JSONデータをファイルに保存
with open(json_file_path, 'w', encoding='utf-8') as json_file:
    json.dump(json.loads(json_data), json_file, ensure_ascii=False, indent=4)

print(f'JSONファイルが正常に保存されました: {json_file_path}')
