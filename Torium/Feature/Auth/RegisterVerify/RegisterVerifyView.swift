//
//  RegisterVerifyView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct RegisterVerifyView: View {
    @Bindable var store: StoreOf<RegisterVerifyFeature>

    var body: some View {
        AuthLayout {
            Header("인증을 완료해 주세요")

            InputFieldView(
                text: $store.code,
                placeholder: "이메일",
                inline: {
                    Text("재발송")
                        .font(.pretendard(.semibold, size: 15))
                        .foregroundStyle(Color.Brand)
                }
            )
            EmptyView()

            EmptyView()
            Text("05:00")

            SubmitButtonView(text: "다음") {
                store.send(.nextTapped)
            }
        }
        .navigationBarBackButtonHidden()
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    RegisterVerifyView(
        store: Store(initialState: RegisterVerifyFeature.State()) {
            RegisterVerifyFeature()
        }
    )
}
