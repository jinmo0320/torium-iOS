//
//  AppError.swift
//  Torium
//
//  Created by 최진모 on 2/19/26.
//
import Foundation

enum AppError: Error, LocalizedError {
    case unauthorized
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "로그인이 필요합니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}
