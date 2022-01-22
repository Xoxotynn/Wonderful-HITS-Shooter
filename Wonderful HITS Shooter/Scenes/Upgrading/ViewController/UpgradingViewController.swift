import UIKit

final class UpgradingViewController: BaseViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(titleLabel)
        
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = NSAttributedString(
            string: Strings.comingSoon,
            attributes: StringAttributes.getStringAttributes(fontSize: Dimensions.large))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Strings
private extension Strings {
    static let comingSoon = "Coming Soon\n..."
}
