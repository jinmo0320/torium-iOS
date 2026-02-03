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
        case loadingResponse(Result<Void, Error>)
    }

    @Dependency(\.continuousClock) var clock

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    try await clock.sleep(for: .seconds(5))
                    await send(
                        .loadingResponse(.success(()))
                    )
                }

            case .loadingResponse(.success):
                state.isLoading = false
                return .none

            case .loadingResponse(.failure(_)):
                state.isLoading = false
                return .none
                
            default:
                return .none
            }
        }
    }
}
