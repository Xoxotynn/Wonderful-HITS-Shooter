import Foundation

final class Validator {
    static func validateSignInTextFields(email: String, password: String) -> Error? {
        guard checkForEmpty([email, password]) else {
            return ValidationError.emptyTextFields
        }
        
        guard checkMailValidity(with: email) else {
            return ValidationError.emailValidationError
        }
        
        return nil
    }
    
    static func validateSignUpTextFields(nickname: String, email: String, password: String, confirmedPassword: String) -> Error? {
        
        guard checkForEmpty([nickname, email, password, confirmedPassword]) else {
            return ValidationError.emptyTextFields
        }
        
        guard checkMailValidity(with: email) else {
            return ValidationError.emailValidationError
        }
        
        guard checkPasswordEquivalence(password: password, confirmedPassword: confirmedPassword) else {
            return ValidationError.notEquivalentPasswords
        }
        
        return nil
    }
    
    static func checkMailValidity(with email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    static func checkForEmpty(_ array: [String]) -> Bool {
        return array.allSatisfy { !$0.isEmpty }
    }
    
    static func checkPasswordEquivalence(password: String, confirmedPassword: String) -> Bool {
        return password == confirmedPassword
    }
}
