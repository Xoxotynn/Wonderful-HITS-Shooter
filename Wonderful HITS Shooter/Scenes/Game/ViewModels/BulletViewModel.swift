import UIKit

protocol BulletViewModelDelegate: AnyObject {
    func bulletView(bulletViewModel: BulletViewModel,
                    didChangeFrameWith frame: CGRect)
}

final class BulletViewModel {
    
    weak var delegate: BulletViewModelDelegate?
    var frame: CGRect
    var endPoint: CGPoint
    
    private let bullet: Bullet
    
    init(bullet: Bullet, frame: CGRect, endPoint: CGPoint) {
        self.bullet = bullet
        self.frame = frame
        self.endPoint = endPoint
    }
    
    func sendCurrentFrame(_ frame: CGRect) {
        delegate?.bulletView(bulletViewModel: self, didChangeFrameWith: frame)
    }
    
    func changeBulletFrame(with frame: CGRect) {
        bullet.frame = frame
    }
}
