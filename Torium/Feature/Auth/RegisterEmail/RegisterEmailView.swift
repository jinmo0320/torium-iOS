//
//  RegisterEmailView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct RegisterEmailView: View {
    @Bindable var store: StoreOf<RegisterEmailFeature>

    var body: some View {
        AuthLayout {
            Header("이메일을 입력해 주세요")

            InputFieldView(
                text: $store.email,
                placeholder: "이메일",
                alert: store.isIncorrectEmailFormat
            )
            EmptyView()

            EmptyView()
            if store.isIncorrectEmailFormat {
                Label("이메일 형식이 올바르지 않습니다!", systemImage: "exclamationmark.circle.fill")
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
    RegisterEmailView(
        store: Store(initialState: RegisterEmailFeature.State()) {
            RegisterEmailFeature()
        }
    )
}
