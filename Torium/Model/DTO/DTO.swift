//
//  SuccessDTO.swift
//  Torium
//
//  Created by 최진모 on 2/18/26.
//
import Foundation

nonisolated struct SUCCESS<T: Decodable>: Decodable {
    let data: T
}

nonisolated struct FAILURE: Decodable {
    let error: Content
    
    struct Content: Error, Decodable {
        let code: ErrorCode
        let timestamp: String
    }
}

enum ErrorCode: String, Codable {
    case INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"
    case UNAUTHORIZED = "UNAUTHORIZED"

    case LOGIN_FAILED = "LOGIN_FAILED"
    case EMAIL_NOT_VERIFIED = "EMAIL_NOT_VERIFIED"
    case EMAIL_VERIFICATION_FAILED = "EMAIL_VERIFICATION_FAILED"
    case EMAIL_ALREADY_REGISTERED = "EMAIL_ALREADY_REGISTERED"
    case EMAIL_NOT_REGISTERED = "EMAIL_NOT_REGISTERED"
    case TOKEN_REQUIRED = "TOKEN_REQUIRED"
    case TOKEN_INVALID = "TOKEN_INVALID"
    case WRONG_EMAIL_FORMAT = "WRONG_EMAIL_FORMAT"
    case WRONG_PASSWORD_FORMAT = "WRONG_PASSWORD_FORMAT"
    
    case USER_NOT_FOUND = "USER_NOT_FOUND"
    case CURRENT_PASSWORD_NOT_MATCHED = "CURRENT_PASSWORD_NOT_MATCHED"

    case QUESTIONS_NOT_FOUND = "QUESTIONS_NOT_FOUND"

    case INVALID_RISK_SCORE = "INVALID_RISK_SCORE"
    case INVALID_INVESTMENT_PLAN = "INVALID_INVESTMENT_PLAN"
    case INVESTMENT_PROFILE_NOT_FOUND = "INVESTMENT_PROFILE_NOT_FOUND"

    case PORTFOLIO_NOT_FOUND = "PORTFOLIO_NOT_FOUND"
    case INVALID_PORTIONS = "INVALID_PORTIONS"
    case INVALID_DATA_FOR_ADDING_CATEGORY = "INVALID_DATA_FOR_ADDING_CATEGORY"
    case INVALID_DATA_FOR_ADDING_ITEM = "INVALID_DATA_FOR_ADDING_ITEM"
    case UNKNOWN
}

extension ErrorCode {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = ErrorCode(rawValue: rawValue) ?? .UNKNOWN
    }
}
