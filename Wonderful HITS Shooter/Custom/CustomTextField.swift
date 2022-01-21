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
        configure()
    }
    
    // MARK: - Public Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = 2
    }
    
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
        contentVerticalAlignment = .top
        textColor = .black
        borderStyle = .none
        backgroundColor = Colors.grayTextField
        font = UIFont.pressStart2p(.regular, size: CGFloat(Dimensions.standart))
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                        attributes: [
                                                            NSAttributedString.Key.foregroundColor: Colors.gray
                                                        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
