//
//  AuthError.swift
//  Torium
//
//  Created by 최진모 on 1/10/26.
//

import Foundation

enum LoginError: Error, LocalizedError  {
    case loginFailed
    
    public var errorDescription: String? {
        switch self {
        case .loginFailed: return "로그인에 실패하였습니다."
        }
    }
}

enum RegisterEmailError: Error, LocalizedError {
    case emailAlreadyRegistered
    
    public var errorDescription: String? {
        switch self {
        case .emailAlreadyRegistered: return "이미 가입된 이메일입니다."
        }
    }
}

enum ForgotEmailError: Error, LocalizedError {
    case emailNotRegistered
    
    public var errorDescription: String? {
        switch self {
        case .emailNotRegistered: return "가입되지 않은 이메일입니다."
        }
    }
}

enum VerificationError: Error, LocalizedError {
    case verificationFailed
}

enum SetPasswordError: Error, LocalizedError {
    case emailNotVerified

    public var errorDescription: String? {
        switch self {
        case .emailNotVerified: return "인증되지 않은 이메일입니다. 재인증이 필요합니다."
        }
    }
}

