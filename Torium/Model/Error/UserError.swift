//
//  UserError.swift
//  Torium
//
//  Created by 최진모 on 2/4/26.
//
import Foundation

enum ChangePasswordError: Error, LocalizedError {
    case currentPasswordNotMatched

    public var errorDescription: String? {
        switch self {
        case .currentPasswordNotMatched: return "이전 비밀번호가 일치하지 않습니다."
        }
    }
}
