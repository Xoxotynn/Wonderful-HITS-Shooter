import Foundation
import Firebase

final class NetworkManager {
    
    let userDefaults = UserDefaultsManager()
    
    func register(nickname: String, email: String, password: String,
                  _ onComplete: @escaping () -> Void,
                  onError: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                onError(error)
            } else if let result = result {
                let ref = Database.database().reference().child(Strings.pathUsers)
                ref.child(result.user.uid).updateChildValues([ "nickname" : nickname,
                                                               "email" : email])
                onComplete()
            } else {
                print("Error")
            }
        }
    }
    
    func auth(email: String, password: String,
              _ onComplete: @escaping () -> Void,
              onError: @escaping (Error) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                onError(error)
            } else if let result = result {
                print(result.user.uid)
                onComplete()
            } else {
                print("Error")
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

private extension Strings {
    static let pathUsers = "users"
}
