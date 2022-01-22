import UIKit

final class SecondLevel: Level {
    
    private let maxScore: Int
    
    init() {
        maxScore = Dimensions.LevelsMaxPoints.second
        super.init(
            player: Player(),
            waves: [Wave(enemyGroups: [
                        EnemyGroupFactory.createStraightLargeCircleGroup(),
                        EnemyGroupFactory.createDiagonalCenterRectGroup()
                    ]),
                    Wave(enemyGroups: [
                        EnemyGroupFactory
                            .createDiagonalSmallCircleGroup(isMirrored: false),
                        EnemyGroupFactory.createDiagonalCenterRectGroup()
                    ]),
                    Wave(enemyGroups: [
                        EnemyGroupFactory.createStraightLargeCircleGroup(),
                        EnemyGroupFactory.createStraightLargeRectGroup()
                    ])
                   ])
    }
    
    override func getStarsCount() -> Int {
        let percents = Int((CGFloat(currentScore) / CGFloat(maxScore)) * 100)
        return percents / 30
    }
}
