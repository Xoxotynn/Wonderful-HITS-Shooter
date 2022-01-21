import UIKit

protocol GameViewModelDelegate: AnyObject {
    func showGameOverScene(withResult result: LevelResult)
}

final class GameViewModel {
    
    weak var delegate: GameViewModelDelegate?
    
    var didPreparePlayer: ((PlayerSpaceshipViewModel) -> Void)?
    var didPrepareEnemy: ((EnemyViewModel) -> Void)?
    var didPrepareBullet: ((BulletViewModel) -> Void)?
    var didGameOver: (() -> Void)?
    var didLevelFinished: (() -> Void)?
    var didKillEnemy: (() -> Void)?
    var didUpdateScore: (() -> Void)?
    
    private(set) var score: String
    
    private var level: Level
    private var enemyViewModels: [EnemyViewModel]
    private var bulletViewModels: [BulletViewModel]
    private var screenSize: CGSize
    
    init(level: Level) {
        score = String(describing: level.currentScore)
        enemyViewModels = []
        bulletViewModels = []
        screenSize = .zero
        self.level = level
        self.level.delegate = self
    }
    
    func startLevel(withScreen size: CGSize) {
        screenSize = size
        level.startLevel()
        didUpdateScore?()
    }
    
    func restartGame(withLevel level: Level) {
        clearGameField()
        self.level = level
        self.level.delegate = self
        self.level.startLevel()
        score = String(describing: self.level.currentScore)
        didUpdateScore?()
    }
    
    func showGameOverScene(isSuccess: Bool) {
        delegate?.showGameOverScene(
            withResult: LevelResult(isSuccess: isSuccess,
                                    score: level.currentScore,
                                    stars: level.getStarsCount()))
    }
    
    private func clearGameField() {
        enemyViewModels.forEach { enemyViewModel in
            enemyViewModel.removeEnemy()
        }
        bulletViewModels.forEach { bulletViewModel in
            bulletViewModel.removeBullet()
        }
        enemyViewModels = []
        bulletViewModels = []
    }
    
    private func calculateAbsoluteFrame(from relativeFrame: CGRect) -> CGRect {
        return CGRect(
            origin: calculateAbsoluteCoordinates(from: relativeFrame.origin),
            size: CGSize(
                width: relativeFrame.size.width * screenSize.width,
                height: relativeFrame.size.height * screenSize.height))
    }
    
    private func calculateAbsoluteCoordinates(
        from relativeCoordinates: CGPoint) -> CGPoint {
            return CGPoint(x: relativeCoordinates.x * screenSize.width,
                           y: relativeCoordinates.y * screenSize.height)
        }
    
    private func calculateRelativeFrame(from absoluteFrame: CGRect) -> CGRect {
        return CGRect(
            origin: calculateRelativeCoordinates(from: absoluteFrame.origin),
            size: CGSize(
                width: absoluteFrame.size.width / screenSize.width,
                height: absoluteFrame.size.height / screenSize.height))
    }
    
    private func calculateRelativeCoordinates(
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
        if isSuccess {
            didLevelFinished?()
        } else {
            didGameOver?()
        }
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
        bulletViewModels.append(bulletViewModel)
        didPrepareBullet?(bulletViewModel)
    }
    
    func setupUI(forDeadEnemy enemy: Enemy) {
        guard let viewModelIndex = enemyViewModels
                .firstIndex(where: { $0.hasEnemy(equalTo: enemy) }) else {
                    return
                }
        enemyViewModels[viewModelIndex].removeEnemy()
        enemyViewModels.remove(at: viewModelIndex)
        score = String(describing: level.currentScore)
        didUpdateScore?()
    }
    
    func setupUI(forExplodedBullet bullet: Bullet) {
        guard let viewModelIndex = bulletViewModels
                .firstIndex(where: { $0.hasBullet(equalTo: bullet) }) else {
                    return
                }
        bulletViewModels[viewModelIndex].removeBullet()
        bulletViewModels.remove(at: viewModelIndex)
    }
}
