import Foundation
import UIKit

protocol MenuCoordinatorDelegate: AnyObject {
    func removeMenuCoordinatorAndShowAuthScene(menuCoordinator: MenuCoordinator)
}

final class MenuCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    weak var delegate: MenuCoordinatorDelegate?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies, rootNavigationController: UINavigationController) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        let menuViewModel = MenuViewModel()
        menuViewModel.delegate = self
        let menuVC = MenuViewController(viewModel: menuViewModel)
        rootNavigationController.setViewControllers([menuVC], animated: true)
    }
}

// MARK: - MenuViewModelDelegate
extension MenuCoordinator: MenuViewModelDelegate {
    func showLevelsScene() {
        
    }
    
    func showSettings() {
        let settingsViewModel = SettingsViewModel(dependencies: dependencies)
        let settingsVC = SettingsViewController(viewModel: settingsViewModel)
        rootNavigationController.pushViewController(settingsVC, animated: true)
    }
    
    func showAuthScene() {
        dependencies.networkManager.signOut()
        delegate?.removeMenuCoordinatorAndShowAuthScene(menuCoordinator: self)
    }
}