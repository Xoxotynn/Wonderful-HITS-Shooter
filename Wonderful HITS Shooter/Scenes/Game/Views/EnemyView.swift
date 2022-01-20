import UIKit

final class EnemyView: UIImageView {
    
    private var viewModel: EnemyViewModel?
    
    func configure(with viewModel: EnemyViewModel) {
        self.viewModel = viewModel
        Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(sendCurrentFrame),
                             userInfo: nil,
                             repeats: true)
        
        backgroundColor = .black
        frame = viewModel.frame
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: []) {
            viewModel.route.forEach { point in
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 1) {
                    self.frame.origin = point
                }
            }
        }
    }
    
    @objc private func sendCurrentFrame() {
        viewModel?.sendCurrentFrame(layer.presentation()?.frame ?? frame)
    }
}
