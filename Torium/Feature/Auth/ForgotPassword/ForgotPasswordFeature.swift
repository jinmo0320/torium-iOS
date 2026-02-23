//
//  RegisterFeature.swift
//  Torium
//
//  Created by 최진모 on 1/1/26.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ForgotPasswordFeature {
    @ObservableState
    struct State: Equatable {
        var email: String = ""
        var password: String = ""
        var passwordRepeat: String = ""
        var isLoading: Bool = false
        var isIncorretPasswordFormat: Bool = false
        var isPasswordMismatch: Bool = false

        var pwdFormat: Validator.PasswordValidationResult = .init(
            alphabet: true,
            number: true,
            specialCharacter: true,
            length: true
        )

        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextTapped
        case nextResponse(Result<Void, Error>)
        case incorrectPasswordFormat
        case passwordMismatch

        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {
            case confirmTapped
            case returnTapped
        }

        case delegate(AuthFlow.NavigaitonDelegate)
    }

    @Dependency(\.authClient) var authClient

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.password):
                state.isIncorretPasswordFormat = false
                state.isPasswordMismatch = false
                return .none

            case .binding(\.passwordRepeat):
                state.isPasswordMismatch = false
                return .none

            case .binding:
                return .none

            case .nextTapped:
                state.isLoading = true

                state.pwdFormat = Validator.validatePassword(state.password)
                if !(state.pwdFormat.alphabet
                    && state.pwdFormat.number
                    && state.pwdFormat.specialCharacter
                    && state.pwdFormat.length)
                {
                    return .send(.incorrectPasswordFormat)
                }
                if state.password != state.passwordRepeat {
                    return .send(.passwordMismatch)
                }

                return .run {
                    [email = state.email, password = state.password] send in
                    await send(.nextResponse(Result{ try await authClient.resetPassword(email, password) }))
                }

            case .nextResponse(.success):
                state.isLoading = false
                return .send(.delegate(.goSuccess))

            case .nextResponse(.failure(let error as SetPasswordError))
            where error == .emailNotVerified:
                state.isLoading = false
                state.alert = AlertState {
                    TextState("회원가입 실패")
                } actions: {
                    ButtonState(action: .returnTapped) { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none

            case .nextResponse(.failure(let error)):
                state.isLoading = false
                state.alert = AlertState {
                    TextState("회원가입 실패")
                } actions: {
                    ButtonState(action: .confirmTapped) { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none

            case .alert(.presented(.returnTapped)):
                return .send(.delegate(.goBack))

            case .incorrectPasswordFormat:
                state.isLoading = false
                state.isIncorretPasswordFormat = true
                return .none

            case .passwordMismatch:
                state.isLoading = false
                state.isPasswordMismatch = true
                return .none

            default: return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
