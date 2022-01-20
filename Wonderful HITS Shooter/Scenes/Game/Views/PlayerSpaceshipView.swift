import UIKit

final class PlayerSpaceshipView: UIImageView {
    
    private var viewModel: PlayerSpaceshipViewModel?
    
    func configure(with viewModel: PlayerSpaceshipViewModel) {
        self.viewModel = viewModel
        Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(sendCurrentFrame),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc private func sendCurrentFrame() {
        viewModel?.sendCurrentFrame(frame)
    }
}
