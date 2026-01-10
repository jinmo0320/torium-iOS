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
        VStack(spacing: 0) {
            //MARK: - header title
            HStack {
                Text("이메일을 입력해 주세요")
                    .font(.pretendard(.semibold, size: 24))
                    .foregroundStyle(Color.labelPrimary)
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)

            //MARK: - body email fields
            VStack(alignment: .leading, spacing: 16) {
                InputFieldView(text: $store.email, placeholder: "이메일")
                
                if !store.isCorrectEmailFormat {
                    VStack(alignment: .leading) {
                        Text("이메일 형식이 올바르지 않습니다!")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(Color.labelRed)
                    }
                    .padding(.horizontal, 10)
                }
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
    RegisterEmailView(
        store: Store(initialState: RegisterEmailFeature.State()) {
            RegisterEmailFeature()
        }
    )
}
