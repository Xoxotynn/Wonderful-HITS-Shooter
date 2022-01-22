import UIKit

private extension Images {
    static let enemySpaceship = "enemySpaceship"
}

final class EnemyView: UIImageView {
    
    private var viewModel: EnemyViewModel?
    
    func configure(with viewModel: EnemyViewModel) {
        self.viewModel = viewModel
        setupView(with: viewModel)
        Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(sendCurrentFrame),
                             userInfo: nil,
                             repeats: true)
        
        viewModel.didRemoveEnemy = { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    private func setupView(with viewModel: EnemyViewModel) {
        image = UIImage(named: Images.enemySpaceship)
        frame = viewModel.frame
        var timeOffset: CGFloat = 0
        UIView.animateKeyframes(withDuration: 5,
                                delay: 0,
                                options: [.autoreverse, .repeat]) {
            viewModel.route.forEach { point in
                UIView.addKeyframe(withRelativeStartTime: timeOffset,
                                   relativeDuration: viewModel.timeDelta) {
                    self.frame.origin = point
                }
                timeOffset += viewModel.timeDelta
            }
        }
    }
    
    @objc private func sendCurrentFrame() {
        viewModel?.sendCurrentFrame(layer.presentation()?.frame ?? frame)
    }
}
