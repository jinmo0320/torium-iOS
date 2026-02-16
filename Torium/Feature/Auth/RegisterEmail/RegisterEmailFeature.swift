//
//  RegisterFeature.swift
//  Torium
//
//  Created by 최진모 on 1/1/26.
//

import ComposableArchitecture
import Foundation

@Reducer
struct RegisterEmailFeature {
    @ObservableState
    struct State: Equatable {
        var email: String = ""
        var isLoading: Bool = false
        var isIncorrectEmailFormat = true
        
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextTapped
        case nextResponse(Result<Void, Error>)
        case incorrectEmail
        
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {}
        
        case delegate(Delegate)
        enum Delegate {
            case goBack
            case goRoot
            case goVerify(String)
        }
    }

    @Dependency(\.authClient) var authClient

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.email):
                state.isIncorrectEmailFormat = true
                return .none
                
            case .binding:
                return .none
                
            case .nextTapped:
                state.isLoading = true
                
                if !Validator.validateEmail(state.email) {
                    return .send(.incorrectEmail)
                }
                
                return .run {
                    [email = state.email] send in
                    
                    await send(
                        .nextResponse(Result{ try await authClient.sendEmail(email) })
                    )
                }
                
            case .nextResponse(.success):
                state.isLoading = false
                return .send(.delegate(.goVerify(state.email)))
                
            case .nextResponse(.failure(let error)):
                state.isLoading = false
                state.alert = AlertState {
                    TextState("이메일 전송 실패")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none
                
            case .incorrectEmail:
                state.isLoading = false
                state.isIncorrectEmailFormat = false
                return .none
                
            default: return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
