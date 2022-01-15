//
//  Fonts.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 15.01.2022.
//

import Foundation
import UIKit

extension UIFont {
    public enum FontType: String {
            case semibold = "-SemiBold"
            case regular = "-Regular"
            case medium = "-Medium"
            case bold = "-Bold"
        }

    static func pressStart2p(_ type: FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "PressStart2P\(type.rawValue)", size: size) ??
               UIFont.systemFont(ofSize: size)
    }
    
    static func kellySlab(_ type: FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "KellySlab\(type.rawValue)", size: size) ??
               UIFont.systemFont(ofSize: size)
    }
}
