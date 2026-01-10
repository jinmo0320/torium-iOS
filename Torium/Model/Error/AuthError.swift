//
//  AuthError.swift
//  Torium
//
//  Created by 최진모 on 1/10/26.
//

import Foundation

enum LoginError: Error, LocalizedError {
    case app(AppErrorCode)
    case loginFailed
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
            
        case .auth(.loginFailed), .auth(.wrongEmailFormat), .auth(.wrongPasswordFormat):
            self = .loginFailed
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        case .loginFailed: return "로그인에 실패하였습니다."
        }
    }
}

enum RegisterEmailError: Error, LocalizedError {
    case app(AppErrorCode)
    case emailAlreadyRegistered
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
            
        case .auth(.emailAlreadyRegistered):
            self = .emailAlreadyRegistered
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        case .emailAlreadyRegistered: return "이미 가입된 이메일입니다."
        }
    }
}

enum RegisterVerifyError: Error, LocalizedError, Equatable {
    case app(AppErrorCode)
    case verificationFailed
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
            
        case .auth(.emailVerificationFailed):
            self = .verificationFailed
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        default: return nil
        }
    }
}

enum RegisterPasswordError: Error, LocalizedError, Equatable {
    case app(AppErrorCode)
    case emailAlreadyRegistered
    case emailNotVerified
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
        
        case .auth(.emailAlreadyRegistered):
            self = .emailAlreadyRegistered
        
        case .auth(.emailNotVerified):
            self = .emailNotVerified
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        case .emailAlreadyRegistered: return "이미 가입된 이메일입니다."
        case .emailNotVerified: return "인증되지 않은 이메일입니다. 재인증이 필요합니다."
        }
    }
}

enum ForgotEmailError: Error, LocalizedError {
    case app(AppErrorCode)
    case emailNotRegistered
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
            
        case .auth(.emailNotRegistered):
            self = .emailNotRegistered
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        case .emailNotRegistered: return "가입되지 않은 이메일입니다."
        }
    }
}

enum ForgotVerifyError: Error, LocalizedError, Equatable {
    case app(AppErrorCode)
    case verificationFailed
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
            
        case .auth(.emailVerificationFailed):
            self = .verificationFailed
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        default: return nil
        }
    }
}

enum ForgotPasswordError: Error, LocalizedError, Equatable {
    case app(AppErrorCode)
    case emailNotVerified
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
        
        case .auth(.emailNotVerified):
            self = .emailNotVerified
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        case .emailNotVerified: return "인증되지 않은 이메일입니다. 재인증이 필요합니다."
        }
    }
}
