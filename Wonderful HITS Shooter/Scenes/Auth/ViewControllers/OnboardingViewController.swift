import UIKit

class OnboardingViewController: BaseViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
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
        view.addSubview(titleLabel)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        setupTitleLabel()
        setupSignInButton()
        setupSignUpButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.medium)
        }
        
        titleLabel.font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.large))
        titleLabel.text = Strings.gameName
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setupSignInButton() {
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.bottom.equalTo(signUpButton.snp.top).offset(-Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        signInButton.configure(with: Strings.signIn)
        signInButton.addTarget(self, action: #selector(showSignInScene), for: .touchUpInside)
    }
    
    private func setupSignUpButton() {
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        signUpButton.configure(with: Strings.register)
        signUpButton.addTarget(self, action: #selector(showSignUpScene), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Strings {
    static let gameName = "Wonderful HITS Shooter"
}
