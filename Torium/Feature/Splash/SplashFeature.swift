//
//  SplashFeature.swift
//  Torium
//
//  Created by 최진모 on 1/22/26.
//
import ComposableArchitecture
import SwiftUI

@Reducer
struct SplashFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool = false
        
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case autoLogin
        case autoLoginResponse(Result<User, Error>)
        
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {}
        
        case delegate(RootFeature.NavigationDelegate)
    }

    @Dependency(\.userClient) var userClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .autoLogin:
                state.isLoading = true
                return .run { send in
                    await send(.autoLoginResponse(Result{ try await userClient.me() }))
                }

            case .autoLoginResponse(.success(_)):
                state.isLoading = false
                return .send(.delegate(.goMain))

            case .autoLoginResponse(.failure(let error)):
                state.isLoading = false
                state.alert = AlertState {
                    TextState("에러 발생")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .send(.delegate(.goAuth))
                
            default:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
