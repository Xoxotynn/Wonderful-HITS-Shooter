import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private let backgroundImageView = UIImageView()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layer = tabBar.layer
        layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
    }
    
    // MARK: - Private Methods
    private func setup() {
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        
        tabBar.addSubview(backgroundImageView)
        
        setupBackgroundImageView()
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.image = UIImage(named: Images.tabBarBackground)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Images
private extension Images {
    static let tabBarBackground = "tabBarBackground"
}
