import UIKit

protocol LevelDelegate: AnyObject {
    func gameOver(withSuccess isSuccess: Bool)
    func setupUI(forPlayer player: Player)
    func setupUI(forEnemyGroup enemyGroup: EnemyGroup)
    func setupUI(forBullet bullet: Bullet)
}

class Level {
    
    weak var delegate: LevelDelegate?
    
    private var player: Player
    private var waves: [Wave]
    private var enemyGroups: [EnemyGroup]
    private var playerTimer: Timer?
    private var isGameFinished: Bool
    
    init(player: Player, waves: [Wave]) {
        isGameFinished = false
        self.player = player
        self.waves = waves
        self.enemyGroups = []
        self.player.delegate = self
    }
    
    func startLevel() {
        playerTimer = Timer.scheduledTimer(
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
                if enemy.frame.intersects(player.spaceshipFrame)
                   && !isGameFinished {
                    isGameFinished = true
                    playerTimer?.invalidate()
                    player.die()
                }
            }
        }
    }
}

extension Level: PlayerDelegate {
    func player(didShootBullet bullet: Bullet) {
        delegate?.setupUI(forBullet: bullet)
    }
    
    func gameOver() {
        delegate?.gameOver(withSuccess: false)
    }
}

extension Level: EntityDelegate {
    func entity(didDie deadEntity: Entity) {
        
    }
}

extension Level: EnemyGroupDelegate {
    func didDie(enemyGroup: EnemyGroup, enemy: Enemy) {
        
    }
    
    func didDie(enemyGroup: EnemyGroup, entity: Entity) {
        
    }
}
