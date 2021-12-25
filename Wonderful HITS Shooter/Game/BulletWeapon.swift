import Foundation

protocol BulletWeaponDelegate: AnyObject {
    func shoot()
}

class BulletWeapon: Weapon {
    
    /// Bullets per second
    var shootRate: Float = 1
    /// Speed in points per second
    var bulletSpeed: Float = 1
    /// Count of bullets per shot
    var bulletCount: Int = 1
    
    weak var delegate: BulletWeaponDelegate?
    
    override func attack() {
        delegate?.shoot()
    }
}
