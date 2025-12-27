//
//  ForgotPasswordView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var password: String = ""
    @State private var passwordRepeat: String = ""
    
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
                Text("비밀번호를 재설정해 주세요.")
                    .font(.pretendard(.semibold, size: 24))
                    .foregroundStyle(Color.labelPrimary)
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            
            //MARK: - body register fields
            VStack(alignment: .leading, spacing: 16) {
                InputFieldView(text: $password, placeholder: "새 비밀번호")
                InputFieldView(text: $passwordRepeat, placeholder: "새 비밀번호 확인")
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("비밀번호 형식이 올바르지 않습니다!")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed)
                        
                    Text("\(Image(systemName: "xmark.circle")) 알파벳")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed)
                    Text("\(Image(systemName: "xmark.circle")) 숫자")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed)
                    Text("\(Image(systemName: "xmark.circle")) 특수문자(!@#$%^&*?~)")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.labelRed)
                    Text("\(Image(systemName: "xmark.circle")) 8자 이상")
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
    ForgotPasswordView()
}
