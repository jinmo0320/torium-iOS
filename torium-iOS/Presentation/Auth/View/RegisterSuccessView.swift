//
//  RegisterSuccessView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct RegisterSuccessView: View {
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("회원가입이\n성공적으로 완료되었습니다!")
                    .font(.pretendard(.semibold, size: 20))
                    .multilineTextAlignment(.center)
                    .lineHeight(.loose)
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.brandPrimary)
            }
            .padding(.horizontal, 15)
            
            SubmitButtonView(text: "시작하기", loading: false, disabled: false) {}
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

#Preview {
    RegisterSuccessView()
}
