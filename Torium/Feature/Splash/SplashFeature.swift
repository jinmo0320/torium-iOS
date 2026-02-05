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
    }

    enum Action {
        case onAppear
        case autoLogin
        case autoLoginResponse(Result<User, Error>)
        
        case delegate(Delegate)
        enum Delegate {
            case goMain(User)
            case goAuth
        }
    }

    @Dependency(\.continuousClock) var clock
    @Dependency(\.userClient) var userClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .autoLogin:
                state.isLoading = true
                return .run { send in
                    try await clock.sleep(for: .seconds(3))
                    await send(
                        .autoLoginResponse(Result{ try await userClient.me() })
                    )
                }

            case .autoLoginResponse(.success(let user)):
                state.isLoading = false
                return .send(.delegate(.goMain(user)))

            case .autoLoginResponse(.failure(_)):
                state.isLoading = false
                return .send(.delegate(.goAuth))

            default:
                return .none
            }
        }
    }
}
