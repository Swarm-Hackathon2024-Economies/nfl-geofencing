import Foundation

struct CircleArea: Identifiable, Decodable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    let radius: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case radius = "radius"
    }
}

protocol DangerAreaRepository {
    func getAll() -> [CircleArea]
    func get(by season: Season, isNight: Bool) -> [CircleArea]
}

enum Season {
    case spring
    case summer
    case autumn
    case winter
}

class JsonDangerAreaRepository: DangerAreaRepository {
    
    private let filename = "crustered-accident"

    func getAll() -> [CircleArea] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("JSONファイルが見つかりません")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let circleAreas = try JSONDecoder().decode([CircleArea].self, from: data)
            return circleAreas
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error)")
            return []
        }
    }

    func get(by season: Season, isNight: Bool) -> [CircleArea] {
        let detail: String = isNight ? "night" : "day"

        guard let url = Bundle.main.url(forResource: "\(filename)-\(detail)", withExtension: "json") else {
            print("JSONファイルが見つかりません")
            return []
        }

        do {
            let data = try Data(contentsOf: url)

            let circleAreas = try JSONDecoder().decode([CircleArea].self, from: data)
            return circleAreas
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error)")
            return []
        }
    }
}

struct TrafficAccident: Decodable, Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    let date: Date
    let aadt: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Start_Lat"
        case longitude = "Start_Lng"
        case date = "Start_Time"
        case aadt = "AADT"
    }
}

class TrafficAccidentRepository {
    private let filename: String = "accidents_with_traffic_data"
    
    func getAll() -> [TrafficAccident] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("JSONファイルが見つかりません")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(formatter)
            let trafficAccidents = try decoder.decode([TrafficAccident].self, from: data)
            let filtered = trafficAccidents.filter { $0.aadt < 10000 }
            print(filtered)
            return trafficAccidents
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error)")
            return []
        }
    }
}
