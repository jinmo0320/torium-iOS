//
//  Untitled.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                Text("이메일로 로그인")
                    .font(.pretendard(.semibold, size: 24))
                    .foregroundStyle(Color.labelPrimary)
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            
            //MARK: - body login fields
            VStack(alignment: .leading, spacing: 16) {
                InputFieldView(text: $email, placeholder: "이메일")
                InputFieldView(text: $password, placeholder: "비밀번호", secure: true)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("계정이 없으신가요?")
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.brandPrimary)
                    Text("비밀번호를 잊으셨나요?")
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.brandPrimary)
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
    LoginView()
}
