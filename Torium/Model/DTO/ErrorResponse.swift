//
//  ErrorResponse.swift
//  Torium
//
//  Created by 최진모 on 1/7/26.
//

import Foundation

nonisolated struct ErrorResponseDTO: Error, Decodable {
    let code: ErrorCode
}

enum ErrorCode: Codable {
    case app(AppErrorCode)
    case auth(AuthErrorCode)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        if let authError = AuthErrorCode(rawValue: rawValue) {
            self = .auth(authError)
        } else {
            self = .app(.unknown)
        }
    }
}

enum AppErrorCode: Codable {
    case notConnectedToInternet
    case connectionFailed
    case connectionTimedOut
    case unknown
    
    public var localizedDescription: String? {
        switch self {
        case .notConnectedToInternet: return "인터넷에 연결할 수 없습니다."
        case .connectionFailed: return "서버에 연결할 수 없습니다."
        case .connectionTimedOut: return "서버 연결 시간이 초과되었습니다."
        case .unknown: return "알 수 없는 오류가 발생하였습니다."
        }
    }
}

enum AuthErrorCode: String, Codable {
    case emailNotVerified = "EMAIL_NOT_VERIFIED"
    case emailVerificationFailed = "EMAIL_VERIFICATION_FAILED"
    case emailAlreadyRegistered = "EMAIL_ALREADY_REGISTERED"
    case emailNotRegistered = "EMAIL_NOT_REGISTERED"

    case loginFailed = "LOGIN_FAILED"

    case wrongEmailFormat = "WRONG_EMAIL_FORMAT"
    case wrongPasswordFormat = "WRONG_PASSWORD_FORMAT"

    case tokenRequired = "TOKEN_REQUIRED"
    case tokenInvalid = "TOKEN_INVALID"

    case userNotFound = "USER_NOT_FOUND"
    case currentPasswordNotMatched = "CURRENT_PASSWORD_NOT_MATCHED"
}
