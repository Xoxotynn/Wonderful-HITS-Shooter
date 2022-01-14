import Foundation

// MARK: - SignUpViewModelDelegate Declaration
protocol SignUpViewModelDelegate: AnyObject {
    func getNickname() -> String?
    func getConfirmedPassword() -> String?
}

final class SignUpViewModel {
    
    // MARK: - Priperties
    var didReceiveError: ((Error) -> Void)?
    var didConfigureAuthView: ((AuthViewModel) -> Void)?
    
    weak var delegate: SignUpViewModelDelegate?
    
    private let dependencies: Dependencies
    private let authViewModel: AuthViewModel
    private var nickname: String?
    private var confirmedPassword: String?
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        authViewModel = AuthViewModel()
    }
    
    // MARK: - Public Methods
    func start() {
        didConfigureAuthView?(authViewModel)
    }
    
    func signUp() {
        
        authViewModel.updateAuthInformation()
        updateAuthInformation()
        
        let nickname = nickname ?? ""
        let email = authViewModel.email ?? ""
        let password = authViewModel.password ?? ""
        let confirmedPassword = confirmedPassword ?? ""
        
        if let error = Validator.validateSignUpTextFields(nickname: nickname,
                                                          email: email,
                                                          password: password,
                                                          confirmedPassword: confirmedPassword) {
            didReceiveError?(error)
        } else {
            dependencies.networkManager.register(nickname: nickname,
                                                 email: email,
                                                 password: password) { [weak self] in
                print("Success")
            } onError: { [weak self] error in
                self?.didReceiveError?(error)
            }

        }
    }
    
    // MARK: - Private Methods
    private func updateAuthInformation() {
        nickname = delegate?.getNickname()
        confirmedPassword = delegate?.getConfirmedPassword()
    }
}
