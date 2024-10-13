import Foundation

struct Card: Identifiable {
    let id = UUID()
    let collectionName: String
    let series: String
    let imageName: String
}
