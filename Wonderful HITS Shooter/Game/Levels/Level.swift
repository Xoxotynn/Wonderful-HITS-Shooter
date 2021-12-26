//
//  Level.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 26.12.2021.
//

import Foundation

protocol LevelDelegate: AnyObject {
    func setupUI(forPlayer player: Player)
    func setupUI(forEnemies enemies: [Enemy])
}

class Level {
    
    var player: Player
    var waveSpawners: [WaveSpawner]
    var enemies: [Enemy]
    
    weak var delegate: LevelDelegate?
    
    init(player: Player, waveSpawners: [WaveSpawner]) {
        self.player = player
        self.waveSpawners = waveSpawners
        self.enemies = []
        self.player.delegate = self
        
        spawnNextWave()
    }
    
    func spawnNextWave() {
        guard let waveSpawner = waveSpawners.popLast() else {
            return
        }
        
        let newEnemies = waveSpawner.spawnWave()
        enemies.append(contentsOf: newEnemies)
        delegate?.setupUI(forEnemies: newEnemies)
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
