//
//  AuthRouter.swift
//  MemoWithTags
//
//  Created by 최진모 on 1/4/25.

import Alamofire
import Foundation

enum AuthRouter: Router {
    case login(AuthDTO.REQ.Sign)
    case sendEmail(AuthDTO.REQ.Email)
    case verifyEmail(AuthDTO.REQ.Verify)
    case sendForgot(AuthDTO.REQ.Email)
    case verifyForgot(AuthDTO.REQ.Verify)
    case register(AuthDTO.REQ.Sign)
    case resetPassword(AuthDTO.REQ.ResetPassword)
    case refreshToken(AuthDTO.REQ.Refresh)

    var method: HTTPMethod { .post }

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
    
    var body: (any Encodable)? {
        switch self {
        case .login(let req):
            encoded(req)
        case .register(let req):
            encoded(req)
        case .sendEmail(let req):
            encoded(req)
        case .sendForgot(let req):
            encoded(req)
        case .verifyEmail(let req):
            encoded(req)
        case .verifyForgot(let req):
            encoded(req)
        case .resetPassword(let req):
            encoded(req)
        case .refreshToken(let req):
            encoded(req)
        }
    }

    var requiresAuth: Bool { false }
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
                ErrorCode.EMAIL_ALREADY_REGISTERED
                    ~> RegisterEmailError.emailAlreadyRegistered
            }
        case .sendForgot:
            return ErrorMapper {
                ErrorCode.EMAIL_NOT_REGISTERED
                    ~> ForgotEmailError.emailNotRegistered
            }
        case .verifyEmail, .verifyForgot:
            return ErrorMapper {
                ErrorCode.EMAIL_VERIFICATION_FAILED
                    ~> VerificationError.verificationFailed
            }
        case .register, .resetPassword:
            return ErrorMapper {
                ErrorCode.EMAIL_NOT_VERIFIED
                    ~> SetPasswordError.emailNotVerified
            }
        default: return nil
        }
    }
}
