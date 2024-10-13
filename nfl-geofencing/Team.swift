struct Team: Equatable {
    let name: String
    let points: Int
    let image: String
    
    static let Ravens = Team(name: "Ravens", points: 834339, image: "baltimore-ravens")
    static let Bills = Team(name: "Bills", points: 630496, image: "buffalo-bills")
    static let Bengals = Team(name: "Bengals", points: 627995, image: "cincinnati-bengals")
    static let Colts = Team(name: "Colts", points: 484724, image: "indianapolis-colts")
    static let Patriots = Team(name: "Patriots", points: 453321, image: "new-england-patriots")
    static let Angeles = Team(name: "Angeles", points: 408419, image: "new-los-angeles-rams")
    static let Saints = Team(name: "Saints", points: 365405, image: "new-orleans-saints")
    static let Eagles = Team(name: "Eagles", points: 345094, image: "philadelphia-eagles")
    static let Chargers = Team(name: "Chargers", points: 309080, image: "san-diego-chargers")
    static let _49ers = Team(name: "_49ers", points: 275707, image: "san-francisco-49ers")
    static let Seahawks = Team(name: "Seahawks", points: 154308, image: "seattle-seahawks")
    static let Commanders = Team(name: "Commanders", points: 144861, image: "washington-commanders")

    static let allItems: [Team] = [Ravens,
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
