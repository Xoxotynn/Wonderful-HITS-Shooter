import Foundation

enum ValidationError: LocalizedError {
    case emptyTextFields, emailValidationError, notEquivalentPasswords, nameIsEmpty
    
    var errorDescription: String? {
        switch self {
        case .emptyTextFields:
            return "Заполнены не все поля!"
            
        case .emailValidationError:
            return "E-Mail введён некорректно!"
            
        case .notEquivalentPasswords:
            return "Введённые пароли не совпадают!"
            
        case .nameIsEmpty:
            return "Заполните поле Имя!"
        }
    }
}

enum NetworkError: LocalizedError {
    case notAuthorized
    
    var errorDescription: String? {
        switch self {
        case .notAuthorized:
            return "Пользователь не авторизован"
        }
    }
}

enum CustomError: LocalizedError {
    case indexOutOfRange
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return "Ошибка"
        }
    }
}
