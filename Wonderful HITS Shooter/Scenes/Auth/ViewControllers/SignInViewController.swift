//
//  SignInViewController.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 12.01.2022.
//

import UIKit
import TPKeyboardAvoiding

class SignInViewController: BaseViewController {

    // MARK: - Properties
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let titleLabel = UILabel()
    private let authView = AuthView()
    private let signInButton = CustomButton()
    private let viewModel: SignInViewModel
    
    // MARK: - Actions
    @objc private func signIn() {
        viewModel.signIn()
    }
    
    // MARK: - Init
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        scrollView.addSubview(authView)
        view.addSubview(signInButton)

        setupTitleLabel()
        setupScrollView()
        setupAuthView()
        setupSignInButton()
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
        titleLabel.text = Strings.authorization
    }
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.medium)
            make.bottom.equalTo(signInButton.snp.top).offset(Dimensions.standart)
        }
    }
    
    private func setupAuthView() {
        authView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(scrollView)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
    
    private func setupSignInButton() {
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.medium)
            make.height.equalTo(Dimensions.standartHeight)
        }

        signInButton.configure(withTitle: Strings.signIn)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
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

// MARK: - Strings
private extension Strings {
    static let authorization = "Авторизация"
}
