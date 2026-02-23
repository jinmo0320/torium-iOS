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
                placeholder: "인증번호",
                alert: store.isInvalidCode,
                inline: {
                    Text(
                        store.isLoading
                            ? ""
                            : store.isSuccessResend
                                ? "\(Image(systemName: "checkmark"))" : "재발송"
                    )
                    .font(.pretendard(.semibold, size: 15))
                    .foregroundStyle(Color.Brand)
                    .onTapGesture {
                        if !store.isLoading && !store.isSuccessResend {
                            store.send(.resendTapped)
                        }
                    }
                }
            )
            EmptyView()

            EmptyView()
            Group {
                if store.isInvalidCode {
                    Label("잘못된 인증번호입니다!", systemImage: "exclamationmark.circle.fill")
                } else {
                    Text(store.timerDisplay)
                }
            }.onAppear { store.send(.onAppear) }


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
    RegisterVerifyView(
        store: Store(initialState: RegisterVerifyFeature.State()) {
            RegisterVerifyFeature()
        }
    )
}
