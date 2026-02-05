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
        ZStack {
            Text("hello world")
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
