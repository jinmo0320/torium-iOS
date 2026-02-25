//
//  SurveyFeature.swift
//  Torium
//
//  Created by 최진모 on 2/25/26.
//
import ComposableArchitecture

@Reducer
struct SurveyFeature{
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
