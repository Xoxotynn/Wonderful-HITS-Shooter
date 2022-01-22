protocol SettingsViewModelDelegate: AnyObject {
    func showAuthScene()
}

final class SettingsViewModel {
    // MARK: - Properties
    weak var delegate: SettingsViewModelDelegate?
    
    var didSetMusicVolume: ((Float) -> Void)?
    var didSetSoundEffectsVolume: ((Float) -> Void)?
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        didSetMusicVolume?(dependencies.userDefaultsManager.getMusicVolume() ?? 1.0)
        didSetSoundEffectsVolume?(dependencies.userDefaultsManager.getSoundEffectsVolume() ?? 1.0)
    }
    
    func changeMusicVolume(toValue value: Float, needToSave: Bool = false) {
        dependencies.audioManager.setMusicVolume(toValue: value)
        
        if needToSave {
            dependencies.userDefaultsManager.setMusicVolume(value: value)
        }
    }
    
    func changeSoundEffectsVolume(toValue value: Float, needToSave: Bool = false) {
        dependencies.audioManager.setSoundEffectsVolume(toValue: value)
        
        if needToSave {
            dependencies.userDefaultsManager.setSoundEffectsVolume(value: value)
        }
    }
    
    func logOut() {
        dependencies.networkManager.signOut()
        delegate?.showAuthScene()
    }
}
