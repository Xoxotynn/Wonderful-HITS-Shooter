import UIKit

protocol PlayerDelegate: AnyObject {
    func player(didShootBullet bullet: Bullet)
    func gameOver()
}

final class Player {
    
    weak var delegate: PlayerDelegate?
    var spaceshipFrame: CGRect {
        get {
            spaceship.frame
        }
        
        set {
            spaceship.frame = newValue
        }
    }
    
    private var spaceship: Spaceship
    
    init() {
        let screenSize = UIScreen.main.bounds.size
        let gameFieldRatio = screenSize.width / screenSize.height
        let spaceshipWidth = 0.3
        spaceship = Spaceship(
            hp: 100,
            frame: CGRect(x: 0.5 - spaceshipWidth / 2,
                          y: 0.75,
                          width: spaceshipWidth,
                          height: spaceshipWidth * gameFieldRatio))
        spaceship.spaceshipDelegate = self
    }
    
    func die() {
        spaceship.die()
    }
}

extension Player: SpaceshipDelegate {
    func spaceship(didShootBullet bullet: Bullet) {
        delegate?.player(didShootBullet: bullet)
    }
    
    func spaceship(didDie deadSpaceship: Spaceship) {
        delegate?.gameOver()
    }
}
