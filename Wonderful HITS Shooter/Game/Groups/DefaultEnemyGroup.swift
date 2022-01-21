import UIKit

final class DefaultEnemyGroup: EnemyGroup {
    
    init() {
        super.init(enemyGroupCreator: DefaultEnemyGroupCreator(),
                   routeCreator: LineRouteCreator(length: 0.7),
                   positionCreator: FilledRectPositionCreator(
                    rows: 4,
                    margins: CGPoint(x: 0.15, y: 0.1),
                    origin: CGPoint(x: 0.05, y: -0.4)))
    }
}
