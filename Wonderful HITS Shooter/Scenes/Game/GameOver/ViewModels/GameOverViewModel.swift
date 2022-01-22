import Foundation

private extension Strings {
    static let gameOver = "Игра Окончена"
    static let levelFinished = "Уровень Пройден!"
}

protocol GameOverViewModelDelegate: AnyObject {
    func backToLevelsScene()
    func restartLevel()
}

final class GameOverViewModel {
    
    let title: String
    let scoreText: String
    let stars: Int
    
    weak var delegate: GameOverViewModelDelegate?
    
    private let result: LevelResult
    private let networkManager: NetworkManager
    
    init(result: LevelResult, networkManager: NetworkManager) {
        title = result.isSuccess ? Strings.levelFinished : Strings.gameOver
        scoreText = String(describing: result.score)
        stars = result.stars
        self.result = result
        self.networkManager = networkManager
        saveResultIfNeeded()
    }
    
    func backToLevelsScene() {
        delegate?.backToLevelsScene()
    }
    
    func restartLevel() {
        delegate?.restartLevel()
    }
    
    private func saveResultIfNeeded() {
        if result.isSuccess {
            networkManager.getMaxPoints(forLevel: result.levelNumber)
            { [weak self] maxPoints in
                self?.saveResult(maxPoints: maxPoints)
            } onError: { error in
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveResult(maxPoints: Int) {
        if result.score > maxPoints {
            try? networkManager.setLevelMaxPoints(forLevel: result.levelNumber,
                                                  points: result.score)
        }
    }
}
