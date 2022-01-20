//
//  CustomButton.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 16.01.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = 2
    }
    
    // MARK: - Public Methods
    func configure(withTitle title: String? = nil,
                   withFontSize size: Int = Dimensions.standart) {
        
        setTitle(title ?? "", for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.pressStart2p(.regular, size: CGFloat(size))
        tintColor = .black
        backgroundColor = .systemPink
        
        if imageView?.image != nil, let title = title, !title.isEmpty {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        } else if imageView?.image != nil {
            titleEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        }
    }
}
