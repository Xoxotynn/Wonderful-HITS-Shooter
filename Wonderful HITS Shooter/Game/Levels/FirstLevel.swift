import UIKit

final class FirstLevel: Level {
    
    private let maxScore: Int
    
    init() {
        maxScore = 3000
        super.init(player: Player(), waves: [Wave(), Wave(), Wave()])
    }
    
    override func getStarsCount() -> Int {
        let percents = Int((CGFloat(currentScore) / CGFloat(maxScore)) * 100)
        return percents / 30
    }
}
