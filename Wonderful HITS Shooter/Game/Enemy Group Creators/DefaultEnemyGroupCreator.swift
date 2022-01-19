//
//  DefaultEnemyGroupCreator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 18.01.2022.
//

import Foundation

final class DefaultEnemyGroupCreator: EnemyGroupCreator {
    
    func createEnemies() -> [Enemy] {
        var enemies: [Enemy] = []
        for _ in 0..<10 {
            enemies.append(Enemy(hp: 100, weapon: nil))
        }
        
        return enemies
    }
}
