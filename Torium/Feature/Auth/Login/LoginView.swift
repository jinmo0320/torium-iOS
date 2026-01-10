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
        VStack(spacing: 0) {
            //MARK: - header title
            HStack {
                Text("이메일로 로그인")
                    .font(.pretendard(.semibold, size: 24))
                    .foregroundStyle(Color.labelPrimary)
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)

            //MARK: - body login fields
            VStack(alignment: .leading, spacing: 16) {
                InputFieldView(text: $store.email, placeholder: "이메일")
                InputFieldView(text: $store.password, placeholder: "비밀번호", secure: true)

                VStack(alignment: .leading, spacing: 16) {
                    Text("계정이 없으신가요?")
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.brandPrimary)
                        .onTapGesture {
                            store.send(.registerTapped)
                        }
                    Text("비밀번호를 잊으셨나요?")
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.brandPrimary)
                        .onTapGesture {
                            store.send(.forgotPasswordTapped)
                        }
                }
                .padding(.horizontal, 10)
            }
            .padding(20)

            Spacer()

            //MARK: - footer button
            SubmitButtonView(text: "다음", loading: store.isLoading, disabled: false) {
                store.send(.loginTapped)
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
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
