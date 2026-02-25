//
//  StepFeature.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//
import ComposableArchitecture

@Reducer
struct StepFeature{
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
