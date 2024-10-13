import pandas as pd
from sklearn.cluster import DBSCAN
import numpy as np
from geopy.distance import great_circle
import json

# テキサス州の緯度・経度範囲
TEXAS_LAT_MIN = 32.5
TEXAS_LAT_MAX = 33.1
TEXAS_LON_MIN = -97.5
TEXAS_LON_MAX = -96.5

# 1度に処理する行数（チャンクサイズ）を設定
chunksize = 100000

# 空のリストを作成して、全チャンクの結果を格納
results = []

# チャンクごとにデータを処理する関数
def process_chunk(chunk, chunk_id):
    print(f"Processing chunk {chunk_id}...")
    
    # テキサス州の範囲内にあるデータのみフィルタリング
    chunk_filtered = chunk[
        (chunk['Start_Lat'] >= TEXAS_LAT_MIN) & 
        (chunk['Start_Lat'] <= TEXAS_LAT_MAX) & 
        (chunk['Start_Lng'] >= TEXAS_LON_MIN) & 
        (chunk['Start_Lng'] <= TEXAS_LON_MAX)
    ]
    print(f"Chunk {chunk_id}: Filtered {len(chunk_filtered)} rows within Texas bounds.")
    
    # テキサス州内にデータがない場合、次のチャンクに進む
    if len(chunk_filtered) == 0:
        print(f"Chunk {chunk_id} contains no data within Texas bounds, skipping...\n")
        return None
    
    # 緯度と経度を取得
    coordinates = chunk_filtered[['Start_Lat', 'Start_Lng']].values

    # DBSCANによるクラスタリング（epsとmin_samplesを適宜調整）
    db = DBSCAN(eps=0.00003, min_samples=13, metric='haversine').fit(np.radians(coordinates))
    
    # クラスタごとの中心、半径、事故の数を計算
    clusters = pd.Series([coordinates[db.labels_ == n] for n in set(db.labels_) if n != -1])
    print(f"Chunk {chunk_id}: Found {len(clusters)} clusters.")

    def cluster_center_radius(cluster):
        # クラスタの中心座標を計算
        centroid = cluster.mean(axis=0)
        # クラスタの中心から各点までの距離を計算し、最大距離を半径とする
        distances = [great_circle(centroid, point).meters for point in cluster]
        radius = max(distances)
        return {
            "latitude": centroid[0],
            "longitude": centroid[1],
            "radius": radius
        }

    # クラスタの中心座標と半径をリストに追加
    return clusters.apply(cluster_center_radius).tolist()

# チャンクごとにデータを読み込みながら処理
chunk_id = 1
for chunk in pd.read_csv('US_Accidents_March23.csv', chunksize=chunksize):
    result_chunk = process_chunk(chunk, chunk_id)
    if result_chunk is not None:
        results.extend(result_chunk)
    print(f"Chunk {chunk_id} processing complete.\n")
    chunk_id += 1

# 最終結果をJSONファイルに保存
with open('texas_clustered_accidents.json', 'w') as f:
    json.dump(results, f, indent=4)

print("All chunks processed and data saved to 'texas_clustered_accidents.json'.")
