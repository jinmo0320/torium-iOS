//
//  ToriumApp.swift
//  Torium
//
//  Created by 최진모 on 12/29/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct ToriumApp: App {
    static let store = Store(initialState: RootFeature.State()) {
        RootFeature()
    }

    var body: some Scene {
        WindowGroup {
            RootView(store: ToriumApp.store)
        }
    }
}
