import Foundation

// MARK: - OnboardingViewModelDelegate Declaration
protocol OnboardingViewModelDelegate: AnyObject {
    func showSignUpScene()
    func showSignInScene()
}

final class OnboardingViewModel {
    
    // MARK: - Properties
    weak var delegate: OnboardingViewModelDelegate?
    
    // MARK: - Public Methods
    func showSignInScene() {
        delegate?.showSignInScene()
    }
    
    func showSignUpScene() {
        delegate?.showSignUpScene()
    }
}
