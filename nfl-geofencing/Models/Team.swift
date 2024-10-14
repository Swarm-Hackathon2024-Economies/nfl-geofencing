import SwiftUI

struct Team: Equatable {
    let rank: String
    let name: String
    let points: String
    let icon: String
    let color: Color

    static let allItems: [Team] = [
        Team(rank: "1", name: "Ravens", points: "834,339", icon: "baltimore-ravens", color: .red),
        Team(rank: "2", name: "Bills", points: "630,496", icon: "buffalo-bills", color: .blue),
        Team(rank: "3", name: "Bengals", points: "627,995", icon: "cincinnati-bengals", color: .black),
        Team(rank: "4", name: "Colts", points: "484,724", icon: "indianapolis-colts", color: .brown),
        Team(rank: "5", name: "Patriots", points: "453,321", icon: "new-england-patriots", color: .yellow),
        Team(rank: "6", name: "Angeles", points: "408,419", icon: "new-los-angeles-rams", color: .cyan),
        Team(rank: "7", name: "Saints", points: "365,405", icon: "new-orleans-saints", color: .mint),
        Team(rank: "8", name: "Eagles", points: "345,094", icon: "philadelphia-eagles", color: .green),
        Team(rank: "9", name: "Chargers", points: "309,080", icon: "san-diego-chargers", color: .pink),
        Team(rank: "10", name: "49ers", points: "275,707", icon: "san-francisco-49ers", color: .purple),
        Team(rank: "11", name: "Seahawks", points: "154,308", icon: "seattle-seahawks", color: .teal),
        Team(rank: "12", name: "Commanders", points: "144,861", icon: "washington-commanders", color: .indigo),
    ]
}
