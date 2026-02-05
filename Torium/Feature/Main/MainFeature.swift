//
//  MainFeature.swift
//  Torium
//
//  Created by 최진모 on 2/5/26.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct MainFeature {
    @ObservableState
    struct State: Equatable {
    }

    enum Action {
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
