//
//  PositionCreator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 27.12.2021.
//

import UIKit

protocol PositionCreator {
    func setupInitialPosition(enemiesCount: Int) -> [CGPoint]
}
