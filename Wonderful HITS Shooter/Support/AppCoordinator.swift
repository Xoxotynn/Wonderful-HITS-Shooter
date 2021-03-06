import UIKit
import Firebase

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private let window: UIWindow?
    private let dependencies: Dependencies
    private let locationManager: LocationManager
    
    // MARK: - Init
    init(window: UIWindow?) {
        self.window = window
        dependencies = Dependencies(networkManager: NetworkManager(),
                                    userDefaultsManager: UserDefaultsManager(),
                                    audioManager: AudioManager(),
                                    videoManager: VideoManager())
        rootNavigationController = UINavigationController()
        childCoordinators = []
        locationManager = LocationManager()
        
        UINavigationBar.appearance().backIndicatorImage = UIImage()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
    }
    
    // MARK: - Public Methods
    func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        
        var startCoordinator: Coordinator
        setMusicVolume()
        
        if let user = Auth.auth().currentUser {
            dependencies.networkManager.setUID(uid: user.uid)
            let menuCoordinator = MenuCoordinator(dependencies: dependencies, rootNavigationController: rootNavigationController)
            menuCoordinator.delegate = self
            startCoordinator = menuCoordinator
        } else {
            let authCoordinator = AuthCoordinator(rootNavigationController: rootNavigationController,
                                                  dependencies: dependencies)
            authCoordinator.delegate = self
            startCoordinator = authCoordinator
        }
        
        childCoordinators.append(startCoordinator)
        startCoordinator.start()
        
        
        dependencies.audioManager.play(audio: Strings.mainTheme, needToLoop: true)
        getUserLocation()
    }
    
    // MARK: - Private Methods
    private func setMusicVolume() {
        let musicVolume = dependencies.userDefaultsManager.getMusicVolume() ?? 1.0
        let soundEffectsVolume = dependencies.userDefaultsManager.getSoundEffectsVolume() ?? 1.0
        dependencies.audioManager.setMusicVolume(toValue: musicVolume)
        dependencies.audioManager.setSoundEffectsVolume(toValue: soundEffectsVolume)
    }
    
    private func getUserLocation() {
        locationManager.didUpdateCountry = { [weak self] in
            self?.dependencies.networkManager.setCountry(countryName: self?.locationManager.country)
        }
        
        locationManager.getLocation()
    }
}

// MARK: - AuthCoordinatorDelegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func removeAuthCoordinatorAndShowMenuScene(authCoordinator: AuthCoordinator) {
        removeAllChildCoordinatorsWithType(type(of: authCoordinator))
        let menuCoordinator = MenuCoordinator(dependencies: dependencies,
                                              rootNavigationController: rootNavigationController)
        menuCoordinator.delegate = self
        childCoordinators.append(menuCoordinator)
        menuCoordinator.start()
    }
}

// MARK: - MenuCoordinatorDelegate
extension AppCoordinator: MenuCoordinatorDelegate {
    func removeMenuCoordinatorAndShowTabBarScene(menuCoordinator: MenuCoordinator) {
        removeAllChildCoordinatorsWithType(type(of: menuCoordinator))
        
        let tabBarCoordinator = TabBarCoordinator(dependencies: dependencies,
                                                  rootNavigationController: rootNavigationController)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    func removeMenuCoordinatorAndShowAuthScene(menuCoordinator: MenuCoordinator) {
        removeAllChildCoordinatorsWithType(type(of: menuCoordinator))
        
        let authCoordinator = AuthCoordinator(rootNavigationController: rootNavigationController, dependencies: dependencies)
        authCoordinator.delegate = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
}

// MARK: - Strings
private extension Strings {
    static let mainTheme = "mainTheme"
}
