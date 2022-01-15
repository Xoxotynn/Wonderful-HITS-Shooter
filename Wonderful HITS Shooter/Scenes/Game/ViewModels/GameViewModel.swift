import UIKit

final class GameViewModel {
    
    var didPreparePlayer: ((CGRect) -> Void)?
    var didStartWave: (() -> Void)?
    
    private let level: Level
    
    init(level: Level) {
        self.level = level
        self.level.delegate = self
    }
    
    func startLevel() {
        level.spawnNextWave()
        
    }
    
    func startNextWave() {
        
    }
    
    func calculateAbsoluteFrame(
        from relativeFrame: CGRect,
        forScreen screenSize: CGSize) -> CGRect {
            return CGRect(
                x: relativeFrame.origin.x * screenSize.width,
                y: relativeFrame.origin.y * screenSize.height,
                width: relativeFrame.size.width * screenSize.width,
                height: relativeFrame.size.height * screenSize.height)
        }
    
    func calculateEnemyRoute(
        forEnemy enemy: Enemy,
        relativeRoute: [CGPoint]) -> [CGPoint] {
            var route: [CGPoint] = [CGPoint(x: enemy.frame.origin.x,
                                            y: enemy.frame.origin.y)]
            
            relativeRoute.forEach { nextPosition in
                guard let previousPosition = route.last else { return }
                route.append(CGPoint(
                    x: previousPosition.x + nextPosition.x,
                    y: previousPosition.y + nextPosition.y))
            }
            route.remove(at: 0)
            
            return route
        }
}

extension GameViewModel: LevelDelegate {
    func gameFieldRatio(forLevel level: Level) -> CGFloat {
        return 1
    }
    
    func setupUI(forPlayer player: Player) {
        
    }
    
    func setupUI(forEnemies enemies: [EnemyGroup]) {
        
    }
}
