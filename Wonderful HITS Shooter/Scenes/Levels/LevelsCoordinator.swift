import UIKit

final class LevelsCoordinator: TabCoordinator {
    // MARK: - Public Methods
    override func start() {
        let levelsViewModel = LevelsViewModel(dependencies: dependencies)
        levelsViewModel.delegate = self
        levelsViewModel.levelsDelegate = self
        let levelsVC = LevelsViewController(viewModel: levelsViewModel)
        rootNavigationController.setViewControllers([levelsVC], animated: false)
    }
}

// MARK: - LevelsViewModelDelegate
extension LevelsCoordinator: LevelsViewModelDelegate {
    func startLevel(withNumber number: LevelNumber) {
        rootNavigationController.tabBarController?.tabBar.isHidden = true
        rootNavigationController.tabBarController?.navigationController?.navigationBar.isHidden = true
        let gameCoordinator = GameCoordinator(
            rootViewController: rootNavigationController,
            dependencies: dependencies,
            levelNumber: number)
        gameCoordinator.delegate = self
        childCoordinators.append(gameCoordinator)
        gameCoordinator.start()
    }
    
    func showVideoScene() {
        rootNavigationController.tabBarController?.tabBar.isHidden = true
        let videoPlayerViewModel = VideoPlayerViewModel(dependencies: dependencies, url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"))
        videoPlayerViewModel.delegate = self
        let videoPlayerVC = VideoPlayerViewController(viewModel: videoPlayerViewModel)
        rootNavigationController.pushViewController(videoPlayerVC, animated: true)
    }
}

// MARK: - VideoPlayerViewModelDelegate
extension LevelsCoordinator: VideoPlayerViewModelDelegate {
    func goBack() {
        rootNavigationController.tabBarController?.tabBar.isHidden = false
        rootNavigationController.popViewController(animated: true)
    }
}

// MARK: - GameCoordinatorDelegate
extension LevelsCoordinator: GameCoordinatorDelegate {
    func removeGameCoordinator(gameCoordinator: GameCoordinator) {
        rootNavigationController.tabBarController?.tabBar.isHidden = false
        rootNavigationController.tabBarController?.navigationController?.navigationBar.isHidden = false
        removeAllChildCoordinatorsWithType(type(of: gameCoordinator))
        start()
    }
}
