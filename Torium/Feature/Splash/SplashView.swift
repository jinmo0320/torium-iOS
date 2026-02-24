//
//  SplashView.swift
//  Torium
//
//  Created by 최진모 on 1/22/26.
//
import ComposableArchitecture
import SwiftUI

struct SplashView: View {
    @Bindable var store: StoreOf<SplashFeature>

    var body: some View {
        ZStack {
            LoadingAnimationView(phase: $store.animation)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        }
        .onAppear {
            store.send(.autoLogin)
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    SplashView(
        store: Store(initialState: SplashFeature.State()) {
            SplashFeature()
        }
    )
}
