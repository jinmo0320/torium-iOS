//
//  UserRouter.swift
//  Torium
//
//  Created by 최진모 on 2/4/26.
//

import Alamofire
import Foundation

enum UserRouter: Router {
    case me
    case changePassword(oldPassword: String, newPassword: String)

    var baseURL: URL {
        return URL(string: NetworkConfiguration.localURL)!
    }

    var method: HTTPMethod {
        switch self {
        case .me:
            return .get
            
        case .changePassword:
            return .post
        }
    }

    var path: String {
        switch self {
        case .me:
            return "/user/me"
        case .changePassword:
            return "/user/me/password"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .changePassword(let oldPassword, let newPassword):
            return ["oldPassword": oldPassword, "newPassword": newPassword]
        default:
            return nil
        }
    }

    var requiresAuth: Bool {
        return true
    }
}

extension UserRouter {
    var errorMap: ErrorMapper? {
        switch self {
        case .changePassword:
            return ErrorMapper {
                ErrorCode.CURRENT_PASSWORD_NOT_MATCHED ~> ChangePasswordError.currentPasswordNotMatched
            }
        default:
            return nil
        }
    }
}
