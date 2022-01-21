import UIKit

protocol BulletWeaponDelegate: AnyObject {
    func bulletPosition(bulletWeapon: BulletWeapon) -> CGPoint
    func bulletWeapon(didShootBullet bullet: Bullet)
}

final class BulletWeapon: Weapon {
    
    weak var delegate: BulletWeaponDelegate?
    
    /// Bullets per second
    private(set) var shootRate: CGFloat
    /// How much of the screen bullet will move per second
    private(set) var bulletSpeed: CGFloat
    /// Count of bullets per shot
    private(set) var bulletCount: Int
    
    private var shootTimer: Timer?
    
    init(shootRate: CGFloat,
         bulletSpeed: CGFloat,
         bulletCount: Int) {
        self.shootRate = shootRate
        self.bulletSpeed = bulletSpeed
        self.bulletCount = bulletCount
        
        shootTimer = Timer.scheduledTimer(timeInterval: 1 / shootRate,
                             target: self,
                             selector: #selector(attack),
                             userInfo: nil,
                             repeats: true)
    }
    
    func stopAttacking() {
        shootTimer?.invalidate()
    }
    
    @objc func attack() {
        guard let position = delegate?.bulletPosition(
            bulletWeapon: self) else { return }
        delegate?.bulletWeapon(
            didShootBullet: Bullet(position: position,
                                   endPoint: CGPoint(x: position.x,
                                                     y: position.y - 1)))
    }
}
