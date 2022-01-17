import Foundation
import UIKit
import Firebase

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private let window: UIWindow?
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(window: UIWindow?) {
        self.window = window
        dependencies = Dependencies(networkManager: NetworkManager(),
                                    userDefaultsManager: UserDefaultsManager(),
                                    audioManager: AudioManager())
        rootNavigationController = UINavigationController(rootViewController: UIViewController())
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        var startCoordinator: Coordinator
        
        #warning("Permanent SignOut")
        dependencies.networkManager.signOut()
        setMusicVolume()
        
        if Auth.auth().currentUser != nil {
            let gameCoordinator = GameCoordinator(rootViewController: rootNavigationController,
                                                  dependencies: dependencies)
            startCoordinator = gameCoordinator
        } else {
            let authCoordinator = AuthCoordinator(rootNavigationController: rootNavigationController,
                                                  dependencies: dependencies)
            authCoordinator.delegate = self
            startCoordinator = authCoordinator
        }
        
        childCoordinators.append(startCoordinator)
        startCoordinator.start()
    }
    
    // MARK: - Private Methods
    private func setMusicVolume() {
        let musicVolume = dependencies.userDefaultsManager.getMusicVolume() ?? 1.0
        let soundEffectsVolume = dependencies.userDefaultsManager.getSoundEffectsVolume() ?? 1.0
        dependencies.audioManager.setMusicVolume(toValue: musicVolume)
        dependencies.audioManager.setSoundEffectsVolume(toValue: soundEffectsVolume)
    }
}

// MARK: - AuthCoordinatorDelegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func removeAuthCoordinatorAndStartGame(authCoordinator: AuthCoordinator) {
        removeAllChildCoordinatorsWithType(type(of: authCoordinator))
        let gameCoordinator = GameCoordinator(rootViewController: rootNavigationController,
                                              dependencies: dependencies)
        childCoordinators.append(gameCoordinator)
        gameCoordinator.start()
    }
}
