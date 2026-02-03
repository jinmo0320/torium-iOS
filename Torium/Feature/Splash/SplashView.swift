//
//  SplashView.swift
//  Torium
//
//  Created by 최진모 on 1/22/26.
//
import ComposableArchitecture
import SwiftUI

struct SplashView: View {
    var store: StoreOf<SplashFeature>
    
    var body: some View {
        ZStack {
            if store.isLoading {
                ProgressView()
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    SplashView(
        store: Store(initialState: SplashFeature.State()) {
            SplashFeature()
        }
    )
}
