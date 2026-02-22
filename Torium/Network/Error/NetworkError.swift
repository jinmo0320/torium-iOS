//
//  NetworkError.swift
//  Torium
//
//  Created by 최진모 on 2/18/26.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case notConnectedToInternet
    case connectionFailed
    case connectionTimedOut
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .notConnectedToInternet: return "인터넷에 연결할 수 없습니다."
        case .connectionFailed: return "서버에 연결할 수 없습니다."
        case .connectionTimedOut: return "서버 연결 시간이 초과되었습니다."
        case .unknown: return "알 수 없는 오류가 발생하였습니다."
        }
    }
}
