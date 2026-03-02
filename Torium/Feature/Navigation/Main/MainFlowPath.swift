//
//  MainFlowPath.swift
//  Torium
//
//  Created by 최진모 on 2/28/26.
//
import ComposableArchitecture
import Foundation

extension MainFlow {
    @Reducer
    enum Path {
        case createPortfolio(CreatePortfolioFeature)
        case createPortfolioInvestSurvey(SurveyFeature)
        case createPortfolioInvestSurveyResult(SurveyResultFeature)
    }
}
extension MainFlow.Path.State: Equatable {}

extension MainFlow.Path.State {
    var pathAnimation: MainFlow.Animation {
        switch self {
        case .createPortfolioInvestSurvey:
            return .up
        
        default: return .none
        }
    }
}
