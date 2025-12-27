//
//  SubmitButton.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct SubmitButtonView: View {
    let text: String
    let loading: Bool
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Group {
                if loading {
                    ProgressView()
                } else {
                    Text(text)
                }
            }
            .font(.pretendard(.medium, size: 16))
            .foregroundStyle(disabled || loading ? Color.labelDisabled : Color.labelWhite)
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 18)
        .background(disabled || loading ? Color.buttonDisabled : Color.buttonPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .disabled(disabled || loading)
    }
}

#Preview {
    SubmitButtonView(text: "다음", loading: false, disabled: false) {}
}

