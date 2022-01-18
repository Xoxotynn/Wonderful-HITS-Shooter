//
//  StartCoordinator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 20.12.2021.
//

import Foundation
import UIKit

final class GameCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private let dependencies: Dependencies
    
    init(rootViewController: UINavigationController, dependencies: Dependencies) {
        self.dependencies = dependencies
        rootNavigationController = rootViewController
        childCoordinators = []
    }
    
    func start() {
        rootNavigationController.navigationBar.isHidden = true
        let viewController = GameViewController()
        rootNavigationController.setViewControllers([viewController], animated: true)
        
        dependencies.audioManager.play(audio: "levelTheme", needToLoop: true)
    }
    
    func showNextScene() {
        let coord = GameCoordinator(rootViewController: rootNavigationController, dependencies: dependencies)
        childCoordinators.append(coord)
    }
}
