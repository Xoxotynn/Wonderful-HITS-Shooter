protocol SettingsCoordinatorDelegate: AnyObject {
    func removeSettingsCoordinatorAndShowAuthScene(settingsCoordinator: SettingsCoordinator)
}

final class SettingsCoordinator: TabCoordinator {
    weak var settingsCoordinatorDelegate: SettingsCoordinatorDelegate?
    override func start() {
        let settingsViewModel = SettingsViewModel(dependencies: dependencies)
        settingsViewModel.delegate = self
        let settingsVC = SettingsViewController(viewModel: settingsViewModel)
        rootNavigationController.setViewControllers([ settingsVC ], animated: true)
    }
}

extension SettingsCoordinator: SettingsViewModelDelegate {
    func showAuthScene() {
        settingsCoordinatorDelegate?.removeSettingsCoordinatorAndShowAuthScene(settingsCoordinator: self)
    }
}
