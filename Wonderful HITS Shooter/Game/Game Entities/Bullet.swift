import UIKit

protocol BulletDelegate: AnyObject {
    func isCollidingWithEnemy(bullet: Bullet) -> Enemy?
    func didDie(bullet: Bullet)
}

final class Bullet: Entity {
    
    let endPoint: CGPoint
    
    weak var bulletDelegate: BulletDelegate?
    
    private var collisionTimer: Timer?
    
    init(position: CGPoint, endPoint: CGPoint) {
        let screenSize = UIScreen.main.bounds.size
        let gameFieldRatio = screenSize.width / screenSize.height
        self.endPoint = endPoint
        super.init(hp: 50,
                   frame: CGRect(
                    origin: position,
                    size: CGSize(width: 0.05,
                                 height: 0.05 * gameFieldRatio)))
        
        collisionTimer = Timer.scheduledTimer(
            timeInterval: 0.05,
            target: self,
            selector: #selector(checkCollision),
            userInfo: nil,
            repeats: true)
    }
    
    override func die() {
        collisionTimer?.invalidate()
        bulletDelegate?.didDie(bullet: self)
    }
    
    @objc private func checkCollision() {
        guard let collidingEnemy = bulletDelegate?.isCollidingWithEnemy(
            bullet: self) else {
                return
        }
        
        die()
        collidingEnemy.takeDamage(withAmount: hp)
    }
}
