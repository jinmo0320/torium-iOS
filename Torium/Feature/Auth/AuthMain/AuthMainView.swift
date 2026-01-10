//
//  AuthMainVIew.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct AuthMainView: View {
    let store: StoreOf<AuthMainFeature>

    var body: some View {
        VStack(spacing: 140) {
            Spacer()
            //MARK: - logo
            VStack(spacing: 30) {
                Image(.toriumLogo)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .shadow(
                        color: Color.black.opacity(0.15),
                        radius: 4,
                        x: 0,
                        y: 4
                    )

                Text("Torium")
                    .font(.redHat(.heavy, size: 36))
                    .foregroundStyle(Color.brandPrimary)
                    .shadow(
                        color: Color.black.opacity(0.15),
                        radius: 4,
                        x: 0,
                        y: 4
                    )
            }
            //MARK: - login buttons
            VStack(spacing: 10) {
                Button {
                    store.send(.localLoginTapped)
                } label: {
                    HStack(spacing: 10) {
                        Spacer()
                        Image(.toriumLogo)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(Color(hex: "#ECECEC"))
                            .frame(width: 20, height: 20)

                        Text("이메일로 계속하기")
                            .font(.pretendard(.medium, size: 16))
                            .foregroundStyle(Color(hex: "#ECECEC"))
                        Spacer()
                    }
                }
                .padding(.vertical, 18)
                .background(Color.buttonPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Button {
                    store.send(.kakaoLoginTapped)
                } label: {
                    HStack(spacing: 10) {
                        Spacer()
                        Image(.kakaoLogo)
                            .resizable()
                            .frame(width: 20, height: 18)

                        Text("카카오 계정으로 계속하기")
                            .font(.pretendard(.medium, size: 16))
                            .foregroundStyle(.black.opacity(0.85))
                        Spacer()
                    }
                }
                .padding(.vertical, 18)
                .background(Color(hex: "#FEE500"))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Button {
                    store.send(.googleLoginTapped)
                } label: {
                    HStack(spacing: 10) {
                        Spacer()
                        Image(.googleLogo)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Google 계정으로 계속하기")
                            .font(.pretendard(.medium, size: 16))
                            .foregroundStyle(Color(hex: "#1F1F1F"))
                        Spacer()
                    }
                }
                .padding(.vertical, 18)
                .background(Color(hex: "#F2F2F2"))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AuthMainView(
        store: Store(initialState: AuthMainFeature.State()) {
            AuthMainFeature()
        }
    )
}
