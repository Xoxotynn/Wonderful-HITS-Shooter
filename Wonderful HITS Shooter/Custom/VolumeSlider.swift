//
//  VolumeSlider.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 16.01.2022.
//

import UIKit

class VolumeSlider: UISlider {
    init() {
        super.init(frame: .zero)
        
        tintColor = .black
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: CGFloat(Dimensions.medium), weight: .bold, scale: .large)
        minimumValueImage = UIImage.init(systemName: "speaker", withConfiguration: largeConfig)
        maximumValueImage = UIImage.init(systemName: "speaker.wave.2", withConfiguration: largeConfig)
    
        let thumbImage = UIImage(named: Strings.thumbImage) ?? UIImage()
        let rotatedThumbImage = UIImage(cgImage: thumbImage.cgImage!, scale: 10.0, orientation: .right)
        setThumbImage(rotatedThumbImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Strings {
    static let thumbImage = "spaceship"
}
