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
        @Presents var alert: AlertState<Action.Alert>?
        
        var email: String = ""
        var password: String = ""
        var passwordRepeat: String = ""
        var isLoading: Bool = false

        var pwdFormat: Validator.PasswordValidationResult = .init(
            alphabet: true,
            number: true,
            specialCharacter: true,
            length: true
        )
        var isCorretPasswordFormat: Bool {
            pwdFormat.alphabet
            && pwdFormat.number
            && pwdFormat.specialCharacter
            && pwdFormat.length
        }
        var isPasswordMatch: Bool {
            password == passwordRepeat
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextTapped
        case nextResponse(Result<Void, Error>)
        
        case delegate(Delegate)
        enum Delegate {
            case goSuccess
            case goRoot
        }
        
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {
            case confirmTapped
            case returnTapped
        }
    }

    @Dependency(\.authClient) var authClient

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.password):
                state.pwdFormat = Validator.validatePassword(state.password)
                return .none
                
            case .binding:
                return .none
                
            case .nextTapped:
                state.isLoading = true
                
                state.pwdFormat = Validator.validatePassword(state.password)
                if !state.isCorretPasswordFormat {
                    return .none
                }
                if !state.isPasswordMatch {
                    return .none
                }
                
                return .run {
                    [email = state.email, password = state.password] send in
                    await send(
                        .nextResponse(Result {try await authClient.resetPassword(email, password)})
                    )
                }
                
            case .nextResponse(.success):
                state.isLoading = false
                return .send(.delegate(.goSuccess))
                
            case .nextResponse(.failure(let error)):
                print(error)
                state.isLoading = false
                if let verifyError = error as? ForgotPasswordError,
                   verifyError == .emailNotVerified {
                    state.alert = AlertState {
                        TextState("비밀번호 재설정 실패")
                    } actions: {
                        ButtonState(action: .returnTapped) { TextState("확인") }
                    } message: {
                        TextState(error.localizedDescription)
                    }
                } else {
                    state.alert = AlertState {
                        TextState("비밀번호 재설정 실패")
                    } actions: {
                        ButtonState(action: .confirmTapped) { TextState("확인") }
                    } message: {
                        TextState(error.localizedDescription)
                    }
                }
                return .none
                
            case .alert(.presented(.returnTapped)):
                return .send(.delegate(.goRoot))
                
            default: return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
