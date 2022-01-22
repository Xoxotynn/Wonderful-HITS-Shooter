import UIKit

class VolumeSlider: UISlider {
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        tintColor = .white
        let largeConfig = UIImage.SymbolConfiguration(pointSize: CGFloat(Dimensions.medium), weight: .bold, scale: .large)
        minimumValueImage = UIImage.init(systemName: Images.minValueSpeaker, withConfiguration: largeConfig)
        maximumValueImage = UIImage.init(systemName: Images.maxValueSpeaker, withConfiguration: largeConfig)
    
        let thumbImage = UIImage(named: Images.thumbImage) ?? UIImage()
        let rotatedThumbImage = UIImage(cgImage: thumbImage.cgImage!, scale: 10.0, orientation: .right)
        setThumbImage(rotatedThumbImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Images
private extension Images {
    static let thumbImage = "spaceship"
    static let minValueSpeaker = "speaker"
    static let maxValueSpeaker = "speaker.wave.2"
}
