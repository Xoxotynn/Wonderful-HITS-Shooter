import Foundation

final class SignInViewModel {
    
    // MARK: - Properties
    var didConfigureAuthView: ((AuthViewModel) -> Void)?
    var didReceiveError: ((Error) -> Void)?
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
                                             password: password) {
                print("Success")
            } onError: { [weak self] error in
                self?.didReceiveError?(error)
            }

        }
    }
}
