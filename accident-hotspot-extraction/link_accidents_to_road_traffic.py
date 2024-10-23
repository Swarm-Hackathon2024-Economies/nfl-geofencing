import pandas as pd
import geopandas as gpd
from shapely.geometry import Point

# ファイルパスを指定
accident_data_path = 'filtered_accidents_2022_dallas_fortworth.csv'
traffic_data_path = 'aadt.csv'
road_network_path = 'TxDOT_Roadways.shp'

# CSVファイルと道路ネットワークの読み込み
print("データを読み込んでいます...")
accidents_df = pd.read_csv(accident_data_path)
traffic_df = pd.read_csv(traffic_data_path)
roads_gdf = gpd.read_file(road_network_path)

# 道路データのCRSを設定（EPSG:3857）し、EPSG:4326に変換
print("道路データの座標系を設定して変換中...")
roads_gdf.set_crs(epsg=3857, inplace=True)
roads_gdf = roads_gdf.to_crs(epsg=4326)

# 交通量データを道路データに結合
print("交通量データを道路データに結合中...")
traffic_gdf = gpd.GeoDataFrame(
    traffic_df,
    geometry=gpd.points_from_xy(traffic_df['longitude'], traffic_df['latitude']),
    crs="EPSG:4326"
)
roads_with_traffic_gdf = gpd.sjoin_nearest(roads_gdf, traffic_gdf[['geometry', 'AADT']], how='left', max_distance=0.01)

# 事故データをGeoDataFrameに変換
print("事故データをGeoDataFrameに変換中...")
accidents_gdf = gpd.GeoDataFrame(
    accidents_df, 
    geometry=gpd.points_from_xy(accidents_df['Start_Lng'], accidents_df['Start_Lat']),
    crs="EPSG:4326"  # CRSを道路データと一致させる
)

# 道路データの空間インデックスを作成
print("道路データの空間インデックスを作成中...")
road_sindex = roads_with_traffic_gdf.sindex

# バッファ距離（単位は度数）
buffer_distance = 0.005  # 約500m程度（1度が約111kmのため）

# 各事故地点に対して最寄りの道路を効率的に検索
def find_nearest_road(accident_point, roads_gdf, road_sindex, max_distance=buffer_distance):
    # 検索範囲を事故地点周辺のバッファに限定
    possible_matches_index = list(road_sindex.intersection(accident_point.buffer(max_distance).bounds))
    possible_matches = roads_gdf.iloc[possible_matches_index]
    
    # 事故地点からの距離を計算し、最も近い道路を見つける
    if not possible_matches.empty:
        possible_matches['distance'] = possible_matches.geometry.distance(accident_point)
        nearest_road = possible_matches.loc[possible_matches['distance'].idxmin()]
        return nearest_road.name  # インデックスを返す
    else:
        return None

# 最近傍道路の検索を適用
print("事故地点ごとに最寄りの道路を検索中...")
total_accidents = len(accidents_gdf)
for i, (index, row) in enumerate(accidents_gdf.iterrows()):
    if i % 100 == 0:
        print(f"{i}/{total_accidents} 件処理済み ({i/total_accidents*100:.2f}%)")
    accidents_gdf.at[index, 'nearest_road_id'] = find_nearest_road(row.geometry, roads_with_traffic_gdf, road_sindex)

# データ型を揃えるため、nearest_road_id を整数型に戻してから文字列型に変換
accidents_gdf['nearest_road_id'] = accidents_gdf['nearest_road_id'].astype(float).astype(int).astype(str)
roads_with_traffic_gdf.index = roads_with_traffic_gdf.index.astype(str)

# マッチングした道路情報を事故データに結合
print("道路情報を事故データに結合中...")
merged_accidents_df = accidents_gdf.merge(
    roads_with_traffic_gdf[['AADT']], 
    left_on='nearest_road_id', 
    right_index=True, 
    how='left'
)

# geometry列を削除して最終的なCSVに保存
print("結果をCSVファイルに保存中...")
merged_accidents_df.drop(columns='geometry', inplace=True)
output_csv_path = 'accidents_with_traffic_data.csv'
merged_accidents_df.to_csv(output_csv_path, index=False)

print(f'マッチングされたデータが {output_csv_path} に保存されました。')
