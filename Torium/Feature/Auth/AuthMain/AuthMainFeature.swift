//
//  AuthMainFeature.swift
//  Torium
//
//  Created by 최진모 on 1/4/26.
//

import ComposableArchitecture

@Reducer
struct AuthMainFeature {
    @ObservableState
    struct State: Equatable {
    }

    enum Action {
        case localLoginTapped
        case googleLoginTapped
        case kakaoLoginTapped

        case delegate(Delegate)
        enum Delegate {
            case goLocalLogin
        }
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .localLoginTapped:
                return .send(.delegate(.goLocalLogin))
            case .googleLoginTapped:
                return .none
            case .kakaoLoginTapped:
                return .none
            default:
                return .none
            }
        }
    }
}
