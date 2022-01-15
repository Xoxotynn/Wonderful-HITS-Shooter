//
//  OnboardingViewController.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 12.01.2022.
//

import UIKit

class OnboardingViewController: BaseViewController {

    // MARK: - Properties
    private let signInButton = CustomButton()
    private let signUpButton = CustomButton()
    private let viewModel: OnboardingViewModel
    
    // MARK: - Actions
    @objc private func showSignInScene() {
        viewModel.showSignInScene()
    }
    
    @objc private func showSignUpScene() {
        viewModel.showSignUpScene()
    }
    
    // MARK: - Init
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        setupSignInButton()
        setupSignUpButton()
    }
    
    private func setupSignInButton() {
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(signUpButton.snp.top).offset(-16)
            make.height.equalTo(56)
        }
        
        signInButton.configure(with: Strings.signIn)
        signInButton.addTarget(self, action: #selector(showSignInScene), for: .touchUpInside)
    }
    
    private func setupSignUpButton() {
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(56)
        }
        
        signUpButton.configure(with: Strings.register)
        signUpButton.addTarget(self, action: #selector(showSignUpScene), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

