import UIKit

final class RecordsCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    weak var delegate: TabBarItemDelegate?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies, rootNavigationController: UINavigationController) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        let recordsViewModel = RecordsViewModel(dependencies: dependencies)
        let recordsVC = RecordsViewController(viewModel: recordsViewModel)
        rootNavigationController.setViewControllers([ recordsVC ], animated: true)
    }
}
