import UIKit

final class LevelsCoordinator: TabCoordinator {
    // MARK: - Public Methods
    override func start() {
        let levelsViewModel = LevelsViewModel(dependencies: dependencies)
        levelsViewModel.delegate = self
        levelsViewModel.levelsDelegate = self
        let levelsVC = LevelsViewController(viewModel: levelsViewModel)
        rootNavigationController.setViewControllers([levelsVC], animated: false)
    }
}

extension LevelsCoordinator: LevelsViewModelDelegate {
    func startLevel(withNumber number: LevelNumber) {
        rootNavigationController.tabBarController?.tabBar.isHidden = true
        rootNavigationController.tabBarController?.navigationController?.navigationBar.isHidden = true
        let gameCoordinator = GameCoordinator(
            rootViewController: rootNavigationController,
            dependencies: dependencies,
            levelNumber: number)
        gameCoordinator.delegate = self
        childCoordinators.append(gameCoordinator)
        gameCoordinator.start()
    }
}

extension LevelsCoordinator: GameCoordinatorDelegate {
    func removeGameCoordinator(gameCoordinator: GameCoordinator) {
        rootNavigationController.tabBarController?.tabBar.isHidden = false
        rootNavigationController.tabBarController?.navigationController?.navigationBar.isHidden = false
        removeAllChildCoordinatorsWithType(type(of: gameCoordinator))
        start()
    }
}
