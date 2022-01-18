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
        let viewModel = GameViewModel(level: FirstLevel())
        let viewController = GameViewController(viewModel: viewModel)
        rootNavigationController.setViewControllers([viewController], animated: true)
    }
    
    func showNextScene() {
        let coord = GameCoordinator(rootViewController: rootNavigationController, dependencies: dependencies)
        childCoordinators.append(coord)
    }
}
