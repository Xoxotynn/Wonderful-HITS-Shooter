import UIKit

extension UIFont {
    public enum FontType: String {
            case regular = "-Regular"
    }

    static func pressStart2p(_ type: FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "PressStart2P\(type.rawValue)", size: size) ??
               UIFont.systemFont(ofSize: size)
    }
}
