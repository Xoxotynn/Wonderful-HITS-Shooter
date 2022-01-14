import UIKit

final class CustomTextField: UITextField {
    
    // MARK: - Properties
    var textPadding = UIEdgeInsets(
            top: 18,
            left: 24,
            bottom: 18,
            right: 24
        )
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        self.configure()
    }
    
    // MARK: - Public Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    // MARK: - Private Methods
    private func configure() {
        self.contentVerticalAlignment = .top
        self.textColor = .black
        self.borderStyle = .none
        self.backgroundColor = Colors.grayTextField
        self.layer.cornerRadius = 28
        self.font = UIFont.systemFont(ofSize: 16)
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: Colors.gray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
