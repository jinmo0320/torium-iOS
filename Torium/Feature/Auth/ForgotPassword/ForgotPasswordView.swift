//
//  ForgotPasswordView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct ForgotPasswordView: View {
    @Bindable var store: StoreOf<ForgotPasswordFeature>

    var body: some View {
        AuthLayout {
            Header("비밀번호를 재설정해 주새요")

            InputFieldView(
                text: $store.password,
                placeholder: "비밀번호",
                secure: true,
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
                secure: true
            )

            EmptyView()
            VStack(alignment: .leading, spacing: 8) {
                if store.isIncorretPasswordFormat {
                    Text(
                        "\(Image(systemName: "exclamationmark.circle.fill")) 비밀번호 형식이 올바르지 않습니다!"
                    )
                    if !store.pwdFormat.alphabet {
                        Text("\(Image(systemName: "x.circle")) 알파벳")
                    }
                    if !store.pwdFormat.number {
                        Text("\(Image(systemName: "x.circle")) 숫자")
                    }
                    if !store.pwdFormat.specialCharacter {
                        Text("\(Image(systemName: "x.circle")) 특수문자(!@#$%^&*?~...)")
                    }
                    if !store.pwdFormat.length {
                        Text("\(Image(systemName: "x.circle")) 8자 이상")
                    }

                } else if store.isPasswordMismatch {
                    Text(
                        "\(Image(systemName: "exclamationmark.circle.fill")) 비밀번호가 일치하지 않습니다!"
                    )
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
    ForgotPasswordView(
        store: Store(initialState: ForgotPasswordFeature.State()) {
            ForgotPasswordFeature()
        }
    )
}
