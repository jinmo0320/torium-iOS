//
//  RegisterSuccessView.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import ComposableArchitecture
import SwiftUI

struct RegisterSuccessView: View {
    let store: StoreOf<RegisterSuccessFeature>

    var body: some View {
        ZStack {
            Color.Background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                VStack(spacing: 20) {
                    Text("회원가입이\n성공적으로 완료되었습니다!")
                        .font(.pretendard(.semibold, size: 20))
                        .foregroundStyle(Color.BlackInk)
                        .multilineTextAlignment(.center)
                        .lineHeight(.loose)
                    
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.Brand)
                }
                .padding(.horizontal, 15)

                SubmitButtonView(text: "시작하기") {
                    store.send(.nextTapped)
                }
            }
            .fixedSize(horizontal: true, vertical: false)
        }
    }
}

#Preview {
    RegisterSuccessView(
        store: Store(initialState: RegisterSuccessFeature.State()) {
            RegisterSuccessFeature()
        }
    )
}
