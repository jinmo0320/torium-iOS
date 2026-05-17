//
//  PlanFeature.swift
//  Torium
//
//  Created by 최진모 on 3/2/26.
//

import ComposableArchitecture

@Reducer
struct InvPlanFeature {
    @ObservableState
    struct State: Equatable {
        var value: String = ""
        var branch: Branch = .amount
    }
    
    enum Branch {
        case amount
        case period
        case target
        case yield
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case delegate(NavigationDelegate)
    }
    
    enum NavigationDelegate {
        case goOut
        case goBack
        case goStep1(Branch)
        case goStep2(Branch)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }

}
