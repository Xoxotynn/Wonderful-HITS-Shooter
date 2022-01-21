import UIKit

final class BulletView: UIImageView {
    
    private var viewModel: BulletViewModel?
    
    func configure(with viewModel: BulletViewModel) {
        self.viewModel = viewModel
        setupView(withViewModel: viewModel)
        Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(sendCurrentFrame),
                             userInfo: nil,
                             repeats: true)
        
        viewModel.didRemoveBullet = { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    private func setupView(withViewModel viewModel: BulletViewModel) {
        frame = viewModel.frame
        layer.cornerRadius = frame.height / 2
        backgroundColor = .systemPink
        layer.masksToBounds = true
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .curveLinear) {
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 1) {
                    self.frame.origin = viewModel.endPoint
                }
            }
    }
    
    @objc private func sendCurrentFrame() {
        viewModel?.sendCurrentFrame(layer.presentation()?.frame ?? frame)
    }
}
