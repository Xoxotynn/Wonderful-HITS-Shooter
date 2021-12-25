import Foundation

protocol PlayerSpaceshipDelegate: AnyObject {
    func didDie()
}

class PlayerSpaceship: ShootingSpaceship {
    
    weak var delegate: PlayerSpaceshipDelegate?
    
    override func die() {
        super.die()
        
        delegate?.didDie()
    }
}
