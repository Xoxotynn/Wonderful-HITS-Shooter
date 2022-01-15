import UIKit

protocol EnemyDelegate: AnyObject {
    func didDie(enemy: Enemy)
}

final class Enemy: Entity {
    
    var weapon: Weapon?
    weak var enemyDelegate: EnemyDelegate?
    
    private let id: UUID
    
    init(hp: Int, weapon: Weapon? = nil) {
        self.id = UUID()
        super.init(hp: hp, frame: .zero)
        self.weapon = weapon
        configureWeapon()
    }
    
    override func die() {
        super.die()
        enemyDelegate?.didDie(enemy: self)
    }
    
    private func configureWeapon() {
        
    }
}

extension Enemy: Equatable {
    static func == (lhs: Enemy, rhs: Enemy) -> Bool {
        lhs.id == rhs.id
    }
}
