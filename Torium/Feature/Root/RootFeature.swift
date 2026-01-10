//
//  RootFeature.swift
//  Torium
//
//  Created by 최진모 on 1/9/26.
//

import ComposableArchitecture

@Reducer
struct RootFeature {
    @ObservableState
    enum State: Equatable {
//        case splash(SplashFeature.State)
        case auth(AuthFlow.State)
        
        init() {
//            self = .splash(SplashFeature.State())
            self = .auth(AuthFlow.State())
        }
    }

    enum Action {
//        case splash(SplashFeature.Action)
        case auth(AuthFlow.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
//            case .splash(.delegate(.loginRequired)):
//                state = .login(LoginFeature.State())
//                return .none
                
            default:
                return .none
            }
        }
        .ifCaseLet(\.auth, action: \.auth) { AuthFlow() }
    }
}
