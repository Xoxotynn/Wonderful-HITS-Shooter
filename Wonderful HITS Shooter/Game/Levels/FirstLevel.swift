import Foundation

final class FirstLevel: Level {
    
    private let maxScore: Int
    
    init() {
        maxScore = 2000
        super.init(player: Player(), waves: [Wave()])
    }
}
