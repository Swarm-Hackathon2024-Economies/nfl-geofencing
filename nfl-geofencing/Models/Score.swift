
import SwiftUI

class ScoreManager: ObservableObject {
    @Published var score: Int = 5234
    
    func increment(addScore:Int) {
        score += addScore
    }
    
    func decrement(subScore:Int) {
        score -= subScore
    }
}
