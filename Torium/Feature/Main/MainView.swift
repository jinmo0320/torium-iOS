//
//  MainView.swift
//  Torium
//
//  Created by 최진모 on 2/5/26.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    var store: StoreOf<MainFeature>
    
    var body: some View {
        VStack(spacing: 10) {
            Text("hello world")
            
            Button("logout") {
                store.send(.logoutTapped)
            }
            
            Button("create portfolio") {
                store.send(.createPortfolioTapped)
            }
        }
    }
}

#Preview {
    MainView(
        store: Store(initialState: MainFeature.State()) {
            MainFeature()
        }
    )
}
