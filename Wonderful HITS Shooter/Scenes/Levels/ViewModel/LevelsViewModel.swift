import CoreGraphics
import UIKit

final class LevelsViewModel {
    // MARK: - Properties
    var cellSize: CGSize = CGSize(width: (UIScreen.main.bounds.width - 64) / 3,
                                  height: (UIScreen.main.bounds.width - 64) / 3)
    var countOfLevels: Int {
        cellViewModels.count
    }
    
    var didReceiveError: ((Error) -> Void)?
    var didUpdateData: (() -> Void)?
    
    weak var delegate: TabBarItemViewModelDelegate?
    
    private let dependencies: Dependencies
    private var titleViewModel: TitleViewModel?
    private var cellViewModels: [LevelCellViewModel] = []
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        getLevelsInfo()
        getUsersResources()
    }
    
    func getCellViewModel(withIndex index: Int) throws -> LevelCellViewModel {
        guard index < cellViewModels.count else {
            throw CustomError.indexOutOfRange
        }
        
        return cellViewModels[index]
    }
    
    // MARK: - Private Methods
    private func getLevelsInfo() {
        dependencies.networkManager.getLevelsInfo { [weak self] levelModels in
            self?.setViewModels(with: levelModels)
            self?.didUpdateData?()
        } onError: { [weak self] error in
            self?.didReceiveError?(error)
        }
    }
    
    private func getUsersResources() {
        dependencies.networkManager.getPlayerMoney { [weak self] moneyValue in
            var allPoints: Int = 0
            self?.cellViewModels.forEach { allPoints += $0.points ?? 0  }
            self?.delegate?.configureTitleView(withPoints: allPoints)
            self?.delegate?.configureTitleView(withMoney: moneyValue)
        } onError: { [weak self] error in
            self?.didReceiveError?(error)
        }

    }
    
    private func setViewModels(with levels: [LevelModel]) {
        cellViewModels = []
        levels.forEach { level in
            cellViewModels.append(LevelCellViewModel(level: level))
        }
    }
}
