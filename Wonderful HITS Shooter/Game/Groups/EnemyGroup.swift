import UIKit

protocol EnemyGroupDelegate: AnyObject {
    func didDie(enemyGroup: EnemyGroup, enemy: Enemy)
}

class EnemyGroup {
    
    weak var delegate: EnemyGroupDelegate?
    var isEmpty: Bool {
        get {
            enemies.isEmpty
        }
    }
    
    private(set) var enemies: [Enemy]
    
    init(enemyGroupCreator: EnemyGroupCreator,
         routeCreator: RouteCreator,
         positionCreator: PositionCreator) {
        enemies = enemyGroupCreator.createEnemies()
        setupPosition(positionCreator: positionCreator)
        setupRoutes(routeCreator: routeCreator)
        setupDelegates()
    }
    
    func remove(enemy: Enemy) {
        if let index = enemies.firstIndex(of: enemy) {
            enemies.remove(at: index)
        }
    }
    
    private func setupDelegates() {
        enemies.forEach { enemy in
            enemy.enemyDelegate = self
        }
    }
    
    private func setupPosition(positionCreator: PositionCreator) {
        var positions = positionCreator
            .createPositions(enemiesCount: enemies.count)
        guard !positions.isEmpty else { return }
        
        enemies.forEach { enemy in
            guard let position = positions.first else { return }
            positions.remove(at: 0)
            enemy.frame.origin = position
        }
    }
    
    private func setupRoutes(routeCreator: RouteCreator) {
        let route = routeCreator.createRoute()
        guard !route.isEmpty else { return }
        
        enemies.forEach { enemy in
            enemy.route = calculateEnemyRoute(forEnemy: enemy,
                                              relativeRoute: route)
        }
    }
    
    private func calculateEnemyRoute(
        forEnemy enemy: Enemy,
        relativeRoute: [CGPoint]) -> [CGPoint] {
            var route: [CGPoint] = [CGPoint(x: enemy.frame.origin.x,
                                            y: enemy.frame.origin.y)]
            
            relativeRoute.forEach { nextPosition in
                guard let previousPosition = route.last else { return }
                route.append(CGPoint(
                    x: previousPosition.x + nextPosition.x,
                    y: previousPosition.y + nextPosition.y))
            }
            route.remove(at: 0)
            
            return route
        }
}

extension EnemyGroup: EnemyDelegate {
    func enemy(didDie deadEnemy: Enemy) {
        remove(enemy: deadEnemy)
        delegate?.didDie(enemyGroup: self, enemy: deadEnemy)
    }
}
