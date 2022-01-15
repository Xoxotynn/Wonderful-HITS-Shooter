import UIKit

protocol PlayerDelegate: AnyObject {
    func gameOver()
}

final class Player {
    
    var spaceship: Spaceship
    weak var delegate: PlayerDelegate?
    
    init() {
        spaceship = Spaceship(
            hp: 100,
            frame: CGRect(x: 0.5, y: 0.8,
                          width: 0.25, height: 0.25))
        spaceship.spaceshipDelegate = self
    }
}

extension Player: SpaceshipDelegate {
    func didDie() {
        delegate?.gameOver()
    }
}
