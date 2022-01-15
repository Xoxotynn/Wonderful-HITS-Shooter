import Foundation
import Firebase

final class NetworkManager {
    
    let userDefaults = UserDefaultsManager()
    
    private let ref: DatabaseReference = Database.database().reference()
    
    func register(nickname: String,
                  email: String,
                  password: String,
                  _ onComplete: @escaping () -> Void,
                  onError: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                onError(error)
            } else if let result = result {
                self.ref.child(Strings.users)
                        .child(result.user.uid)
                        .child(Strings.authInfo)
                        .setValue(["email" : email,
                                   "nickname" : nickname,
                                   "password" : password])
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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

private extension Strings {
    static let users = "users"
    static let authInfo = "authInfo"
}
