//
//  Validator.swift
//  Torium
//
//  Created by 최진모 on 1/10/26.
//

import Foundation

struct Validator {
    /// 이메일 검증
    /// - 영문, 숫자, 특수기호 (@, 도메인 주소 형식 포함)
    static func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    struct PasswordValidationResult: Equatable {
        let alphabet: Bool
        let number: Bool
        let specialCharacter: Bool
        let length: Bool
    }
    
    /// 비밀번호 검증
    /// - 영문자, 숫자, 특수문자 포함
    /// - 8자 이상
    static func validatePassword(_ password: String) -> PasswordValidationResult {
        let containsAlphabet = password.range(of: "[a-zA-z]", options: .regularExpression) != nil
        let containsNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
        let containsSpecialCharacter = password.range(of: "[!@#$%^&*()_+={}\\[\\]|\\\\:;\"'<>,.?/-]", options: .regularExpression) != nil
        let isValidLength = password.count >= 8
        
        return PasswordValidationResult(alphabet: containsAlphabet, number: containsNumber, specialCharacter: containsSpecialCharacter, length: isValidLength)
    }
}
