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
        var result: Status?
        
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case autoLogin
        case autoLoginResponse(Result<User, Error>)
        case animationCheckPointReached

        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {
            case retry
        }

        case delegate(RootFeature.NavigationDelegate)
    }
    
    enum Status: Equatable {
        case success
        case unauthorized
        case failed(String)
    }

    @Dependency(\.userClient) var userClient
    @Dependency(\.continuousClock) var clock

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .autoLogin:
                state.isLoading = true
                state.result = nil
                return .run { send in
                    await send(.autoLoginResponse(Result{ try await userClient.me() }))
                }

            case .autoLoginResponse(.success(_)):
                state.isLoading = false
                state.result = .success
                return .none

            case .autoLoginResponse(.failure(let error as AppError))
            where error == .unauthorized:
                state.isLoading = false
                state.result = .unauthorized
                return .none
            
            case .autoLoginResponse(.failure(let error)):
                state.isLoading = false
                state.result = .failed(error.localizedDescription)
                return .none

            case .alert(.presented(.retry)):
                return .send(.autoLogin)
                
            case .animationCheckPointReached:
                if let result = state.result, !state.isLoading {
                    switch result {
                    case .success:
                        return .send(.delegate(.goMain))
                    case .unauthorized:
                        return .send(.delegate(.goAuth))
                    case .failed(let desc):
                        state.alert = AlertState {
                            TextState("오류 발생")
                        } actions: {
                            ButtonState(action: .retry) {
                                TextState("확인")
                            }
                        } message: {
                            TextState(desc)
                        }
                        return .none
                    }
                }
                return .none

            default:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
