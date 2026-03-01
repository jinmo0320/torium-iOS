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
                    .transition(.blurReplace)
                
            case .auth:
                AuthFlowView(store: store.scope(state: \.auth, action: \.auth)!)
                    .transition(.blurReplace)
            
            case .main:
                MainFlowView(store: store.scope(state: \.main, action: \.main)!)
                    .transition(.blurReplace)
            }
        }
        .animation(.default, value: store.state)
    }
}
