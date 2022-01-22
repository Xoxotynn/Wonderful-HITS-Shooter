import Darwin

// MARK: - MenuViewModelDelegate Protocol
protocol MenuViewModelDelegate: AnyObject {
    func showTabBarScene()
    func showSettings()
    func showVideoScene()
}

final class MenuViewModel {
    // MARK: - Properties
    weak var delegate: MenuViewModelDelegate?
    
    // MARK: - Public Methods
    func showTabBarScene() {
        delegate?.showTabBarScene()
    }
    
    func showSetting() {
        delegate?.showSettings()
    }
    
    func exit() {
        Darwin.exit(0)
    }
    
    func showVideo() {
        delegate?.showVideoScene()
    }
}
