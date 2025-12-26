//
//  RegisterEmailView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct RegisterEmailView: View {
    @State private var email: String = ""
    
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
                Text("이메일을 입력해 주세요")
                    .font(.pretendard(.semibold, size: 24))
                    .foregroundStyle(Color.labelPrimary)
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            
            //MARK: - body login fields
            VStack(alignment: .leading, spacing: 16) {
                InputFieldView(text: $email, placeholder: "이메일")
                
                VStack(alignment: .leading) {
                    Text("이메일 형식이 올바르지 않습니다!")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed)
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
    RegisterEmailView()
}
