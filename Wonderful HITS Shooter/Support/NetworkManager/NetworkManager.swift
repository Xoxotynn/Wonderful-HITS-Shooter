import Firebase

final class NetworkManager {
    
    // MARK: - Properties
    var country: String?
    
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
                let ref = self.ref.child(Strings.users).child(result.user.uid)
                ref.child(Strings.authInfo).setValue([ Strings.email : email,
                                                       Strings.nickname : nickname,
                                                       Strings.password : password ])
                ref.child(Strings.levels)
                    .child(LevelNumber.first.rawValue)
                    .setValue([ Strings.points: 0 ])

                ref.child(Strings.levels)
                    .child(LevelNumber.second.rawValue)
                    .setValue([ Strings.points: 0 ])

                ref.child(Strings.levels)
                    .child(LevelNumber.third.rawValue)
                    .setValue([ Strings.points: 0 ])
                
                ref.child(Strings.money).setValue([ Strings.moneyValue: 0 ])
                
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
    
    func setUID(uid: String) {
        self.uid = uid
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
           .child(Strings.levels)
           .child(level.rawValue)
           .child(Strings.points)
           .getData { error, snapshot in
               if let error = error {
                   onError(error)
               } else {
                   let pointsValue = snapshot.value as? Int ?? 0
                   onComplete(pointsValue)
               }
        }
    }
    
    func getLevelsInfo(_ onComplete: @escaping ([LevelModel]) -> Void,
                       onError: @escaping (Error) -> Void) {
        guard let uid = uid else {
            onError(NetworkError.notAuthorized)
            return
        }
        
        var levels: [LevelModel] = []
        let levelsRef = ref.child(Strings.users).child(uid).child(Strings.levels)
        
        levelsRef.child(LevelNumber.first.rawValue).child(Strings.points).getData { error, snapshot in
            if let error = error {
                onError(error)
            } else {
                let pointsValue = snapshot.value as? Int ?? 0
                levels.append(LevelModel(levelNumber: 1,
                                         points: pointsValue,
                                         maxPoints: Dimensions.LevelsMaxPoints.first))
            }
        }
        
        levelsRef.child(LevelNumber.second.rawValue).child(Strings.points).getData { error, snapshot in
            if let error = error {
                print(error.localizedDescription)
                onComplete(levels)
            } else {
                let pointsValue = snapshot.value as? Int ?? 0
                levels.append(LevelModel(levelNumber: 2,
                                         points: pointsValue,
                                         maxPoints: Dimensions.LevelsMaxPoints.second))
            }
        }
        
        levelsRef.child(LevelNumber.third.rawValue).child(Strings.points).getData { error, snapshot in
            if let error = error {
                print(error.localizedDescription)
                onComplete(levels)
            } else {
                let pointsValue = snapshot.value as? Int ?? 0
                levels.append(LevelModel(levelNumber: 3,
                                         points: pointsValue,
                                         maxPoints: Dimensions.LevelsMaxPoints.third))
                onComplete(levels)
            }
        }
    }
    
    func setCountry(countryName: String?) {
        guard let countryName = countryName else {
            return
        }

        country = countryName
        
        ref.child(Strings.records).child(countryName).getData { [weak self] error, snapshot in
            if let error = error {
                print(error.localizedDescription)
            } else if snapshot.value as? Int == nil {
                self?.ref.child(Strings.records).child(countryName).setValue(0)
            }
        }
    }
    
    func setCountryRecord(points: Int) {
        guard let country = country else {
            return
        }
        
        let ref = ref.child(Strings.records).child(country)
        ref.getData { error, snapshot in
            if let error = error {
                print(error.localizedDescription)
            } else if let recordValue = snapshot.value as? Int, recordValue < points {
                ref.setValue(points)
            }
        }
    }
    
    func getRecordList(_ onComplete: @escaping ([RecordModel]) -> Void,
                       onError: @escaping (Error) -> Void) {
        ref.child(Strings.records).getData { error, snapshot in
            if let error = error {
                onError(error)
            } else {
                var recordModels: [RecordModel] = []
                let records = snapshot.value as? [String : Int]
                records?.forEach { record in
                    recordModels.append(RecordModel(country: record.key,
                                                    points: record.value))
                }
                
                onComplete(recordModels)
            }
        }
    }
}

// MARK: - Strings
private extension Strings {
    static let email = "email"
    static let nickname = "nickname"
    static let password = "password"
    static let users = "users"
    static let authInfo = "authInfo"
    static let moneyValue = "moneyValue"
    static let money = "money"
    static let levels = "levels"
    static let points = "points"
    static let records = "records"
}
