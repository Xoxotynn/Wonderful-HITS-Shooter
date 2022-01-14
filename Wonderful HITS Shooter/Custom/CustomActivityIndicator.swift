import UIKit

final class CustomActivityIndicator: UIActivityIndicatorView {
    
    // MARK: - Properties
    private let superView: UIView
    
    // MARK: - Init
    init(setOn view: UIView) {
        superView = view
        
        if #available(iOS 13.0, *) {
            super.init(style: .large)
        } else {
            super.init(style: .gray)
        }
        
        center = superView.center
        hidesWhenStopped = true
        color = .lightGray
    }
    
    // MARK: - Public Methods
    func setOrDelete(animating: Bool, blockUserInteraction: Bool) {
        if animating {
            if blockUserInteraction{
                superView.isUserInteractionEnabled = false
            }
            
            superView.addSubview(self)
            startAnimating()
        } else {
            superView.isUserInteractionEnabled = true
            removeFromSuperview()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
