//
//  RootView.swift
//  Torium
//
//  Created by 최진모 on 1/9/26.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: StoreOf<RootFeature>

    var body: some View {
        Group {
            switch store.state {
            case .splash:
                SplashView(store: store.scope(state: \.splash, action: \.splash)!)
                
            case .auth:
                AuthFlowView(store: store.scope(state: \.auth, action: \.auth)!)
            
            case .main:
                MainFlowView(store: store.scope(state: \.main, action: \.main)!)
            }
        }
        .animation(.default, value: store.state)
    }
}
