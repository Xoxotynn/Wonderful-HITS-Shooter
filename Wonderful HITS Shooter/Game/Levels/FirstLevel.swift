import UIKit

final class FirstLevel: Level {
    
    private let maxScore: Int
    
    init() {
        maxScore = Dimensions.LevelsMaxPoints.first
        super.init(
            player: Player(),
            waves: [Wave(enemyGroups: [
                        EnemyGroupFactory.createStraightLargeRectGroup()
                    ]),
                    Wave(enemyGroups: [
                        EnemyGroupFactory.createDiagonalCenterRectGroup()
                    ]),
                    Wave(enemyGroups: [
                        EnemyGroupFactory
                            .createDiagonalSmallCircleGroup(isMirrored: false),
                        EnemyGroupFactory
                            .createDiagonalSmallCircleGroup(isMirrored: true)
                    ])
                   ])
    }
    
    override func getStarsCount() -> Int {
        let percents = Int((CGFloat(currentScore) / CGFloat(maxScore)) * 100)
        return percents / 30
    }
}
