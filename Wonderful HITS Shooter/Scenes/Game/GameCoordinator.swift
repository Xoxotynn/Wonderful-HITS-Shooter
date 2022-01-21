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
        viewModel.delegate = self
        rootNavigationController.pushViewController(viewController, animated: true)
        viewController.tabBarController?.tabBar.isHidden = true
        viewController.tabBarController?.navigationController?.navigationBar.isHidden = true
        dependencies.audioManager.play(audio: Strings.levelTheme, needToLoop: true)
    }
}

extension GameCoordinator: GameViewModelDelegate {
    func showGameOverScene() {
        let coordinator = GameOverCoordinator(
            rootViewController: rootNavigationController,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

private extension Strings {
    static let levelTheme = "levelTheme"
}
