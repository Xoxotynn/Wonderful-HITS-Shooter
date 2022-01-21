import UIKit

final class LevelsCoordinator: TabCoordinator {
    // MARK: - Public Methods
    override func start() {
        let levelsViewModel = LevelsViewModel(dependencies: dependencies)
        levelsViewModel.delegate = self
        let levelsVC = LevelsViewController(viewModel: levelsViewModel)
        rootNavigationController.pushViewController(levelsVC, animated: true)
    }
}
