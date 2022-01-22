//
//  StringAttributes.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 21.01.2022.
//

import Foundation
import UIKit

enum StringAttributes {
    static func getStringAttributes(color: UIColor = UIColor.white,
                                    strokeColor: UIColor = UIColor.black,
                                    strokeWidth: CGFloat = -4.0,
                                    fontSize: Int) -> [NSAttributedString.Key : Any] {
        return [
            .strokeColor : strokeColor,
            .foregroundColor : color,
            .strokeWidth : strokeWidth,
            .font : UIFont.pressStart2p(.regular,
                                        size: CGFloat(fontSize))
        ]
    }
    
    static let whiteOutlined: [NSAttributedString.Key : Any] = [
        .strokeColor : UIColor.black,
        .foregroundColor : UIColor.white,
        .strokeWidth : -4.0,
        .font : UIFont.pressStart2p(.regular,
                                    size: CGFloat(Dimensions.standart))
    ]
}
