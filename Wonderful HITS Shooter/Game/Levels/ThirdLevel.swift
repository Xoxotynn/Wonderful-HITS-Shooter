import UIKit

final class ThirdLevel: Level {
    
    private let maxScore: Int
    
    init() {
        maxScore = Dimensions.LevelsMaxPoints.third
        super.init(
            player: Player(),
            waves: [Wave(enemyGroups: [
                        EnemyGroupFactory.createStraightLargeRectGroup(),
                        EnemyGroupFactory
                            .createDiagonalSmallCircleGroup(isMirrored: false),
                        EnemyGroupFactory
                            .createDiagonalSmallCircleGroup(isMirrored: true)
                    ]),
                    Wave(enemyGroups: [
                        EnemyGroupFactory.createStraightLargeCircleGroup(),
                        EnemyGroupFactory.createDiagonalCenterRectGroup()
                    ]),
                    Wave(enemyGroups: [
                        EnemyGroupFactory.createStraightLargeCircleGroup(),
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
