//
//  AppCoordinator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 20.12.2021.
//

import Foundation
import UIKit
import Firebase

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private let window: UIWindow?
    private let dependencies: Dependencies
    
    init(window: UIWindow?) {
        self.window = window
        dependencies = Dependencies(networkManager: NetworkManager())
        rootNavigationController = UINavigationController(rootViewController: UIViewController())
        childCoordinators = []
    }
    
    func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        var startCoordinator: Coordinator = AuthCoordinator(rootNavigationController: rootNavigationController, dependencies: dependencies)
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                startCoordinator = GameCoordinator(rootViewController: self.rootNavigationController, dependencies: self.dependencies)
            }
        }
        
        childCoordinators.append(startCoordinator)
        startCoordinator.start()
    }
}
