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
            state.path.append(.createPortfolioInvestSurvey(SurveyFeature.State()))
            return .none
            
        // survey -> result
        case .createPortfolioInvestSurvey(.delegate(.goResult(let score))):
            state.path.append(.createPortfolioInvestSurveyResult(SurveyResultFeature.State(score: score)))
            return .none
            
        default:
            return .none
        }
        
    }
}


extension MainFlow.Path.Action {
    var isCreatePortfolioFlow: Bool {
        switch self {
        case .createPortfolio, .createPortfolioInvestSurvey, .createPortfolioInvestSurveyResult:
            return true
            
        default: return false
        }
    }
    
    var isBack: Bool {
        switch self {
        case .createPortfolio(.delegate(.goBack)), .createPortfolioInvestSurvey(.delegate(.goOut)):
            return true
            
        default: return false
        }
    }
}

