import Foundation

protocol GameEngineProtocol: AnyObject {
    var player: Int { get set }
    var enemies: [Int] { get set }
    func spawnPlayer()
    func spawnEnemy()
    func upScore()
}

final class GameEngine {
    
    
    var enemies: [Enemy]
    
    init() {
        enemies = []
    }
    
    
}

extension GameEngine: EntityDelegate {
    func didDie(entity: Entity) {
        
    }
}

extension GameEngine: EnemyDelegate {
    func didDie(enemy: Enemy) {
        if let index = enemies.firstIndex(of: enemy) {
            enemies.remove(at: index)
        }
    }
}


