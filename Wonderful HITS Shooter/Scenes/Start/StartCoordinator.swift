//
//  StartCoordinator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 20.12.2021.
//

import Foundation
import UIKit

class StartCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var rootNavgationController: UINavigationController
    
    private let dependencies: Dependencies
    
    init(rootViewController: UINavigationController, dependencies: Dependencies) {
        self.dependencies = dependencies
        rootNavgationController = rootViewController
        childCoordinators = []
    }
    
    func start() {
        let viewController = StartViewController()
        rootNavgationController.setViewControllers([viewController], animated: true)
    }
    
    func showNextScene() {
        let coord = StartCoordinator(rootViewController: rootNavgationController, dependencies: dependencies)
        childCoordinators.append(coord)
    }
}
