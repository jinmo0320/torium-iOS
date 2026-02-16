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
                    case .login(let s):
                        LoginView(store: s)
                    case .registerEmail(let s):
                        RegisterEmailView(store: s)
                    case .registerVerify(let s):
                        RegisterVerifyView(store: s)
                    case .registerPassword(let s):
                        RegisterPasswordView(store: s)
                    case .registerSuccess(let s):
                        RegisterSuccessView(store: s)
                    case .forgotEmail(let s):
                        ForgotEmailView(store: s)
                    case .forgotVerify(let s):
                        ForgotVerifyView(store: s)
                    case .forgotPassword(let s):
                        ForgotPasswordView(store: s)
                    case .forgotSuccess(let s):
                        ForgotSuccessView(store: s)
                    }
                }
                .background(Color.Background)
            }
        }
    }
}
