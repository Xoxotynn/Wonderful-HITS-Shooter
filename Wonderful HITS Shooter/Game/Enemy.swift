import Foundation

protocol EnemyDelegate: AnyObject {
    func didDie(enemy: Enemy)
}

final class Enemy: Entity {
    
    var weapon: Weapon?
    weak var enemyDelegate: EnemyDelegate?
    
    private let id: Int
    
    init(id: Int, hp: Int, weapon: Weapon? = nil) {
        self.id = id
        super.init(hp: hp)
        self.weapon = weapon
        configureWeapon()
    }
    
    private func configureWeapon() {
        
    }
    
    override func die() {
        super.die()
        enemyDelegate?.didDie(enemy: self)
    }
}

extension Enemy: Equatable {
    static func == (lhs: Enemy, rhs: Enemy) -> Bool {
        lhs.id == rhs.id
    }
}
