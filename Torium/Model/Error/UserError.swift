//
//  UserError.swift
//  Torium
//
//  Created by 최진모 on 2/4/26.
//
import Foundation

enum UserError: Error, LocalizedError {
    case app(AppErrorCode)
    case userNotFound
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
            
        case .auth(.userNotFound):
            self = .userNotFound
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        case .userNotFound: return "유저 정보를 가져오는데 실패했습니다."
        }
    }
}

enum ChangePasswordError: Error, LocalizedError {
    case app(AppErrorCode)
    case currentPasswordNotMatched
    
    init(from dto: ErrorResponseDTO) {
        switch dto.code {
        case .app(let appErrorCode):
            self = .app(appErrorCode)
            
        case .auth(.currentPasswordNotMatched):
            self = .currentPasswordNotMatched
            
        default:
            self = .app(.unknown)
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .app(let error): return error.localizedDescription
        case .currentPasswordNotMatched: return "이전 비밀번호가 일치하지 않습니다."
        }
    }
}
