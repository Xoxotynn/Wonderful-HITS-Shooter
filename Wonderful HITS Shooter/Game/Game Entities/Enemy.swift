import UIKit

protocol EnemyDelegate: AnyObject {
    func didDie(enemy: Enemy)
}

final class Enemy: Entity {
    
    var route: [CGPoint]
    
    weak var enemyDelegate: EnemyDelegate?
    
    private let id: UUID
    private var weapon: Weapon?
    
    init(hp: Int, weapon: Weapon? = nil) {
        id = UUID()
        route = []
        super.init(hp: hp,
                   frame: CGRect(origin: .zero,
                                 size: CGSize(width: 0.1, height: 0.1)))
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