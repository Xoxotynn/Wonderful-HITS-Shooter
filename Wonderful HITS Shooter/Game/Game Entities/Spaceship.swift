import UIKit

protocol SpaceshipDelegate: AnyObject {
    func spaceship(didShootBullet bullet: Bullet)
    func spaceship(didDie deadSpaceship: Spaceship)
}

final class Spaceship: Entity {

    weak var spaceshipDelegate: SpaceshipDelegate?
    
    private let weapon: BulletWeapon
    
    override init(hp: Int, frame: CGRect) {
        weapon = BulletWeapon(shootRate: 10,
                              bulletSpeed: 0.5,
                              bulletCount: 1)
        super.init(hp: hp, frame: frame)
        weapon.delegate = self
    }
    
    override func die() {
        super.die()
        spaceshipDelegate?.spaceship(didDie: self)
    }
}

extension Spaceship: BulletWeaponDelegate {
    func bulletPosition(bulletWeapon: BulletWeapon) -> CGPoint {
        return CGPoint(x: frame.midX - 0.025, y: frame.minY)
    }
    
    func bulletWeapon(didShootBullet bullet: Bullet) {
        spaceshipDelegate?.spaceship(didShootBullet: bullet)
    }
}
