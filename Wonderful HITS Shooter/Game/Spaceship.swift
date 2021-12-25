import Foundation

protocol SpaceshipDelegate: AnyObject {
    func didDie()
}

class Spaceship: Entity {

    weak var delegate: SpaceshipDelegate?
    
    override func die() {
        super.die()
        
        delegate?.didDie()
    }
}
