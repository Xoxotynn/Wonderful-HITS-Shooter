//
//  AppCoordinator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 20.12.2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var rootNavgationController: UINavigationController
    
    private let window: UIWindow?
    private let dependencies: Dependencies
    
    init(window: UIWindow?) {
        self.window = window
        dependencies = Dependencies(dataTest: 1)
        rootNavgationController = UINavigationController(rootViewController: UIViewController())
        childCoordinators = []
    }
    
    func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavgationController
        window.makeKeyAndVisible()
        
        let startCoordinator = StartCoordinator(rootViewController: rootNavgationController,
                                                dependencies: dependencies)
        childCoordinators.append(startCoordinator)
        startCoordinator.start()
    }
}
