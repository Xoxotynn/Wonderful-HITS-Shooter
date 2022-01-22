import UIKit

final class UpgradingCoordinator: TabCoordinator {
    override func start() {
        let upgradingVC = UpgradingViewController()
        rootNavigationController.setViewControllers([upgradingVC], animated: true)
    }
}
