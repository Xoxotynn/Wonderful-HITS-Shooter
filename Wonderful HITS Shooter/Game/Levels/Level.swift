import UIKit

protocol LevelDelegate: AnyObject {
    func gameFieldRatio(forLevel level: Level) -> CGFloat
    func setupUI(forPlayer player: Player)
    func setupUI(forEnemies enemies: [EnemyGroup])
}

class Level {
    
    var player: Player
    var waves: [Wave]
    var enemyGroups: [EnemyGroup]
    
    weak var delegate: LevelDelegate?
    
    init(player: Player, waves: [Wave]) {
        self.player = player
        self.waves = waves
        self.enemyGroups = []
        self.player.delegate = self
        delegate?.setupUI(forPlayer: player)
        spawnNextWave()
    }
    
    func spawnNextWave() {
        delegate?.setupUI(forEnemies: enemyGroups)
    }
}

extension Level: PlayerDelegate {
    func gameOver() {
        
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
