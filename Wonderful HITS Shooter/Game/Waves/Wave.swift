//
//  Wave.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 27.12.2021.
//

import Foundation

final class Wave {
    
    private let waveSpawner: WaveSpawner
    private let routeCreator: RouteCreator
    
    init(waveSpawner: WaveSpawner, routeCreator: RouteCreator) {
        self.waveSpawner = waveSpawner
        self.routeCreator = routeCreator
    }
    
    func createWave() -> [Enemy] {
        return []
    }
}
