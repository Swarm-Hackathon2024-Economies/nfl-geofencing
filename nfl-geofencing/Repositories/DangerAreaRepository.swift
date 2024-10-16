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
        return []
    }
}
