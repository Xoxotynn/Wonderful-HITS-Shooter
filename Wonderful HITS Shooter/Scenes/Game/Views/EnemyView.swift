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
