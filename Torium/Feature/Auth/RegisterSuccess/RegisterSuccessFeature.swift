//
//  RegisterSuccessFeature.swift
//  Torium
//
//  Created by 최진모 on 1/4/26.
//

import ComposableArchitecture

@Reducer
struct RegisterSuccessFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool = false
    }

    enum Action {
        case nextTapped
        case nextResponse(Result<Void, Error>)
        
        case delegate(Delegate)
        enum Delegate {
            case goMain
        }
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .nextTapped:
                state.isLoading = true
                return .none
            case .nextResponse(.success):
                state.isLoading = false
                return .send(.delegate(.goMain))
            case .nextResponse(.failure(let error)):
                state.isLoading = false
                return .none
            default: return .none
            }
        }
    }
}
