import Foundation

final class Wave {
    
    let enemyGroups: [EnemyGroup]
    
    init() {
        enemyGroups = [
            EnemyGroup(
                enemyGroupCreator: DefaultEnemyGroupCreator(enemyCount: 16),
                routeCreator: LineRouteCreator(length: 0.7),
                positionCreator: CirclePositionCreator.largeCenterCircle),
            EnemyGroup(
                enemyGroupCreator: DefaultEnemyGroupCreator(enemyCount: 9),
                routeCreator: DiagonalRouteCreator.smallAmplitudeRoute,
                positionCreator: FilledRectPositionCreator.mediumCenterRect)
        ]
    }
}
