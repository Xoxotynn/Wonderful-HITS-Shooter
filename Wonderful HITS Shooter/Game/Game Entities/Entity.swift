import UIKit

protocol EntityDelegate: AnyObject {
    func didDie(entity: Entity)
}

class Entity {
    
    var hp: Int
    var frame: CGRect
    
    weak var entityDelegate: EntityDelegate?
    
    init(hp: Int, frame: CGRect) {
        self.hp = hp
        self.frame = frame
    }
    
    func die() {
        entityDelegate?.didDie(entity: self)
    }
}
