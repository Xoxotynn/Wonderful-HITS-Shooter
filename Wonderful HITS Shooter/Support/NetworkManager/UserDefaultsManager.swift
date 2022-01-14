import Foundation

final class UserDefaultsManager {
    enum Key: String {
        case uid
    }
    
    // MARK: - Public Methods
    func getUID() -> String? {
        return UserDefaults.standard.string(forKey: Key.uid.rawValue)
    }
    
    func setUID(uid: String) {
        UserDefaults.standard.set(uid, forKey: Key.uid.rawValue)
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
