//
//  Wave.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 27.12.2021.
//

import Foundation

protocol WaveSpawner {
    func spawnWave() -> [Enemy]
}
