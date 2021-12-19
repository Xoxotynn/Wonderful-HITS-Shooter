//
//  Coordinator.swift
//  Wonderful HITS Shooter
//
//  Created by Эдуард Логинов on 20.12.2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var rootNavgationController: UINavigationController { get set }
    
    func start()
}
