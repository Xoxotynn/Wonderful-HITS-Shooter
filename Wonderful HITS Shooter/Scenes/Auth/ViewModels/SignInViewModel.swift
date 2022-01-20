import Foundation

final class SignInViewModel {
    
    // MARK: - Properties
    var didConfigureAuthView: ((AuthViewModel) -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    weak var authDelegate: AuthorizationViewModelDelegate?
    
    private let authViewModel: AuthViewModel
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        authViewModel = AuthViewModel()
    }
    
    // MARK: - Public Methods
    func start() {
        didConfigureAuthView?(authViewModel)
    }
    
    func signIn() {
        authViewModel.updateAuthInformation()
        
        let email = authViewModel.email ?? ""
        let password = authViewModel.password ?? ""
        
        if let error = Validator.validateSignInTextFields(email: email, password: password) {
            didReceiveError?(error)
        } else {
            dependencies.networkManager.auth(email: email,
                                             password: password) { [weak self] in
                self?.authDelegate?.showMenuScene()
            } onError: { [weak self] error in
                self?.didReceiveError?(error)
            }
        }
    }
}
