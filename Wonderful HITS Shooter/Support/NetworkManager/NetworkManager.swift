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
    
    func setPlayerMoney(toValue value: Int) throws {
        guard let uid = uid else {
            throw NetworkError.notAuthorized
        }

        ref.child(Strings.users)
           .child(uid)
           .child(Strings.money)
           .setValue([ Strings.money: value ])
    }
    
    func getPlayerMoney(_ onComplete: @escaping ((Int) -> Void),
                        onError: @escaping (Error) -> Void) {
        guard let uid = uid else {
            onError(NetworkError.notAuthorized)
            return
        }
        
        ref.child(Strings.users)
           .child(uid)
           .child(Strings.money)
           .getData { error, snapshot in
               if let error = error {
                   onError(error)
               } else {
                   let moneyValue = snapshot.value as? Int ?? 0
                   onComplete(moneyValue)
               }
        }
    }
    
    func setLevelMaxPoints(forLevel level: LevelNumber, points: Int) throws {
        guard let uid = uid else {
            throw NetworkError.notAuthorized
        }

        ref.child(Strings.users)
           .child(uid)
           .child(Strings.levels)
           .child(level.rawValue)
           .setValue([ Strings.points: points ])
    }
    
    func getMaxPoints(forLevel level: LevelNumber,
                      _ onComplete: @escaping (Int) -> Void,
                      onError: @escaping (Error) -> Void) {
        guard let uid = uid else {
            onError(NetworkError.notAuthorized)
            return
        }
        
        ref.child(Strings.users)
           .child(uid)
           .child(level.rawValue)
           .getData { error, snapshot in
               if let error = error {
                   onError(error)
               } else {
                   let pointsValue = snapshot.value as? Int ?? 0
                   onComplete(pointsValue)
               }
        }
    }
}

// MARK: - Strings
private extension Strings {
    static let users = "users"
    static let authInfo = "authInfo"
    static let money = "money"
    static let levels = "levels"
    static let points = "points"
}
