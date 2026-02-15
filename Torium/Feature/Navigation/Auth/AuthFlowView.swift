//
//  AuthFlowView.swift
//  Torium
//
//  Created by 최진모 on 1/4/26.
//

import ComposableArchitecture
import SwiftUI

struct AuthFlowView: View {
    @Bindable var store: StoreOf<AuthFlow>

    var body: some View {
        AuthMainView(
            store: store.scope(state: \.authMain, action: \.authMain)
        )
        .fullScreenCover(
            item: $store.scope(state: \.destination, action: \.destination)
        ) { _ in
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                Color.clear
            } destination: { storePath in
                Group {
                    switch storePath.case {
                    case .login(let store):
                        LoginView(store: store)
                    case .registerEmail(let store):
                        RegisterEmailView(store: store)
                    case .registerVerify(let store):
                        RegisterVerifyView(store: store)
                    case .registerPassword(let store):
                        RegisterPasswordView(store: store)
                    case .registerSuccess(let store):
                        RegisterSuccessView(store: store)
                    case .forgotEmail(let store):
                        ForgotEmailView(store: store)
                    case .forgotVerify(let store):
                        ForgotVerifyView(store: store)
                    case .forgotPassword(let store):
                        ForgotPasswordView(store: store)
                    case .forgotSuccess(let store):
                        ForgotSuccessView(store: store)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            store.send(.goRoot)
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.BlackSteel)
                        }
                        .background(
                            Circle()
                                .fill(Color.BlackSoft)
                                .frame(width: 40, height: 40)
                        )
                    }
                    .sharedBackgroundVisibility(.hidden)
                }
                .toolbarBackground(Color.orange, for: .navigationBar)
                .onChange(of: store.path.count) {
                    print(store.path.count)
                }
            }
        }
    }
}
