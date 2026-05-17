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
        case createPortfolioInvestSurvey(InvSurveyFeature)
        case createPortfolioInvestSurveyResult(InvSurveyResultFeature)
        case createPortfolioInvsetPlan(InvPlanFeature)
    }
}
extension MainFlow.Path.State: Equatable {}

extension MainFlow.Path.State {
    var pathAnimation: MainFlow.Animation {
        switch self {
        case .createPortfolioInvestSurvey, .createPortfolioInvsetPlan:
            return .up
        
        default: return .none
        }
    }
}
