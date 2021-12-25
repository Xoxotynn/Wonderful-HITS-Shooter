import Foundation

protocol SpaceshipDelegate: AnyObject {
    func didDie()
}

class Spaceship: Entity {

    weak var spaceshipDelegate: SpaceshipDelegate?
    
    override func die() {
        super.die()
        
        spaceshipDelegate?.didDie()
    }
}
