//
//  ForgotVerifyView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct ForgotVerifyView: View {
    @Bindable var store: StoreOf<ForgotVerifyFeature>

    var body: some View {
        VStack(spacing: 0) {
            //MARK: - header title
            HStack {
                Text("인증을 완료해 주세요.")
                    .font(.pretendard(.semibold, size: 24))
                    .foregroundStyle(Color.labelPrimary)
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)

            //MARK: - body verification fields
            VStack(alignment: .leading, spacing: 16) {
                InputFieldView(text: $store.email, placeholder: "이메일", disabled: true)
                InputFieldView(text: $store.code, placeholder: "인증코드 6자리")
                    .keyboardType(.numberPad)

                VStack(alignment: .leading, spacing: 16) {
                    if store.isInvalidCode {
                        Text("잘못된 인증코드입니다!")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(Color.labelRed)
                    }

                    Text("남은 시간 05:00")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed).opacity(store.isInvalidCode ? 0.5 : 1)
                }
                .padding(.horizontal, 10)
            }
            .padding(20)

            Spacer()

            //MARK: - footer button
            SubmitButtonView(text: "다음", loading: false, disabled: false) {
                store.send(.nextTapped)
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    ForgotVerifyView(
        store: Store(initialState: ForgotVerifyFeature.State()) {
            ForgotVerifyFeature()
        }
    )
}
