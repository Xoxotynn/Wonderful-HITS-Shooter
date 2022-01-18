import Foundation

protocol PlayerDelegate: AnyObject {
    func gameOver()
}

final class Player {
    
    var spaceship: Spaceship
    weak var delegate: PlayerDelegate?
    
    init() {
        spaceship = Spaceship(hp: 100, frame: .zero)
        spaceship.spaceshipDelegate = self
    }
}

extension Player: SpaceshipDelegate {
    func didDie() {
        delegate?.gameOver()
    }
}
