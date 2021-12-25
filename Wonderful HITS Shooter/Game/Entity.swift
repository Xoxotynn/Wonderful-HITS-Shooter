import Foundation

protocol EntityDelegate: AnyObject {
    func didDie(entity: Entity)
}

class Entity {
    var hp: Int
    
    weak var entityDelegate: EntityDelegate?
    
    init(hp: Int) {
        self.hp = hp
    }
    
    func die() {
        entityDelegate?.didDie(entity: self)
    }
}
