//
//  StepFeature.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//
import ComposableArchitecture

@Reducer
struct CreatePortfolioFeature{
    @ObservableState
    struct State: Equatable {
    }

    enum Action {
        case InvestSurveyTapped
        case InvestPlanTapped
        case ChartSetupTapped
        
        case delegate(NavigationDelegate)
    }
    
    enum NavigationDelegate {
        case goBack
        case goInvestSurvey
        case goInvestPlan
        case goChartSetup
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .InvestSurveyTapped:
                return .send(.delegate(.goInvestSurvey))
                
            case .InvestPlanTapped:
                return .send(.delegate(.goInvestPlan))
                
            case .ChartSetupTapped:
                return .send(.delegate(.goChartSetup))
                
            default:
                return .none
            }
        }
    }

}
