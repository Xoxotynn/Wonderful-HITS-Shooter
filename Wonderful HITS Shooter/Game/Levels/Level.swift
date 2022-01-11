//
//  Level.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 26.12.2021.
//

import Foundation

protocol LevelDelegate: AnyObject {
    func setupUI(forPlayer player: Player)
    func setupUI(forEnemies enemies: [EnemyGroup])
}

class Level {
    
    var player: Player
    var waves: [Wave]
    var enemies: [Enemy]
    
    weak var delegate: LevelDelegate?
    
    init(player: Player, waves: [Wave]) {
        self.player = player
        self.waves = waves
        self.enemies = []
        self.player.delegate = self
        
        spawnNextWave()
    }
    
    func spawnNextWave() {
        guard let wave = waves.popLast() else {
            return
        }
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
        if let index = enemies.firstIndex(of: enemy) {
            enemies.remove(at: index)
        }
    }
}
