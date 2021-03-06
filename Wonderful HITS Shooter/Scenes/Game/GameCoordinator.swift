import UIKit

protocol GameCoordinatorDelegate: AnyObject {
    func removeGameCoordinator(gameCoordinator: GameCoordinator)
}

final class GameCoordinator: Coordinator {
    
    weak var delegate: GameCoordinatorDelegate?
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private var gameViewModel: GameViewModel?
    private let dependencies: Dependencies
    private let levelNumber: LevelNumber
    
    init(rootViewController: UINavigationController,
         dependencies: Dependencies,
         levelNumber: LevelNumber) {
        self.dependencies = dependencies
        self.levelNumber = levelNumber
        rootNavigationController = rootViewController
        childCoordinators = []
    }
    
    func start() {
        rootNavigationController.navigationBar.isHidden = true
        let viewModel = GameViewModel(
            levelNumber: levelNumber,
            dependencies: dependencies)
        let viewController = GameViewController(viewModel: viewModel)
        viewModel.delegate = self
        gameViewModel = viewModel
        rootNavigationController.pushViewController(viewController, animated: true)
        dependencies.audioManager.play(audio: Strings.levelTheme, needToLoop: true)
    }
}

extension GameCoordinator: GameViewModelDelegate {
    func showGameOverScene(withResult result: LevelResult) {
        let viewModel = GameOverViewModel(
            result: result,
            networkManager: dependencies.networkManager)
        let viewController = GameOverViewController(viewModel: viewModel)
        viewModel.delegate = self
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        rootNavigationController.present(viewController, animated: true)
    }
}

extension GameCoordinator: GameOverViewModelDelegate {
    func backToLevelsScene() {
        delegate?.removeGameCoordinator(gameCoordinator: self)
    }
    
    func restartLevel() {
        gameViewModel?.restartGame()
    }
}

private extension Strings {
    static let levelTheme = "levelTheme"
}
