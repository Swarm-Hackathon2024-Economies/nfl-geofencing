import pandas as pd
from sklearn.cluster import DBSCAN
import numpy as np
from geopy.distance import great_circle
import json
import math

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

# 2つの円の重なり面積を計算
def calculate_overlap_area(r1, r2, d):
    # 2つの円が重なっていない場合は0を返す
    if d >= r1 + r2:
        return 0
    # 一方の円がもう一方の円を完全に含んでいる場合
    if d <= abs(r1 - r2):
        return math.pi * min(r1, r2) ** 2
    
    # 重なり面積を計算
    r1_sq = r1 ** 2
    r2_sq = r2 ** 2
    try:
        part1 = r1_sq * math.acos(max(-1, min(1, (d ** 2 + r1_sq - r2_sq) / (2 * d * r1))))
        part2 = r2_sq * math.acos(max(-1, min(1, (d ** 2 + r2_sq - r1_sq) / (2 * d * r2))))
    except ValueError:
        return 0
    part3 = 0.5 * math.sqrt((-d + r1 + r2) * (d + r1 - r2) * (d - r1 + r2) * (d + r1 + r2))
    return part1 + part2 - part3


# 半径が0の円を削除する関数
def filter_zero_radius_circles(circles):
    return [circle for circle in circles if circle['radius'] > 0]

# クラスタ間の重複を除外する関数（半径が小さい方を残す）
def remove_large_overlapping_circles(circles, overlap_threshold=0.8):
    filtered_circles = []
    
    for i, circle in enumerate(circles):
        keep_circle = True
        for other_circle in circles:
            if circle == other_circle:
                continue
            distance_between_centers = great_circle(
                (circle['latitude'], circle['longitude']),
                (other_circle['latitude'], other_circle['longitude'])
            ).meters
            
            # 2つの円の重なり面積を計算
            overlap_area = calculate_overlap_area(circle['radius'], other_circle['radius'], distance_between_centers)
            circle_area = math.pi * (circle['radius'] ** 2)
            other_circle_area = math.pi * (other_circle['radius'] ** 2)
            
            # 80%以上の重なりがある場合、半径が大きい方を削除
            if overlap_area / min(circle_area, other_circle_area) > overlap_threshold:
                if circle['radius'] > other_circle['radius']:
                    keep_circle = False  # 大きな円を削除
                    break
        if keep_circle:
            filtered_circles.append(circle)
    
    return filtered_circles

# チャンクごとにデータを読み込みながら処理
chunk_id = 1
for chunk in pd.read_csv('US_Accidents_March23.csv', chunksize=chunksize):
    result_chunk = process_chunk(chunk, chunk_id)
    if result_chunk is not None:
        results.extend(result_chunk)
    print(f"Chunk {chunk_id} processing complete.\n")
    chunk_id += 1

# 半径が0の円を除外
results = filter_zero_radius_circles(results)

# 重複を除外する（面積の80％以上が重なる円を除外）
filtered_results = remove_large_overlapping_circles(results, overlap_threshold=0.8)

# 最終結果をJSONファイルに保存
with open('texas_clustered_accidents_filtered.json', 'w') as f:
    json.dump(filtered_results, f, indent=4)

print("All chunks processed and data saved to 'texas_clustered_accidents_filtered.json'.")
