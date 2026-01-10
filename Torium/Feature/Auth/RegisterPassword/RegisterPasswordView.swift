//
//  RegisterPasswordView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct RegisterPasswordView: View {
    @Bindable var store: StoreOf<RegisterPasswordFeature>

    var body: some View {
        VStack(spacing: 0) {
            //MARK: - header title
            HStack {
                Text("비밀번호를 설정해 주세요.")
                    .font(.pretendard(.semibold, size: 24))
                    .foregroundStyle(Color.labelPrimary)
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)

            //MARK: - body register fields
            VStack(alignment: .leading, spacing: 16) {
                InputFieldView(
                    text: $store.email,
                    placeholder: "이메일",
                    disabled: true
                )
                InputFieldView(
                    text: $store.password,
                    placeholder: "비밀번호",
                    secure: true
                )
                InputFieldView(
                    text: $store.passwordRepeat,
                    placeholder: "비밀번호 확인",
                    secure: true
                )

                VStack(alignment: .leading, spacing: 8) {
                    if !store.isCorretPasswordFormat {
                        Text("비밀번호 형식이 올바르지 않습니다!")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(Color.labelRed)

                        Text(
                            "\(Image(systemName: store.pwdFormat.alphabet ? "checkmark.circle.fill" : "xmark.circle")) 알파벳"
                        )
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(
                            store.pwdFormat.alphabet
                                ? Color.labelGreen : Color.labelRed
                        )

                        Text(
                            "\(Image(systemName: store.pwdFormat.number ? "checkmark.circle.fill" : "xmark.circle")) 숫자"
                        )
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(
                            store.pwdFormat.number
                                ? Color.labelGreen : Color.labelRed
                        )

                        Text(
                            "\(Image(systemName: store.pwdFormat.specialCharacter ? "checkmark.circle.fill" : "xmark.circle")) 특수문자(!@#$%^&*?~)"
                        )
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(
                            store.pwdFormat.specialCharacter
                                ? Color.labelGreen : Color.labelRed
                        )

                        Text(
                            "\(Image(systemName: store.pwdFormat.length ? "checkmark.circle.fill" : "xmark.circle")) 8자 이상"
                        )
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(
                            store.pwdFormat.length
                                ? Color.labelGreen : Color.labelRed
                        )
                    }
                    else if !store.isPasswordMatch {
                        Text("비밀번호가 일치하지 않습니다.")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(Color.labelRed)
                    }
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
    RegisterPasswordView(
        store: Store(initialState: RegisterPasswordFeature.State()) {
            RegisterPasswordFeature()
        }
    )
}
