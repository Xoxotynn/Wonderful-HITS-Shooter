import UIKit

final class EnemyGroup {
    
    private var enemies: [Enemy]
    private var route: [CGPoint]
    
    private init(waveSpawner: EnemyGroupCreator,
                 routeCreator: RouteCreator,
                 positionCreator: PositionCreator) {
        enemies = waveSpawner.createEnemies()
        route = routeCreator.createRoute()
        setupPosition(positionCreator: positionCreator)
    }
    
    func remove(enemy: Enemy) {
        if let index = enemies.firstIndex(of: enemy) {
            enemies.remove(at: index)
        }
    }
    
    private func setupPosition(positionCreator: PositionCreator) {
        var positions = positionCreator
            .createPositions(enemiesCount: enemies.count)
        
        enemies.forEach { enemy in
            guard let position = positions.popLast() else { return }
            enemy.frame.origin = position
        }
    }
}

extension EnemyGroup {
//    static let group1 = EnemyGroup(waveSpawner: WaveSpawner(), routeCreator: RouteCreator(), positionCreator: PositionsCreator())
}
