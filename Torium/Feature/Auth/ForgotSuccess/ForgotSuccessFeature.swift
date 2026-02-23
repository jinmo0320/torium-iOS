//
//  RegisterSuccessFeature.swift
//  Torium
//
//  Created by 최진모 on 1/4/26.
//

import ComposableArchitecture

@Reducer
struct ForgotSuccessFeature {
    @ObservableState
    struct State: Equatable {
    }

    enum Action {
        case nextTapped
        
        case delegate(AuthFlow.NavigaitonDelegate)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .nextTapped:
                return .send(.delegate(.goLogin))
                
            default: return .none
            }
        }
    }
}
