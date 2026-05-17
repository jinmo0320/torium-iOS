//
//  SurveyRouter.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//

import Alamofire
import Foundation

enum SurveyRouter: Router {
    case get
    case submit(score: Int)
    case dump
    
    var baseURL: URL {
        return URL(string: NetworkConfiguration.baseURL)!
    }

    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
            
        case .submit:
            return .post
            
        case .dump:
            return .patch
        }
    }

    var path: String {
        switch self {
        case .get:
            return "/surveys/investment/questions"
        case .submit, .dump:
            return "/users/me/investment-profile/risk-type"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .submit(let score):
            return ["score": score]
        default:
            return nil
        }
    }

    var requiresAuth: Bool {
        return true
    }
}

extension SurveyRouter {
    var errorMap: ErrorMapper? {
        switch self {
        case .get:
            return ErrorMapper {
                ErrorCode.QUESTIONS_NOT_FOUND ~> SurveyError.loadFailed
            }
        case .submit:
            return ErrorMapper {
                ErrorCode.INVALID_RISK_SCORE ~> SurveyError.submitFailed
            }
        default:
            return nil
        }
    }
}
