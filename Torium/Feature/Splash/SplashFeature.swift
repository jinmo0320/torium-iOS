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
        var animation: AnimationPhase = .open
        var status: LoadingStatus = .loading
        
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
    
    nonisolated enum AnimationPhase: Equatable {
        case open
        case stop
        case close
    }
    
    nonisolated enum LoadingStatus: Equatable {
        case loading
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
            case .binding(\.animation):
                if state.animation == .stop {
                    return .send(.animationCheckPointReached)
                }
                return .none
                
            case .autoLogin:
                state.status = .loading
                return .run { send in
                    await send(.autoLoginResponse(Result{ try await userClient.me() }))
                }

            case .autoLoginResponse(.success(_)):
                state.status = .success
                return .none

            case .autoLoginResponse(.failure(let error as AppError))
            where error == .unauthorized:
                state.status = .unauthorized
                return .none
            
            case .autoLoginResponse(.failure(let error)):
                state.status = .failed(error.localizedDescription)
                return .none

            case .alert(.presented(.retry)):
                state.animation = .close
                return .send(.autoLogin)
                
            case .animationCheckPointReached:
                switch state.status {
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
                    
                case .loading:
                    state.animation = .close
                    return .none
                }

            default:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
