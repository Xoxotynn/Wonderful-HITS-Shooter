import Foundation
import UIKit

final class AuthCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
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
    }
}

// MARK: - OnboardingViewModelDelegate
extension AuthCoordinator: OnboardingViewModelDelegate {
    func showSignInScene() {
        let signInViewModel = SignInViewModel(dependencies: dependencies)
        let signInVC = SignInViewController(viewModel: signInViewModel)
        rootNavigationController.pushViewController(signInVC, animated: true)
    }
    
    func showSignUpScene() {
        let signUpViewModel = SignUpViewModel(dependencies: dependencies)
        let signUpVC = SignUpViewController(viewModel: signUpViewModel)
        rootNavigationController.pushViewController(signUpVC, animated: true)
    }
}
