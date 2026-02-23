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
        VStack {
            Text("hello world")
            Button("logout") {
                store.send(.logoutTapped)
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
