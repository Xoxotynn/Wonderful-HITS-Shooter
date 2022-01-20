import Foundation
import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func removeAuthCoordinatorAndStartGame(authCoordinator: AuthCoordinator)
}

final class AuthCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    weak var delegate: AuthCoordinatorDelegate?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(rootNavigationController: UINavigationController, dependencies: Dependencies) {
        self.rootNavigationController = rootNavigationController
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        let onboardingViewModel = OnboardingViewModel()
        onboardingViewModel.delegate = self
        let onboardingVC = OnboardingViewController(viewModel: onboardingViewModel)
        rootNavigationController.setViewControllers([onboardingVC], animated: true)
        
        dependencies.audioManager.play(audio: "mainTheme", needToLoop: true)
    }
}

// MARK: - OnboardingViewModelDelegate
extension AuthCoordinator: OnboardingViewModelDelegate {
    func showSignInScene() {
        let signInViewModel = SignInViewModel(dependencies: dependencies)
        signInViewModel.authDelegate = self
        let signInVC = SignInViewController(viewModel: signInViewModel)
        rootNavigationController.pushViewController(signInVC, animated: true)
    }
    
    func showSignUpScene() {
        let signUpViewModel = SignUpViewModel(dependencies: dependencies)
        signUpViewModel.authDelegate = self
        let signUpVC = SignUpViewController(viewModel: signUpViewModel)
        rootNavigationController.pushViewController(signUpVC, animated: true)
    }
}

extension AuthCoordinator: AuthorizationViewModelDelegate {
    func showGameScene() {
//        let settingsViewModel = SettingsViewModel(dependencies: dependencies)
//        let settingsVC = SettingsViewController(viewModel: settingsViewModel)
//        rootNavigationController.pushViewController(settingsVC, animated: true)
        delegate?.removeAuthCoordinatorAndStartGame(authCoordinator: self)
    }
}
