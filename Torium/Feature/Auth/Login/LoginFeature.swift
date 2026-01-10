//
//  LoginFeature.swift
//  Torium
//
//  Created by 최진모 on 12/29/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?

        var email: String = ""
        var password: String = ""
        var isLoading: Bool = false
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case loginTapped
        case loginResponse(Result<User, Error>)

        case registerTapped
        case forgotPasswordTapped

        case delegate(Delegate)
        enum Delegate {
            case goRegister
            case goForgotpassword
        }

        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {
            case confirmTapped
        }
    }

    @Dependency(\.authClient) var authClient

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .loginTapped:
                state.isLoading = true
                return .run {
                    [email = state.email, password = state.password] send in
                    await send(
                        .loginResponse(
                            Result {
                                try await authClient.login(email, password)
                            }
                        )
                    )
                }

            case .loginResponse(.success(_)):
                state.isLoading = false
                return .none

            case .loginResponse(.failure(let error)):
                state.isLoading = false
                state.alert = AlertState {
                    TextState("로그인 실패")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }

                return .none

            case .registerTapped:
                return .send(.delegate(.goRegister))

            case .forgotPasswordTapped:
                return .send(.delegate(.goForgotpassword))

            default:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
