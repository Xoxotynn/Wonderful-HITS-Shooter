import UIKit

protocol EnemyDelegate: AnyObject {
    func enemy(didDie deadEnemy: Enemy)
}

final class Enemy: Entity {
    
    var route: [CGPoint]
    
    weak var enemyDelegate: EnemyDelegate?
    
    init(hp: Int, weapon: Weapon? = nil) {
        let screenSize = UIScreen.main.bounds.size
        let gameFieldRatio = screenSize.width / screenSize.height
        route = []
        super.init(
            hp: hp,
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 0.1,
                             height: 0.1 * gameFieldRatio)))
    }
    
    override func die() {
        super.die()
        enemyDelegate?.enemy(didDie: self)
    }
}
