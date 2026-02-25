//
//  SurveyError.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//
import Foundation

enum SurveyError: Error, LocalizedError {
    case loadFailed
    case submitFailed

    public var errorDescription: String? {
        switch self {
        case .loadFailed: return "설문을 불러오는데 실패했습니다."
        case .submitFailed: return "설문조사 결과를 종합하는데 실패했습니다."
        }
    }
}
