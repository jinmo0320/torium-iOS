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
        case splash(SplashFeature.State)
        case auth(AuthFlow.State)
        case main(MainFlow.State)
        
        init() {
            self = .splash(SplashFeature.State())
        }
    }

    enum Action {
        case splash(SplashFeature.Action)
        case auth(AuthFlow.Action)
        case main(MainFlow.Action)
    }
    
    enum NavigationDelegate {
        case goAuth
        case goMain
        case goSplash
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .splash(.delegate(.goAuth)):
                state = .auth(AuthFlow.State())
                return .none
            
            case .splash(.delegate(.goMain)):
                state = .main(MainFlow.State())
                return .none
                
            case .auth(.delegate(.goMain)):
                state = .main(MainFlow.State())
                return .none
                
            case .main(.delegate(.goSplash)):
                state = .splash(SplashFeature.State())
                return .none
                
            default:
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) { SplashFeature() }
        .ifCaseLet(\.auth, action: \.auth) { AuthFlow() }
        .ifCaseLet(\.main, action: \.main) { MainFlow() }
    }
}
