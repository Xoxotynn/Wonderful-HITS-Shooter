import UIKit

protocol PlayerDelegate: AnyObject {
    func gameOver()
}

final class Player {
    
    var spaceship: Spaceship
    weak var delegate: PlayerDelegate?
    
    init() {
        let spaceshipSize = 0.3
        spaceship = Spaceship(
            hp: 100,
            frame: CGRect(x: 0.5 - spaceshipSize / 2, y: 0.75,
                          width: spaceshipSize, height: spaceshipSize))
        spaceship.spaceshipDelegate = self
    }
}

extension Player: SpaceshipDelegate {
    func didDie() {
        delegate?.gameOver()
    }
}
