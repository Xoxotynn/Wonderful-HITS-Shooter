import UIKit

protocol BulletWeaponDelegate: AnyObject {
    func bulletPosition(bulletWeapon: BulletWeapon) -> CGPoint
    func bulletWeapon(didShootBullet bullet: Bullet)
}

final class BulletWeapon: Weapon {
    
    /// Bullets per second
    var shootRate: CGFloat
    /// How much of the screen bullet will move per second
    var bulletSpeed: CGFloat
    /// Count of bullets per shot
    var bulletCount: Int
    
    weak var delegate: BulletWeaponDelegate?
    
    init(shootRate: CGFloat,
         bulletSpeed: CGFloat,
         bulletCount: Int) {
        self.shootRate = shootRate
        self.bulletSpeed = bulletSpeed
        self.bulletCount = bulletCount
        
        Timer.scheduledTimer(timeInterval: 1 / shootRate,
                             target: self,
                             selector: #selector(attack),
                             userInfo: nil,
                             repeats: true)
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
