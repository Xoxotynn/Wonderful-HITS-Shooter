import UIKit

final class DefaultEnemyGroup: EnemyGroup {
    
    init() {
        super.init(enemyGroupCreator: DefaultEnemyGroupCreator(enemyCount: 16),
                   routeCreator: LineRouteCreator(length: 0.8),
                   positionCreator: CirclePositionCreator.smallCenterCircle)
//                   positionCreator: FilledRectPositionCreator(
//                    rows: 4,
//                    margins: CGPoint(x: 0.15, y: 0.1),
//                    origin: CGPoint(x: 0.05, y: -0.1)))
    }
}
