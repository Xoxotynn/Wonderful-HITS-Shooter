import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private let window: UIWindow?
    private let dependencies: Dependencies
    
    init(window: UIWindow?) {
        self.window = window
        dependencies = Dependencies(dataTest: 1)
        rootNavigationController = UINavigationController(rootViewController: UIViewController())
        childCoordinators = []
    }
    
    func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = GameCoordinator(rootViewController: rootNavigationController,
                                                dependencies: dependencies)
        childCoordinators.append(startCoordinator)
        startCoordinator.start()
    }
}
