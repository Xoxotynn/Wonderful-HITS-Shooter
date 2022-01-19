import Foundation
import Firebase

final class NetworkManager {
    
    // MARK: - Properties
    private let ref: DatabaseReference = Database.database().reference()
    private var uid: String?
    
    // MARK: - Public Methods
    func register(nickname: String,
                  email: String,
                  password: String,
                  _ onComplete: @escaping () -> Void,
                  onError: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                onError(error)
            } else if let result = result {
                self.uid = result.user.uid
                self.ref.child(Strings.users)
                        .child(result.user.uid)
                        .child(Strings.authInfo)
                        .setValue([ "email" : email,
                                    "nickname" : nickname,
                                    "password" : password ])
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
                self.uid = result.user.uid
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
    
    func setPlayerMoney(toValue value: Int) {
        guard let uid = uid else {
            return
        }

        ref.child(Strings.users)
           .child(uid)
           .child(Strings.money)
           .setValue([ Strings.money: value ])
    }
    
    func getPlayerMoney(_ onComplete: @escaping ((Int) -> Void),
                        onError: @escaping () -> Void) {
        guard let uid = uid else {
            return
        }
        
        var moneyValue: Int = 0
        ref.child(Strings.users)
           .child(uid)
           .child(Strings.money)
           .getData { error, data in
               if let error = error {
                   print(error.localizedDescription)
                   onError()
               } else {
                   moneyValue = data.value as? Int ?? 0
                   onComplete(moneyValue)
               }
        }
    }
}

// MARK: - Strings
private extension Strings {
    static let users = "users"
    static let authInfo = "authInfo"
    static let money = "money"
}
