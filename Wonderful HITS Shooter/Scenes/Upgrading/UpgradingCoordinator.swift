import UIKit

final class UpgradingCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    weak var delegate: TabBarItemDelegate?
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies, rootNavigationController: UINavigationController) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        childCoordinators = []
    }
    
    func start() {
        
    }
}
