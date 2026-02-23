//
//  MainFlow.swift
//  Torium
//
//  Created by 최진모 on 2/5/26.
//
import ComposableArchitecture

@Reducer
struct MainFlow {
    @Reducer
    enum Path {
    }

    @ObservableState
    struct State: Equatable {
        var main = MainFeature.State()
        var path = StackState<Path.State>()
    }

    enum Action {
        case main(MainFeature.Action)
        case path(StackActionOf<Path>)
        case goBack
        
        case delegate(RootFeature.NavigationDelegate)
    }
    
    enum NavigationDelegate {
        case goOut
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.main, action: \.main) {
            MainFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .goBack:
                _ = state.path.popLast()
                return .none
            
            case .main(.delegate(.goOut)):
                return .send(.delegate(.goSplash))

            case .path(let action):
                switch action {
                default:
                    return .none
                }

            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

}
extension MainFlow.Path.State: Equatable {}
