import Foundation

protocol GameEngineProtocol: AnyObject {
    var player: Int { get set }
    var enemies: [Int] { get set }
    func spawnPlayer()
    func spawnEnemy()
    func upScore()
}

#warning("Level Logic")

final class GameEngine {
    
    var player: Player?
    var enemies: [Enemy]
    
    init() {
        enemies = []
    }
    
    func start() {
        player = Player()
        player?.delegate = self
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

extension GameEngine: PlayerDelegate {
    func gameOver() {
        
    }
}
