//
//  Level.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 26.12.2021.
//

import Foundation

class Level {
    
    var player: Player?
    
    var waves: [Int] = []
    
    func start() {
        player = Player()
        player?.delegate = self
    }
}

extension Level: PlayerDelegate {
    func gameOver() {
        
    }
}
