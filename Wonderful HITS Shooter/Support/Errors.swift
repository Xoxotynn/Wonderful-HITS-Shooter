//
//  Errors.swift
//  Wonderful HITS Shooter
//
//  Created by Илья Абросимов on 13.01.2022.
//

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
