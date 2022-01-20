import UIKit

protocol EnemyViewModelDelegate: AnyObject {
    func enemyView(enemyViewModel: EnemyViewModel,
                   didChangeFrameWith frame: CGRect)
}

final class EnemyViewModel {
    
    weak var delegate: EnemyViewModelDelegate?
    var frame: CGRect
    var route: [CGPoint]
    
    let enemy: Enemy
    
    init(enemy: Enemy, frame: CGRect, route: [CGPoint]) {
        self.enemy = enemy
        self.frame = frame
        self.route = route
    }
    
    func sendCurrentFrame(_ frame: CGRect) {
        delegate?.enemyView(enemyViewModel: self,
                            didChangeFrameWith: frame)
    }
}
