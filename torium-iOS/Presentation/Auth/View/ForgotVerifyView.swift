//
//  ForgotVerifyView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct ForgotVerifyView: View {
    @State var email: String = ""
    @State private var code: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: - navigation bar
            HStack {
                Spacer()
                Image(.xbutton)
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            
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
                InputFieldView(text: $email, placeholder: "이메일", disabled: true)
                InputFieldView(text: $code, placeholder: "인증코드 6자리")
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("잘못된 인증코드입니다!")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed)
                    
                    Text("남은 시간 05:00")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed).opacity(0.5)
                }
                .padding(.horizontal, 10)
            }
            .padding(20)
            
            Spacer()
            
            //MARK: - footer button
            SubmitButtonView(text: "다음", loading: false, disabled: false) {}
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    ForgotVerifyView(email: "jinmo040320@gmail.com")
}
