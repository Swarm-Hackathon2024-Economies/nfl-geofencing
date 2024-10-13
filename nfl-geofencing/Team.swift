import SwiftUI

struct Team: Equatable {
    let name: String
    let points: Int
    let image: String
    let color: Color

    static let Ravens = Team(name: "Ravens", points: 834339, image: "baltimore-ravens", color: .red)
    static let Bills = Team(name: "Bills", points: 630496, image: "buffalo-bills", color: .blue)
    static let Bengals = Team(name: "Bengals", points: 627995, image: "cincinnati-bengals", color: .black)
    static let Colts = Team(name: "Colts", points: 484724, image: "indianapolis-colts", color: .brown)
    static let Patriots = Team(name: "Patriots", points: 453321, image: "new-england-patriots", color: .yellow)
    static let Angeles = Team(name: "Angeles", points: 408419, image: "new-los-angeles-rams", color: .cyan)
    static let Saints = Team(name: "Saints", points: 365405, image: "new-orleans-saints", color: .mint)
    static let Eagles = Team(name: "Eagles", points: 345094, image: "philadelphia-eagles", color: .green)
    static let Chargers = Team(name: "Chargers", points: 309080, image: "san-diego-chargers", color: .pink)
    static let _49ers = Team(name: "_49ers", points: 275707, image: "san-francisco-49ers", color: .purple)
    static let Seahawks = Team(name: "Seahawks", points: 154308, image: "seattle-seahawks", color: .teal)
    static let Commanders = Team(name: "Commanders", points: 144861, image: "washington-commanders", color: .indigo)

    static let allItems: [Team] = [
        Ravens,
        Bills,
        Bengals,
        Colts,
        Patriots,
        Angeles,
        Saints,
        Eagles,
        Chargers,
        _49ers,
        Seahawks,
        Commanders
    ]
}
