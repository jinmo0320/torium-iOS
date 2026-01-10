//
//  NavigationFeature.swift
//  Torium
//
//  Created by 최진모 on 1/4/26.
//

import ComposableArchitecture

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
        case fullScreenFlow  // 커버 전체를 트리거할 케이스
    }

    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        @Presents var destination: Destination.State?

        var authMain = AuthMainFeature.State()
    }

    enum Action {
        case path(StackActionOf<Path>)
        case destination(PresentationAction<Destination.Action>)

        case authMain(AuthMainFeature.Action)

        case goBack
        case goRoot
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.authMain, action: \.authMain) {
            AuthMainFeature()
        }

        Reduce { state, action in
            switch action {
            case .goBack:
                _ = state.path.popLast()
                return .none

            case .goRoot:
                state.destination = nil
                return .none

            case .authMain(.delegate(.goLocalLogin)):
                state.path.removeAll()
                state.destination = .fullScreenFlow
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
                case .element(id: _, action: .login(.delegate(.goForgotpassword))):
                    state.path.append(.forgotEmail(ForgotEmailFeature.State()))
                    return .none
                    
                // register send -> verify
                case .element(id: _, action: .registerEmail(.delegate(.goVerify(let email)))):
                    state.path.append(.registerVerify(RegisterVerifyFeature.State(email: email)))
                    return .none
                
                // register verify -> password
                case .element(id: _, action: .registerVerify(.delegate(.goPassword(let email)))):
                    state.path.append(.registerPassword(RegisterPasswordFeature.State(email: email)))
                    return .none
                    
                // register password -> success
                case .element(id: _, action: .registerPassword(.delegate(.goSuccess))):
                    state.path.append(.registerSuccess(RegisterSuccessFeature.State()))
                    return .none
                    
                // register password -> root
                case .element(id: _, action: .registerPassword(.delegate(.goRoot))):
                    return .send(.goRoot)
                    
                // forgot send -> verify
                case .element(id: _, action: .forgotEmail(.delegate(.goVerify(let email)))):
                    state.path.append(.forgotVerify(ForgotVerifyFeature.State(email: email)))
                    return .none
                    
                // forgot verify -> password
                case .element(id: _, action: .forgotVerify(.delegate(.goPassword(let email)))):
                    state.path.append(.forgotPassword(ForgotPasswordFeature.State(email: email)))
                    return .none
                
                // forgot password -> success
                case .element(id: _, action: .forgotPassword(.delegate(.goSuccess))):
                    state.path.append(.forgotSuccess(ForgotSuccessFeature.State()))
                    return .none
                
                // forgot password -> root
                case .element(id: _, action: .forgotPassword(.delegate(.goRoot))):
                    return .send(.goRoot)

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
