import Foundation

class FootballPosition: ObservableObject {
    @Published var positions: [String] = [
        "Quarterback",
        "Running Back",
        "Fullback",
        "Wide Receiver",
        "Tight End",
        "Offensive Tackle",
        "Offensive Guard",
        "Center",
        "Defensive Tackle",
        "Defensive End",
        "Linebacker",
        "Cornerback",
        "Safety",
        "Kicker",
        "Punter",
        "Kick Returner",
        "Punt Returner",
        "Long Snapper",
        "Holder"
    ]
}
