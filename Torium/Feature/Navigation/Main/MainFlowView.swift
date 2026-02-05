//
//  MainFlowView.swift
//  Torium
//
//  Created by 최진모 on 2/5/26.
//
import ComposableArchitecture
import SwiftUI

struct MainFlowView: View {
    @Bindable var store: StoreOf<MainFlow>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            MainView(store: store.scope(state: \.main, action: \.main))
        } destination: { storePath in
        }
    }
}
