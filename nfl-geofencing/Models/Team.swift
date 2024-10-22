import SwiftUI

struct Team: Equatable {
    let rank: String
    let name: String
    let points: String
    let icon: String
    let color: Color

    static var allItems: [Team] = [
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
        Team(rank: "12", name: "Commands", points: "144,861", icon: "washington-commanders", color: .indigo),
    ]
}

struct collageTeam: Equatable {
    let rank: String
    let name: String
    let points: String
    let icon: String
    let color: Color

    static let allItems: [Team] = [
        Team(rank: "1", name: "Rat", points: "945,108", icon: "baltimore-ravens", color: .red),
        Team(rank: "2", name: "Ox", points: "927,582", icon: "buffalo-bills", color: .blue),
        Team(rank: "3", name: "Tiger", points: "873,451", icon: "cincinnati-bengals", color: .black),
        Team(rank: "4", name: "Rabbit", points: "712,481", icon: "indianapolis-colts", color: .brown),
        Team(rank: "5", name: "Dragon", points: "654,124", icon: "new-england-patriots", color: .yellow),
        Team(rank: "6", name: "Snake", points: "569,030", icon: "new-los-angeles-rams", color: .cyan),
        Team(rank: "7", name: "Horse", points: "489,205", icon: "new-orleans-saints", color: .mint),
        Team(rank: "8", name: "Goat", points: "332,479", icon: "philadelphia-eagles", color: .green),
        Team(rank: "9", name: "Monkey", points: "224,597", icon: "san-diego-chargers", color: .pink),
        Team(rank: "10", name: "Rooster", points: "187,656", icon: "san-francisco-49ers", color: .purple),
        Team(rank: "11", name: "Dog", points: "148,933", icon: "seattle-seahawks", color: .teal),
        Team(rank: "12", name: "Pig", points: "110,022", icon: "washington-commanders", color: .indigo),
    ]
}

struct flagFootballTeam: Equatable {
    let rank: String
    let name: String
    let points: String
    let icon: String
    let color: Color

    static let allItems: [Team] = [
        Team(rank: "1", name: "Taiyang", points: "978,341", icon: "baltimore-ravens", color: .red),
        Team(rank: "2", name: "Taiyin", points: "952,108", icon: "buffalo-bills", color: .blue),
        Team(rank: "3", name: "Tianji", points: "849,755", icon: "cincinnati-bengals", color: .black),
        Team(rank: "4", name: "Taisui", points: "794,503", icon: "indianapolis-colts", color: .brown),
        Team(rank: "5", name: "Tianliang", points: "682,320", icon: "new-england-patriots", color: .yellow),
        Team(rank: "6", name: "Tianyao",points: "633,109",icon: "new-los-angeles-rams", color: .cyan),
        Team(rank: "7", name: "Tianfu", points: "549,201", icon: "new-orleans-saints", color: .mint),
        Team(rank: "8", name: "Tianxiang", points: "467,892", icon: "philadelphia-eagles", color: .green),
        Team(rank: "9", name: "Tianzun",points: "341,255", icon: "san-diego-chargers", color: .pink),
        Team(rank: "10", name: "Tiankui" ,points: "279,872", icon: "san-francisco-49ers", color: .purple),
        Team(rank: "11", name: "Tianxing", points: "198,543", icon: "seattle-seahawks", color: .teal),
        Team(rank: "12", name: "Tianyao", points: "123,076", icon: "washington-commanders", color: .indigo),
    ]
}
