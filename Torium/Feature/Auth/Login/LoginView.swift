//
//  Untitled.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>

    var body: some View {
        AuthLayout {
            Header("이메일로 로그인")
            
            InputFieldView(text: $store.email, placeholder: "이메일")
            InputFieldView(text: $store.password, placeholder: "비밀번호", secure: true)
            
            VStack (alignment: .leading, spacing: 16) {
                Text("계정이 없으신가요?").onTapGesture { store.send(.registerTapped) }
                Text("비밀번호를 잊으셨나요?").onTapGesture { store.send(.forgotPasswordTapped) }
            }
            EmptyView()
            
            SubmitButtonView(text: "다음") { store.send(.loginTapped) }
        }
        .navigationBarBackButtonHidden()
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    LoginView(
        store: Store(initialState: LoginFeature.State()) {
            LoginFeature()
        }
    )
}
