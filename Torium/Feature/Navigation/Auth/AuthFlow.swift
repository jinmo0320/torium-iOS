//
//  NavigationFeature.swift
//  Torium
//
//  Created by 최진모 on 1/4/26.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AuthFlow {
    @Reducer
    enum Path {
        case login(LoginFeature)

        case registerEmail(RegisterEmailFeature)
        case registerVerify(RegisterVerifyFeature)
        case registerPassword(RegisterPasswordFeature)
        case registerSuccess(RegisterSuccessFeature)

        case forgotEmail(ForgotEmailFeature)
        case forgotVerify(ForgotVerifyFeature)
        case forgotPassword(ForgotPasswordFeature)
        case forgotSuccess(ForgotSuccessFeature)
    }

    @Reducer
    enum Destination {
        case fullScreen
    }
    
    @ObservableState
    struct State: Equatable {
        var authMain = AuthMainFeature.State()
        var path = StackState<Path.State>()
        @Presents var destination: Destination.State?
    }

    enum Action {
        case authMain(AuthMainFeature.Action)
        case path(StackActionOf<Path>)
        case destination(PresentationAction<Destination.Action>)
        
        case pop
        case close
        
        case delegate(RootFeature.NavigationDelegate)
    }
    
    enum NavigaitonDelegate {
        case goRoot
        case goBack
        case goLogin
        case goMain
        case goRegister
        case goForgot
        case goVerify(String, Date)
        case goPassword(String)
        case goSuccess
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.authMain, action: \.authMain) {
            AuthMainFeature()
        }

        Reduce { state, action in
            switch action {
            case .pop:
                _ = state.path.popLast()
                return .none

            case .close:
                state.destination = nil
                return .none

            case .authMain(.delegate(.goLocalLogin)):
                state.destination = .fullScreen
                state.path.removeAll()
                state.path.append(.login(LoginFeature.State()))
                return .none

            case .path(let action):
                switch action {
                // login -> register
                case .element(id: _, action: .login(.delegate(.goRegister))):
                    state.path.append(
                        .registerEmail(RegisterEmailFeature.State())
                    )
                    return .none
                    
                // login -> forgotPassword
                case .element(id: _, action: .login(.delegate(.goForgot))):
                    state.path.append(.forgotEmail(ForgotEmailFeature.State()))
                    return .none
                    
                // login -> main
                case .element(id: _, action: .login(.delegate(.goMain))):
                    return .send(.delegate(.goMain))
                    
                // register send -> verify
                case .element(id: _, action: .registerEmail(.delegate(.goVerify(let email, let expiredAt)))):
                    state.path.append(.registerVerify(RegisterVerifyFeature.State(email: email, expiredAt: expiredAt)))
                    return .none
                
                // register verify -> password
                case .element(id: _, action: .registerVerify(.delegate(.goPassword(let email)))):
                    state.path.append(.registerPassword(RegisterPasswordFeature.State(email: email)))
                    return .none
                    
                // register password -> success
                case .element(id: _, action: .registerPassword(.delegate(.goSuccess))):
                    state.path.append(.registerSuccess(RegisterSuccessFeature.State()))
                    return .none
                    
                // register success -> main
                case .element(id: _, action: .registerSuccess(.delegate(.goMain))):
                    return .send(.delegate(.goMain))
                
                // forgot send -> verify
                case .element(id: _, action: .forgotEmail(.delegate(.goVerify(let email, let expiredAt)))):
                    state.path.append(.forgotVerify(ForgotVerifyFeature.State(email: email, expiredAt: expiredAt)))
                    return .none
                    
                // forgot verify -> password
                case .element(id: _, action: .forgotVerify(.delegate(.goPassword(let email)))):
                    state.path.append(.forgotPassword(ForgotPasswordFeature.State(email: email)))
                    return .none
                
                // forgot password -> success
                case .element(id: _, action: .forgotPassword(.delegate(.goSuccess))):
                    state.path.append(.forgotSuccess(ForgotSuccessFeature.State()))
                    return .none
                
                // forgot success -> login
                case .element(id: _, action: .forgotSuccess(.delegate(.goLogin))):
                    state.path.removeAll()
                    state.path.append(.login(LoginFeature.State()))
                    return .none
                    
                // 공통 goRoot 처리
                case .element(id: _, action: let action) where action.isGoRoot:
                    return .send(.close)
                
                // 공통 goBack 처리
                case .element(id: _, action: let action) where action.isGoBack:
                    return .send(.pop)
                    
                // 공통 goBack 특수 케이스 처리
                case .element(id: _, action: let action) where action.isGoInit:
                    _ = state.path.popLast()
                    _ = state.path.popLast()
                    return .none

                default:
                    return .none
                }

            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

}
extension AuthFlow.Path.State: Equatable {}
extension AuthFlow.Path.Action {
    var isGoRoot: Bool {
        switch self {
        case .login(.delegate(.goRoot)),
             .registerEmail(.delegate(.goRoot)),
             .registerVerify(.delegate(.goRoot)),
             .registerPassword(.delegate(.goRoot)),
             .forgotEmail(.delegate(.goRoot)),
             .forgotVerify(.delegate(.goRoot)),
             .forgotPassword(.delegate(.goRoot)):
            return true
        default:
            return false
        }
    }
    var isGoBack: Bool {
        switch self {
        case .registerEmail(.delegate(.goBack)),
             .registerVerify(.delegate(.goBack)),
             .forgotEmail(.delegate(.goBack)),
             .forgotVerify(.delegate(.goBack)):
            return true
        default:
            return false
        }
    }
    var isGoInit: Bool {
        switch self {
        case .registerPassword(.delegate(.goBack)),
             .forgotPassword(.delegate(.goBack)):
            return true
        default:
            return false
        }
    }
}
