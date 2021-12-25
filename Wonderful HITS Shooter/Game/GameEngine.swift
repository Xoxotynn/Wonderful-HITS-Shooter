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
    var enemies: [Enemy]?
    
    func start() {
        player = Player()
        player?.delegate = self
    }
}

extension GameEngine: PlayerDelegate {
    func gameOver() {
        
    }
}
