import UIKit

final class GameViewModel {
    
    let playerSpaceshipViewModel: PlayerSpaceshipViewModel
    
    var didPreparePlayer: ((CGRect) -> Void)?
    var didPrepareEnemy: ((EnemyViewModel) -> Void)?
    var didGameOver: ((Bool) -> Void)?
    
    private let level: Level
    private var enemyViewModels: [EnemyViewModel]
    private var screenSize: CGSize
    
    init(level: Level) {
        playerSpaceshipViewModel = PlayerSpaceshipViewModel()
        enemyViewModels = []
        screenSize = .zero
        self.level = level
        self.level.delegate = self
        playerSpaceshipViewModel.delegate = self
    }
    
    func startLevel(withScreen size: CGSize) {
        screenSize = size
        level.startLevel()
    }
    
    func startNextWave() {
        
    }
    
    func calculateAbsoluteFrame(from relativeFrame: CGRect) -> CGRect {
        return CGRect(
            origin: calculateAbsoluteCoordinates(from: relativeFrame.origin),
            size: CGSize(
                width: relativeFrame.size.width * screenSize.width,
                height: relativeFrame.size.height * screenSize.height))
    }
    
    func calculateAbsoluteCoordinates(
        from relativeCoordinates: CGPoint) -> CGPoint {
            return CGPoint(x: relativeCoordinates.x * screenSize.width,
                           y: relativeCoordinates.y * screenSize.height)
        }
    
    func calculateRelativeFrame(from absoluteFrame: CGRect) -> CGRect {
        return CGRect(
            origin: calculateRelativeCoordinates(from: absoluteFrame.origin),
            size: CGSize(
                width: absoluteFrame.size.width / screenSize.width,
                height: absoluteFrame.size.height / screenSize.height))
    }
    
    func calculateRelativeCoordinates(
        from absoluteCoordinates: CGPoint) -> CGPoint {
            return CGPoint(x: absoluteCoordinates.x / screenSize.width,
                           y: absoluteCoordinates.y / screenSize.height)
        }
}

extension GameViewModel: PlayerSpaceshipViewModelDelegate {
    func playerSpaceshipView(spaceshipViewModel: PlayerSpaceshipViewModel,
                             didChangeFrameWith frame: CGRect) {
        level.changePlayerSpaceshipFrame(
            with: calculateRelativeFrame(from: frame))
    }
}

extension GameViewModel: EnemyViewModelDelegate {
    func enemyView(enemyViewModel: EnemyViewModel,
                   didChangeFrameWith frame: CGRect) {
        enemyViewModel.enemy.frame = calculateRelativeFrame(from: frame)
    }
}

extension GameViewModel: LevelDelegate {
    func gameOver(withSuccess isSuccess: Bool) {
        didGameOver?(isSuccess)
    }
    
    func setupUI(forPlayer player: Player) {
        didPreparePlayer?(player.spaceshipFrame)
    }
    
    func setupUI(forEnemyGroup enemyGroup: EnemyGroup) {
        enemyGroup.enemies.forEach { enemy in
            let currentEnemyFrame = calculateAbsoluteFrame(from: enemy.frame)
            let currentEnemyRoute = enemy.route.map { point in
                calculateAbsoluteCoordinates(from: point)
            }
            let enemyViewModel = EnemyViewModel(
                enemy: enemy,
                frame: currentEnemyFrame,
                route: currentEnemyRoute)
            enemyViewModel.delegate = self
            enemyViewModels.append(enemyViewModel)
            didPrepareEnemy?(enemyViewModel)
        }
    }
}
