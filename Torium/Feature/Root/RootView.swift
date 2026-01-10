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
        // NavigationStack 없이 상태에 따라 뷰 자체를 교체
        Group {
            switch store.state {
            case .auth:
                if let childStore = store.scope(state: \.auth, action: \.auth) {
                    AuthFlowView(store: childStore)
                }
            }
        }
        .animation(.default, value: store.state)
    }
}
