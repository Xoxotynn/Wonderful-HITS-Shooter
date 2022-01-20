import UIKit

protocol LevelDelegate: AnyObject {
    func gameOver(withSuccess isSuccess: Bool)
    func setupUI(forPlayer player: Player)
    func setupUI(forEnemyGroup enemyGroup: EnemyGroup)
}

class Level {
    
    weak var delegate: LevelDelegate?
    
    private var player: Player
    private var waves: [Wave]
    private var enemyGroups: [EnemyGroup]
    
    init(player: Player, waves: [Wave]) {
        self.player = player
        self.waves = waves
        self.enemyGroups = []
        self.player.delegate = self
    }
    
    func startLevel() {
        Timer.scheduledTimer(
            timeInterval: 0.05,
            target: self,
            selector: #selector(checkPlayerCollision),
            userInfo: nil,
            repeats: true)
        delegate?.setupUI(forPlayer: player)
        spawnNextWave()
    }
    
    func spawnNextWave() {
        guard let wave = waves.first else {
            delegate?.gameOver(withSuccess: true)
            return
        }
        
        waves.remove(at: 0)
        enemyGroups = wave.enemyGroups
        enemyGroups.forEach { enemyGroup in
            delegate?.setupUI(forEnemyGroup: enemyGroup)
        }
    }
    
    func changePlayerSpaceshipFrame(with frame: CGRect) {
        player.spaceshipFrame = frame
    }
    
    @objc private func checkPlayerCollision() {
        enemyGroups.forEach { enemyGroup in
            enemyGroup.enemies.forEach { enemy in
                if enemy.frame.intersects(player.spaceshipFrame) {
                    player.die()
                }
            }
        }
    }
}

extension Level: PlayerDelegate {
    func gameOver() {
        print(player.spaceshipFrame)
        delegate?.gameOver(withSuccess: false)
    }
}

extension Level: EntityDelegate {
    func didDie(entity: Entity) {
        
    }
}

extension Level: EnemyDelegate {
    func didDie(enemy: Enemy) {
        enemyGroups.forEach { enemyGroup in
            enemyGroup.remove(enemy: enemy)
        }
    }
}
