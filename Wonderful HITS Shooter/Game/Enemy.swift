import UIKit

protocol EnemyDelegate: AnyObject {
    func didDie(enemy: Enemy)
}

final class Enemy: Entity {
    
    var position: CGPoint
    var weapon: Weapon?
    weak var enemyDelegate: EnemyDelegate?
    
    private let id: Int
    
    init(id: Int, hp: Int, weapon: Weapon? = nil) {
        position = .zero
        self.id = id
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
