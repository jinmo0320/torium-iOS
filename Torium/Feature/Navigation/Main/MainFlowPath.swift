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
    }
}
extension MainFlow.Path.State: Equatable {}
