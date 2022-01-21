import UIKit

final class GameViewModel {
    
    var didPreparePlayer: ((PlayerSpaceshipViewModel) -> Void)?
    var didPrepareEnemy: ((EnemyViewModel) -> Void)?
    var didPrepareBullet: ((BulletViewModel) -> Void)?
    var didGameOver: ((Bool) -> Void)?
    var didKillEnemy: (() -> Void)?
    
    private let level: Level
    private var enemyViewModels: [EnemyViewModel]
    private var screenSize: CGSize
    
    init(level: Level) {
        enemyViewModels = []
        screenSize = .zero
        self.level = level
        self.level.delegate = self
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
        spaceshipViewModel.changePlayerFrame(
            with: calculateRelativeFrame(from: frame))
    }
}

extension GameViewModel: EnemyViewModelDelegate {
    func enemyView(enemyViewModel: EnemyViewModel,
                   didChangeFrameWith frame: CGRect) {
        enemyViewModel.changeEnemyFrame(with: calculateRelativeFrame(from: frame))
    }
}

extension GameViewModel: BulletViewModelDelegate {
    func bulletView(bulletViewModel: BulletViewModel,
                    didChangeFrameWith frame: CGRect) {
        bulletViewModel.changeBulletFrame(
            with: calculateRelativeFrame(from: frame))
    }
}

extension GameViewModel: LevelDelegate {
    func gameOver(withSuccess isSuccess: Bool) {
        didGameOver?(isSuccess)
    }
    
    func setupUI(forPlayer player: Player) {
        let playerSpaceshipViewModel = PlayerSpaceshipViewModel(
            player: player,
            frame: calculateAbsoluteFrame(from: player.spaceshipFrame))
        playerSpaceshipViewModel.delegate = self
        didPreparePlayer?(playerSpaceshipViewModel)
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
    
    func setupUI(forBullet bullet: Bullet) {
        let bulletFrame = calculateAbsoluteFrame(from: bullet.frame)
        let bulletEndPoint = calculateAbsoluteCoordinates(from: bullet.endPoint)
        let bulletViewModel = BulletViewModel(
            bullet: bullet,
            frame: bulletFrame,
            endPoint: bulletEndPoint)
        bulletViewModel.delegate = self
        didPrepareBullet?(bulletViewModel)
    }
    
    func setupUI(forDeadEnemy enemy: Enemy) {
        guard let enemyViewModel = enemyViewModels
                .first(where: { $0.hasEnemy(equalTo: enemy) }) else {
                    return
                }
        enemyViewModel.removeEnemy()
    }
}
