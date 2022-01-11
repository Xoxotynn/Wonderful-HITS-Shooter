//
//  Group.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 10.01.2022.
//

import UIKit

final class EnemyGroup {
    
    private var enemies: [Enemy]
    private var route: [CGPoint]
    
    private init(waveSpawner: WaveSpawner,
                 routeCreator: RouteCreator,
                 positionCreator: PositionCreator) {
        enemies = waveSpawner.spawnWave()
        route = routeCreator.createRoute()
        setupPosition(positionCreator: positionCreator)
    }
    
    private func setupPosition(positionCreator: PositionCreator) {
        var positions = positionCreator
            .setupInitialPosition(enemiesCount: enemies.count)
        
        enemies.forEach { enemy in
            guard let position = positions.popLast() else { return }
            enemy.position = position
        }
    }
}

extension EnemyGroup {
//    static let group1 = EnemyGroup(waveSpawner: WaveSpawner(), routeCreator: RouteCreator(), positionCreator: PositionsCreator())
}
