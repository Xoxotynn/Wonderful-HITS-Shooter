import Foundation

final class EnemyGroupFactory {
    
    static func createStraightLargeCircleGroup() -> EnemyGroup {
        return EnemyGroup(
            enemyGroupCreator: DefaultEnemyGroupCreator(enemyCount: 16),
            routeCreator: LineRouteCreator(length: 0.7),
            positionCreator: CirclePositionCreator.largeCenterCircle)
    }
    
    static func createDiagonalSmallCircleGroup(isMirrored: Bool) -> EnemyGroup {
        let positionCreator = isMirrored ?
            CirclePositionCreator.smallRightCornerCircle :
            CirclePositionCreator.smallLeftCornerCircle
        let routeCreator = isMirrored ?
            DiagonalRouteCreator.smallMirroredAmplitudeRoute :
            DiagonalRouteCreator.smallAmplitudeRoute
        return EnemyGroup(
            enemyGroupCreator: DefaultEnemyGroupCreator(enemyCount: 8),
            routeCreator: routeCreator,
            positionCreator: positionCreator)
    }
    
    static func createStraightLargeRectGroup() -> EnemyGroup {
        return EnemyGroup(
            enemyGroupCreator: DefaultEnemyGroupCreator(enemyCount: 20),
            routeCreator: LineRouteCreator(length: 0.7),
            positionCreator: FilledRectPositionCreator.fullWidthRect)
    }
    
    static func createDiagonalCenterRectGroup() -> EnemyGroup {
        return EnemyGroup(
            enemyGroupCreator: DefaultEnemyGroupCreator(enemyCount: 9),
            routeCreator: DiagonalRouteCreator.largeAmplitudeRoute,
            positionCreator: FilledRectPositionCreator.mediumCenterRect)
    }
}
