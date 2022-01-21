import UIKit

class TabCoordinator: Coordinator {
    // MARK: - Properties
    weak var delegate: TabBarItemDelegate?
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies, rootNavigationController: UINavigationController) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        rootNavigationController.isNavigationBarHidden = true
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() { }
}

// MARK: - TabBarItemViewModelDelegate
extension TabCoordinator: TabBarItemViewModelDelegate {
    func configureTitleView(withPoints points: Int) {
        delegate?.configureTitleView(withPoints: points)
    }
    
    func configureTitleView(withMoney money: Int) {
        delegate?.configureTitleView(withMoney: money)
    }
}
