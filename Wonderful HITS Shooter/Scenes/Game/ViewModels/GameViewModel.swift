import UIKit

final class GameViewModel {
    
    var didPreparePlayer: ((CGRect) -> Void)?
    var didPrepareEnemy: ((CGRect, [CGPoint]) -> Void)?
    
    private let level: Level
    
    init(level: Level) {
        self.level = level
        self.level.delegate = self
    }
    
    func startLevel() {
        level.startLevel()
    }
    
    func startNextWave() {
        
    }
    
    func calculateAbsoluteFrame(
        from relativeFrame: CGRect,
        forScreen screenSize: CGSize) -> CGRect {
            return CGRect(
                origin: calculateAbsoluteCoordinates(
                    from: relativeFrame.origin,
                    forScreen: screenSize),
                size: CGSize(
                    width: relativeFrame.size.width * screenSize.width,
                    height: relativeFrame.size.height * screenSize.width))
        }
    
    func calculateAbsoluteCoordinates(
        from relativeCoordinates: CGPoint,
        forScreen screenSize: CGSize) -> CGPoint {
            return CGPoint(x: relativeCoordinates.x * screenSize.width,
                           y: relativeCoordinates.y * screenSize.height)
        }
}

extension GameViewModel: LevelDelegate {
    func gameOver(withSuccess isSuccess: Bool) {
        
    }
    
    func setupUI(forPlayer player: Player) {
        didPreparePlayer?(player.spaceship.frame)
    }
    
    func setupUI(forEnemyGroup enemyGroup: EnemyGroup) {
        enemyGroup.enemies.forEach { enemy in
            didPrepareEnemy?(enemy.frame, enemy.route)
        }
    }
}
