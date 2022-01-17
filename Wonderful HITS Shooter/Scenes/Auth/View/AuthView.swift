import UIKit
import SnapKit

final class AuthView: UIView {
    // MARK: - Properties
    private let emailTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    private var viewModel: AuthViewModel?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: AuthViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        
        setupEmailTextField()
        setupPasswordTextField()
    }
    
    private func setupEmailTextField() {
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalToSuperview()
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.placeholder = Strings.enterEmail
    }
    
    private func setupPasswordTextField() {
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(emailTextField.snp.bottom).offset(Dimensions.standart)
            make.bottom.equalToSuperview()
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = Strings.enterPassword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - AuthViewModelDelegate
extension AuthView: AuthViewModelDelegate {
    func getEmail() -> String? {
        return emailTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
}

// MARK: - Strings
private extension Strings {
    static let enterEmail = "Введите E-mail"
    static let enterPassword = "Введите пароль"
}

