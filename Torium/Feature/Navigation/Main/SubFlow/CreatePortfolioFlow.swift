//
//  CreatePortfolioFlow.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//
import ComposableArchitecture

extension MainFlow {
    static func reduceCreatePortfolioFlow(
        state: inout State,
        action: Path.Action
    ) -> Effect<Action> {

        switch action {
        case let act where act.isBack:
            return .send(.pop)

        // create -> survey
        case .createPortfolio(.delegate(.goInvestSurvey)):
            return .send(.push(.createPortfolioInvestSurvey(InvSurveyFeature.State())))
        
        // create -> plan
        case .createPortfolio(.InvestPlanTapped):
            return .send(.push(.createPortfolioInvsetPlan(InvPlanFeature.State())))
            
        // survey -> result
        case .createPortfolioInvestSurvey(.delegate(.goResult(let score))):
            return .send(.push(.createPortfolioInvestSurveyResult(InvSurveyResultFeature.State(score: score))))
        
        // result -> out
        case .createPortfolioInvestSurveyResult(.delegate(.goOut)):
            _ = state.path.popLast()
            return .send(.pop)

        default:
            return .none
        }

    }
}

extension MainFlow.Path.Action {
    var isCreatePortfolioFlow: Bool {
        switch self {
        case .createPortfolio,
            .createPortfolioInvestSurvey,
            .createPortfolioInvestSurveyResult,
            .createPortfolioInvsetPlan:
            return true

        default: return false
        }
    }

    var isBack: Bool {
        switch self {
        case .createPortfolio(.delegate(.goBack)),
            .createPortfolioInvestSurvey(.delegate(.goOut)),
            .createPortfolioInvestSurveyResult(.delegate(.goBack)),
            .createPortfolioInvsetPlan(.delegate(.goOut)):
            return true

        default: return false
        }
    }
}
