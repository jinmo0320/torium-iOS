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
        case logoutTapped
        case logoutResponse(Void)
        
        case createPortfolioTapped
        
        case delegate(NavigationDelegate)
    }
    
    enum NavigationDelegate {
        case goOut
        case goCreatePortfolio
    }
    
    @Dependency(\.authClient) var authClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .logoutTapped:
                return .run { send in
                    await send(.logoutResponse(await authClient.logout()))
                }
                
            case .logoutResponse:
                return .send(.delegate(.goOut))
                
            case .createPortfolioTapped:
                return .send(.delegate(.goCreatePortfolio))
                
            default:
                return .none
            }
        }
    }
}
