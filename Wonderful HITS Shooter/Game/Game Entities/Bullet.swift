import UIKit

final class Bullet: Entity {
    
    let endPoint: CGPoint
    
    init(position: CGPoint, endPoint: CGPoint) {
        let screenSize = UIScreen.main.bounds.size
        let gameFieldRatio = screenSize.width / screenSize.height
        self.endPoint = endPoint
        super.init(hp: 40,
                   frame: CGRect(
                    origin: position,
                    size: CGSize(width: 0.05,
                                 height: 0.05 * gameFieldRatio)))
    }
}
