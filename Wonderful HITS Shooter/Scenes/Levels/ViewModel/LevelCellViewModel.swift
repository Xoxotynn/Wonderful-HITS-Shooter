import UIKit

final class LevelCellViewModel {
    // MARK: - Properties
    var levelNumber: Int?
    var points: Int?
    var maxPoints: Int?
    var firstStarColor: UIColor = Colors.loseStarColor
    var secondStarColor: UIColor = Colors.loseStarColor
    var thirdStarColor: UIColor = Colors.loseStarColor
    
    var didUpdateData: (() -> Void)?
    
    private let level: LevelModel
    
    // MARK: - Init
    init(level: LevelModel) {
        self.level = level
    }
    
    // MARK: - Public Methods
    func setup() {
        levelNumber = level.levelNumber
        points = level.points
        maxPoints = level.maxPoints
        
        let ratio: Float = Float(points ?? 0) / Float(maxPoints ?? 0)
        if ratio >= 0.9 {
            firstStarColor = Colors.winStarColor
            secondStarColor = Colors.winStarColor
            thirdStarColor = Colors.winStarColor
        } else if ratio >= 0.6 {
            firstStarColor = Colors.winStarColor
            secondStarColor = Colors.winStarColor
        } else if ratio >= 0.3 {
            firstStarColor = Colors.winStarColor
        }
        
        didUpdateData?()
    }
}

private extension Colors {
    static let loseStarColor = UIColor.brown
    static let winStarColor = UIColor.yellow
}
