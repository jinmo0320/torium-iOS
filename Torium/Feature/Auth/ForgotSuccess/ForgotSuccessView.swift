//
//  ForgotSuccessView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct ForgotSuccessView: View {
    let store: StoreOf<ForgotSuccessFeature>

    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("비밀번호 재설정이\n성공적으로 완료되었습니다!")
                    .font(.pretendard(.semibold, size: 20))
                    .multilineTextAlignment(.center)
                    .lineHeight(.loose)
                Image(systemName: "lock.badge.checkmark.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.labelRed)
            }
            .padding(.horizontal, 15)

            SubmitButtonView(text: "로그인하러 가기", loading: false, disabled: false)
            {}
        }
        .fixedSize(horizontal: true, vertical: false)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ForgotSuccessView(
        store: Store(initialState: ForgotSuccessFeature.State()) {
            ForgotSuccessFeature()
        }
    )
}
