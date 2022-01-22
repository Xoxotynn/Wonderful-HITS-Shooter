import Foundation

// MARK: - AuthViewModelDelegate Declaration
protocol AuthViewModelDelegate: AnyObject {
    func getEmail() -> String?
    func getPassword() -> String?
}

final class AuthViewModel {
    // MARK: - Properties
    var email: String?
    var password: String?
    
    weak var delegate: AuthViewModelDelegate?
    
    // MARK: - Public Methods
    func updateAuthInformation() {
        self.email = delegate?.getEmail()
        self.password = delegate?.getPassword()
    }
}
