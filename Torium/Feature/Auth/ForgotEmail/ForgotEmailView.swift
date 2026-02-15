//
//  ForgotEmailView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct ForgotEmailView: View {
    @Bindable var store: StoreOf<ForgotEmailFeature>

    var body: some View {
        AuthLayout {
            Header("가입한 이메일을 입력해 주세요")
            
            InputFieldView(text: $store.email, placeholder: "이메일")
            EmptyView()
            
            EmptyView()
            if !store.isCorrectEmailFormat {
                Text("\(Image(systemName: "exclamationmark.circle.fill")) 이메일 형식이 올바르지 않습니다!")
            }
            
            SubmitButtonView(text: "다음") {
                store.send(.nextTapped)
            }
        }
        .navigationBarBackButtonHidden()
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    ForgotEmailView(
        store: Store(initialState: ForgotEmailFeature.State()) {
            ForgotEmailFeature()
        }
    )
}
