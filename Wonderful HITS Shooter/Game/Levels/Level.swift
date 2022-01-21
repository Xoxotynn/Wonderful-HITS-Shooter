import UIKit

protocol LevelDelegate: AnyObject {
    func gameOver(withSuccess isSuccess: Bool)
    func setupUI(forPlayer player: Player)
    func setupUI(forEnemyGroup enemyGroup: EnemyGroup)
    func setupUI(forBullet bullet: Bullet)
    func setupUI(forDeadEnemy enemy: Enemy)
    func setupUI(forExplodedBullet bullet: Bullet)
}

class Level {
    
    weak var delegate: LevelDelegate?
    
    private(set) var currentScore: Int
    private var player: Player
    private var waves: [Wave]
    private var enemyGroups: [EnemyGroup]
    private var isGameFinished: Bool
    
    init(player: Player, waves: [Wave]) {
        isGameFinished = false
        currentScore = 0
        self.player = player
        self.waves = waves
        self.enemyGroups = []
        self.player.delegate = self
    }
    
    func startLevel() {
        delegate?.setupUI(forPlayer: player)
        spawnNextWave()
    }
    
    func spawnNextWaveIfNeeded() {
        if enemyGroups.isEmpty {
            spawnNextWave()
        }
    }
    
    func spawnNextWave() {
        guard let wave = waves.first else {
            player.die()
            delegate?.gameOver(withSuccess: true)
            return
        }
        
        enemyGroups = wave.enemyGroups
        enemyGroups.forEach { enemyGroup in
            enemyGroup.delegate = self
            delegate?.setupUI(forEnemyGroup: enemyGroup)
        }
        waves.remove(at: 0)
    }
    
    func getStarsCount() -> Int { 0 }
}

extension Level: PlayerDelegate {
    func isCollidingWithEnemy(player: Player) -> Enemy? {
        var collidingEnemy: Enemy?
        enemyGroups.forEach { enemyGroup in
            enemyGroup.enemies.forEach { enemy in
                if enemy.frame.intersects(player.spaceshipFrame)
                   && !isGameFinished {
                    isGameFinished = true
                    collidingEnemy = enemy
                    return
                }
            }
        }
        
        return collidingEnemy
    }
    
    func player(didShootBullet bullet: Bullet) {
        bullet.bulletDelegate = self
        delegate?.setupUI(forBullet: bullet)
    }
    
    func gameOver() {
        delegate?.gameOver(withSuccess: false)
    }
}

extension Level: EnemyGroupDelegate {
    func didDie(enemyGroup: EnemyGroup, enemy: Enemy) {
        currentScore += 100
        enemyGroups.removeAll(where: { $0.isEmpty })
        delegate?.setupUI(forDeadEnemy: enemy)
        spawnNextWaveIfNeeded()
    }
}

extension Level: BulletDelegate {
    func isCollidingWithEnemy(bullet: Bullet) -> Enemy? {
        var collidingEnemy: Enemy?
        enemyGroups.forEach { enemyGroup in
            enemyGroup.enemies.forEach { enemy in
                let intersection = enemy.frame.intersection(bullet.frame)
                if !intersection.isNull && intersection.origin.y > 0 {
                    collidingEnemy = enemy
                    return
                }
            }
        }
        
        return collidingEnemy
    }
    
    func didDie(bullet: Bullet) {
        delegate?.setupUI(forExplodedBullet: bullet)
    }
}
