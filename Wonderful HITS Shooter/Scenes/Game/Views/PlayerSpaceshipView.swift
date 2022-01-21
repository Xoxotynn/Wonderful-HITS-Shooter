import UIKit

private extension Images {
    static let spaceship = "spaceship"
}

final class PlayerSpaceshipView: UIImageView {
    
    private var viewModel: PlayerSpaceshipViewModel?
    
    func configure(with viewModel: PlayerSpaceshipViewModel) {
        self.viewModel = viewModel
        Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(sendCurrentFrame),
                             userInfo: nil,
                             repeats: true)
        
        frame = viewModel.frame
        image = UIImage(named: Images.spaceship)
    }
    
    @objc private func sendCurrentFrame() {
        viewModel?.sendCurrentFrame(frame)
    }
}
