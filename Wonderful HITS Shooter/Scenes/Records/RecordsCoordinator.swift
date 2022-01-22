import UIKit

final class RecordsCoordinator: TabCoordinator {
    // MARK: - Public Methods
    override func start() {
        let recordsViewModel = RecordsViewModel(dependencies: dependencies)
        let recordsVC = RecordsViewController(viewModel: recordsViewModel)
        rootNavigationController.setViewControllers([ recordsVC ], animated: true)
    }
}
