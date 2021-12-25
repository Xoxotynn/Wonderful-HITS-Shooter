import Foundation

protocol PlayerDelegate: AnyObject {
    func gameOver()
}

final class Player {
    
    var spaceship: ShootingSpaceship
    weak var delegate: PlayerDelegate?
    
    init() {
        spaceship = ShootingSpaceship(hp: 100)
        spaceship.delegate = self
    }
}

extension Player: SpaceshipDelegate {
    func didDie() {
        delegate?.gameOver()
    }
}
