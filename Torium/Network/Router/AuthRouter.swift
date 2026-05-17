//
//  AuthRouter.swift
//  MemoWithTags
//
//  Created by 최진모 on 1/4/25.

import Alamofire
import Foundation

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
        return URL(string: NetworkConfiguration.baseURL)!
    }

    var method: HTTPMethod {
        switch self {
        case .register, .login, .resetPassword, .sendEmail, .verifyEmail,
            .sendForgot, .verifyForgot, .refreshToken:
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
            return "/auth/refresh"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        case .sendEmail(let email):
            return ["email": email]
        case .verifyEmail(let email, let code):
            return ["email": email, "code": code]
        case .sendForgot(let email):
            return ["email": email]
        case .verifyForgot(let email, let code):
            return ["email": email, "code": code]
        case .register(let email, let password):
            return ["email": email, "password": password]
        case .resetPassword(let email, let newPassword):
            return ["email": email, "newPassword": newPassword]
        case .refreshToken(let token):
            return ["refreshToken": token]
        }
    }

    var requiresAuth: Bool {
        return false
    }
}

extension AuthRouter {
    var errorMap: ErrorMapper? {
        switch self {
        case .login:
            return ErrorMapper {
                ErrorCode.WRONG_EMAIL_FORMAT ~> LoginError.loginFailed
                ErrorCode.WRONG_PASSWORD_FORMAT ~> LoginError.loginFailed
                ErrorCode.LOGIN_FAILED ~> LoginError.loginFailed
            }
        case .sendEmail:
            return ErrorMapper {
                ErrorCode.EMAIL_ALREADY_REGISTERED ~> RegisterEmailError.emailAlreadyRegistered
            }
        case .sendForgot:
            return ErrorMapper {
                ErrorCode.EMAIL_NOT_REGISTERED ~> ForgotEmailError.emailNotRegistered
            }
        case .verifyEmail, .verifyForgot:
            return ErrorMapper {
                ErrorCode.EMAIL_VERIFICATION_FAILED ~> VerificationError.verificationFailed
            }
        case .register, .resetPassword:
            return ErrorMapper {
                ErrorCode.EMAIL_NOT_VERIFIED ~> SetPasswordError.emailNotVerified
            }
        default: return nil
        }
    }
}
