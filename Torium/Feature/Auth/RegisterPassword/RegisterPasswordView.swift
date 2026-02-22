//
//  RegisterPasswordView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct RegisterPasswordView: View {
    @Bindable var store: StoreOf<RegisterPasswordFeature>

    var body: some View {
        AuthLayout {
            Header("비밀번호를 설정해 주새요")

            InputFieldView(
                text: $store.password,
                placeholder: "비밀번호",
                secure: true,
                alert: store.isIncorretPasswordFormat,
                inline: {
                    if store.password.count < 8 {
                        Text("\(store.password.count)/8")
                            .font(.pretendard(.semibold, size: 15))
                            .foregroundStyle(Color.BlackPlaceholder)
                    }
                }
            )

            InputFieldView(
                text: $store.passwordRepeat,
                placeholder: "비밀번호 확인",
                secure: true,
                alert: store.isPasswordMismatch
            )

            EmptyView()
            VStack(alignment: .leading, spacing: 8) {
                if store.isIncorretPasswordFormat {
                    Label("비밀번호 형식이 올바르지 않습니다!", systemImage: "exclamationmark.circle.fill")
                    if !store.pwdFormat.alphabet {
                        Label("알파벳", systemImage: "x.circle")
                    }
                    if !store.pwdFormat.number {
                        Label("숫자", systemImage: "x.circle")
                    }
                    if !store.pwdFormat.specialCharacter {
                        Label("특수문자(!@#$%^&*?~...)", systemImage: "x.circle")
                    }
                    if !store.pwdFormat.length {
                        Label("8자 이상", systemImage: "x.circle")
                    }

                } else if store.isPasswordMismatch {
                    Label("비밀번호가 일치하지 않습니다!", systemImage: "exclamationmark.circle.fill")
                }
            }

            SubmitButtonView(
                text: "다음",
                type: store.isLoading ? .disabled : .primary
            ) { store.send(.nextTapped) }
        }
        .navbar(
            back: { store.send(.delegate(.goBack)) },
            root: { store.send(.delegate(.goRoot)) }
        )
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    RegisterPasswordView(
        store: Store(initialState: RegisterPasswordFeature.State()) {
            RegisterPasswordFeature()
        }
    )
}
