//
//  MainFlow.swift
//  Torium
//
//  Created by 최진모 on 2/5/26.
//
import ComposableArchitecture

@Reducer
struct MainFlow {
    @ObservableState
    struct State: Equatable {
        var main = MainFeature.State()
        var path = StackState<Path.State>()
        
        var animation: Animation = .none
    }

    enum Action {
        case main(MainFeature.Action)
        case path(StackActionOf<Path>)
        
        case push(Path.State)
        case pop
        
        // Root View Action
        case delegate(RootFeature.NavigationDelegate)
    }
    
    enum Animation {
        case none
        case up
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.main, action: \.main) {
            MainFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .push(let path):
                state.animation = path.pathAnimation
                state.path.append(path)
                return .none
                
            case .pop:
                if let path = state.path.popLast() {
                    state.animation = path.pathAnimation
                }
                return .none
                
            case .main(.delegate(.goOut)):
                return .send(.delegate(.goSplash))
                
            case .main(.delegate(.goCreatePortfolio)):
                return .send(.push(.createPortfolio(CreatePortfolioFeature.State())))
                
            case .path(.element(id: _, action: let pathAction)):
                if pathAction.isCreatePortfolioFlow {
                    return MainFlow.reduceCreatePortfolioFlow(state: &state, action: pathAction)
                }
                
                return .none

            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

}
