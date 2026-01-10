//
//  RegisterFeature.swift
//  Torium
//
//  Created by 최진모 on 1/1/26.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ForgotVerifyFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        
        var email: String = ""
        var code: String = ""
        var isLoading: Bool = false
        var isInvalidCode: Bool = false
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextTapped
        case nextResponse(Result<Void, Error>)
        
        case delegate(Delegate)
        enum Delegate {
            case goPassword(String)
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
            case .binding(\.code):
                state.isInvalidCode = false
                return .none
                
            case .binding:
                return .none
                
            case .nextTapped:
                state.isLoading = true
                return .run {
                    [email = state.email, code = state.code] send in
                    await send(
                        .nextResponse(Result{ try await authClient.verifyForgot(email, code)})
                    )
                }
                
            case .nextResponse(.success):
                state.isLoading = false
                return .send(.delegate(.goPassword(state.email)))
                
            case .nextResponse(.failure(let error)):
                state.isLoading = false
                if let verifyError = error as? ForgotVerifyError,
                   verifyError == .verificationFailed {
                    state.isInvalidCode = true
                    return .none
                }
                
                state.isInvalidCode = false
                state.alert = AlertState {
                    TextState("인증 실패")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none
                
            default: return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
