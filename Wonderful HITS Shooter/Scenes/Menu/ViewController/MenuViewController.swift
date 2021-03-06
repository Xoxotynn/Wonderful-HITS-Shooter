import UIKit

class MenuViewController: BaseViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
    private let buttonsContainerView = UIView()
    private let playButton = CustomButton()
    private let settingsButton = CustomButton()
    private let exitButton = CustomButton()
    private let logOutButton = CustomButton()
    private let viewModel: MenuViewModel
    
    // MARK: - Actions
    @objc private func showLevelsScene() {
        viewModel.showTabBarScene()
//        viewModel.showVideo()
    }
    
    @objc private func showSettings() {
        viewModel.showSetting()
    }
    
    @objc private func exit() {
        viewModel.exit()
    }
    
    @objc private func logOut() {
        viewModel.logOut()
    }
    
    // MARK: - Init
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(titleLabel)
        view.addSubview(buttonsContainerView)
        buttonsContainerView.addSubview(playButton)
        buttonsContainerView.addSubview(settingsButton)
        buttonsContainerView.addSubview(exitButton)
        view.addSubview(logOutButton)
        
        setupTitleLabel()
        setupButtonsContainerView()
        setupPlayButton()
        setupSettingsButton()
        setupQuitButton()
        setupLogOutButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.medium)
        }
        
        titleLabel.text = Strings.menu
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSAttributedString(
            string: Strings.menu,
            attributes: StringAttributes.getStringAttributes(fontSize: Dimensions.menuButtonHeight))
    }
    
    private func setupButtonsContainerView() {
        buttonsContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func setupPlayButton() {
        playButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalToSuperview()
            make.height.equalTo(Dimensions.menuButtonHeight)
        }
        
        playButton.configure(withTitle: Strings.play, withFontSize: Dimensions.large)
        playButton.addTarget(self, action: #selector(showLevelsScene), for: .touchUpInside)
    }
    
    private func setupSettingsButton() {
        settingsButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(playButton.snp.bottom).offset(Dimensions.large)
            make.height.equalTo(Dimensions.menuButtonHeight)
        }
        
        settingsButton.configure(withTitle: Strings.settings, withFontSize: Dimensions.large)
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
    }
    
    private func setupQuitButton() {
        exitButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(settingsButton.snp.bottom).offset(Dimensions.large)
            make.bottom.equalToSuperview()
            make.height.equalTo(Dimensions.menuButtonHeight)
        }
        
        exitButton.configure(withTitle: Strings.quit, withFontSize: Dimensions.large)
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
    }
    
    private func setupLogOutButton() {
        logOutButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Dimensions.standart)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.standart)
            make.size.equalTo(Dimensions.standartHeight)
        }
        
        logOutButton.setImage(UIImage(named: Images.logOut), for: .normal)
        logOutButton.configure()
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Strings
private extension Strings {
    static let menu = "????????"
    static let play = "????????????"
    static let settings = "??????????????????"
    static let quit = "??????????"
}

// MARK: - Dimensions
private extension Dimensions {
    static let menuButtonHeight = 65
}
