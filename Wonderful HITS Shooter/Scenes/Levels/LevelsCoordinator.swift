import UIKit

final class LevelsCoordinator: TabCoordinator {
    // MARK: - Public Methods
    override func start() {
        let levelsViewModel = LevelsViewModel(dependencies: dependencies)
        levelsViewModel.delegate = self
        levelsViewModel.levelsDelegate = self
        let levelsVC = LevelsViewController(viewModel: levelsViewModel)
        rootNavigationController.pushViewController(levelsVC, animated: true)
    }
}

extension LevelsCoordinator: LevelsViewModelDelegate {
    func startFirstLevel() {
        let gameCoordinator = GameCoordinator(rootViewController: rootNavigationController, dependencies: dependencies)
        childCoordinators.append(gameCoordinator)
        gameCoordinator.start()
    }
}
