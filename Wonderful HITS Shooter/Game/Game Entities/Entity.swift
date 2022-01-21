import UIKit

class Entity {
    
    var hp: Int
    var frame: CGRect
    
    private let id: UUID
    
    init(hp: Int, frame: CGRect) {
        id = UUID()
        self.hp = hp
        self.frame = frame
    }
    
    func takeDamage(withAmount amount: Int) {
        hp -= amount
        if hp <= 0 {
            die()
        }
    }
    
    func die() { }
}

extension Entity: Equatable {
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.id == rhs.id
    }
}
