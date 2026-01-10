//
//  AuthRouter.swift
//  MemoWithTags
//
//  Created by 최진모 on 1/4/25.

import Foundation
import Alamofire

enum AuthRouter: Router {
    case login(email: String, password: String)
    case sendEmail(email: String)
    case verifyEmail(email: String, code: String)
    case sendForgot(email: String)
    case verifyForgot(email: String, code: String)
    case register(email: String, password: String)
    case resetPassword(email: String, newPassword: String)
    case refreshToken(refreshToken: String)
    
    var baseURL: URL {
        return URL(string: NetworkConfiguration.localURL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .register, .login, .resetPassword, .sendEmail, .verifyEmail, .sendForgot, .verifyForgot, .refreshToken:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .sendEmail:
            return "/auth/verification/send"
        case .verifyEmail:
            return "/auth/verification/verify"
        case .sendForgot:
            return "/auth/forgot-password/send"
        case .verifyForgot:
            return "/auth/forgot-password/verify"
        case .register:
            return "/auth/register"
        case .resetPassword:
            return "/auth/reset-password"
        case .refreshToken:
            return "/auth/refresh-token"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .login(email, password):
            return ["email": email, "password": password]
        case let .sendEmail(email):
            return ["email": email]
        case let .verifyEmail(email, code):
            return ["email": email, "code": code]
        case let .sendForgot(email):
            return ["email": email]
        case let .verifyForgot(email, code):
            return ["email": email, "code": code]
        case let .register(email, password):
            return ["email": email, "password": password]
        case let .resetPassword(email, newPassword):
            return ["email": email, "newPassword": newPassword]
        case let .refreshToken(token):
            return ["refreshToken": token]
        }
    }
}


