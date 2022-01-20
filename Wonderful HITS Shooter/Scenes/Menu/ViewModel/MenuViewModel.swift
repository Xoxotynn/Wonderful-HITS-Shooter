import Darwin

// MARK: - MenuViewModelDelegate Protocol
protocol MenuViewModelDelegate: AnyObject {
    func showLevelsScene()
    func showSettings()
    func showAuthScene()
}

final class MenuViewModel {
    // MARK: - Properties
    weak var delegate: MenuViewModelDelegate?
    
    // MARK: - Public Methods
    func showLevelsScene() {
        delegate?.showLevelsScene()
    }
    
    func showSetting() {
        delegate?.showSettings()
    }
    
    func exit() {
        Darwin.exit(0)
    }
    
    func logOut() {
        delegate?.showAuthScene()
    }
}
