//
//  SignUpViewController.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 12.01.2022.
//

import UIKit
import TPKeyboardAvoiding

class SignUpViewController: BaseViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let nicknameTextField = CustomTextField()
    private let authView = AuthView()
    private let confirmPasswordTextField = CustomTextField()
    private let signUpButton = CustomButton()
    private let viewModel: SignUpViewModel
    
    // MARK: - Actions
    @objc private func signUp() {
        viewModel.signUp()
    }
    
    // MARK: - Init
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(nicknameTextField)
        scrollView.addSubview(authView)
        scrollView.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)
        
        setupTitleLabel()
        setupScrollView()
        setupNicknameTextField()
        setupAuthView()
        setupConfirmPasswordTextField()
        setupSignUpButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.standart)
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
        }
        
        titleLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.medium))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.text = Strings.registration
    }
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.medium)
            make.bottom.equalTo(signUpButton.snp.top).offset(Dimensions.standart)
        }
    }
    
    private func setupNicknameTextField() {
        nicknameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalToSuperview()
        }
        
        nicknameTextField.placeholder = Strings.enterNickname
    }
    
    private func setupAuthView() {
        authView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(scrollView)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(Dimensions.standart)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
    
    private func setupConfirmPasswordTextField() {
        confirmPasswordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(authView.snp.bottom).offset(Dimensions.standart)
        }
        
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.placeholder = Strings.confirmPassword
    }
    
    private func setupSignUpButton() {
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.medium)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        signUpButton.configure(with: Strings.register)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    private func bindToViewModel() {
        viewModel.didReceiveError = { [weak self] error in
            self?.showError(error)
        }
        
        viewModel.didConfigureAuthView = { [weak self] authViewModel in
            self?.authView.configure(with: authViewModel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SignUpViewModelDelegate
extension SignUpViewController: SignUpViewModelDelegate {
    func getNickname() -> String? {
        return nicknameTextField.text
    }
    
    func getConfirmedPassword() -> String? {
        return confirmPasswordTextField.text
    }
}

// MARK: - Strings
private extension Strings {
    static let registration = "Регистрация"
    static let enterNickname = "Введите никнейм"
    static let confirmPassword = "Повторите пароль"
}
