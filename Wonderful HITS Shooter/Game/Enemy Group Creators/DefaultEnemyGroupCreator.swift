//
//  DefaultEnemyGroupCreator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 18.01.2022.
//

import Foundation

final class DefaultEnemyGroupCreator: EnemyGroupCreator {
    
    private let enemyCount: Int
    
    init(enemyCount: Int) {
        self.enemyCount = enemyCount
    }
    
    func createEnemies() -> [Enemy] {
        var enemies: [Enemy] = []
        for _ in 0..<enemyCount {
            enemies.append(Enemy(hp: 100, weapon: nil))
        }
        
        return enemies
    }
}
