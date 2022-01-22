import Foundation

final class UserDefaultsManager {
    // MARK: - Key
    enum Key: String {
        case uid, musicVolume, soundEffectsVolume, musicVolumeHasChanged, soundEffectsVolumeHasChanged
    }
    
    // MARK: - Public Methods
    func getUID() -> String? {
        return UserDefaults.standard.string(forKey: Key.uid.rawValue)
    }
    
    func getMusicVolume() -> Float? {
        if UserDefaults.standard.bool(forKey: Key.musicVolumeHasChanged.rawValue) {
            return UserDefaults.standard.float(forKey: Key.musicVolume.rawValue)
        } else {
            return nil
        }
    }
    
    func getSoundEffectsVolume() -> Float? {
        if UserDefaults.standard.bool(forKey: Key.soundEffectsVolumeHasChanged.rawValue) {
            return UserDefaults.standard.float(forKey: Key.soundEffectsVolume.rawValue)
        } else {
            return nil
        }
    }
    
    func setUID(uid: String) {
        UserDefaults.standard.set(uid, forKey: Key.uid.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setMusicVolume(value: Float) {
        UserDefaults.standard.set(value, forKey: Key.musicVolume.rawValue)
        UserDefaults.standard.set(true, forKey: Key.musicVolumeHasChanged.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setSoundEffectsVolume(value: Float) {
        UserDefaults.standard.set(value, forKey: Key.soundEffectsVolume.rawValue)
        UserDefaults.standard.set(true, forKey: Key.soundEffectsVolumeHasChanged.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func removeTokens() {
        UserDefaults.standard.set(nil, forKey: Key.uid.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func isUserSignedIn() -> Bool {
        return getUID() != nil
    }
}
