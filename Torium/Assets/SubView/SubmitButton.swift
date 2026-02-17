//
//  SubmitButton.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct SubmitButtonView: View {
    enum Variant {
        case primary
        case secondary
        case disabled
    }

    let text: String
    let type: Variant
    let action: () -> Void

    init(text: String, type: Variant = .primary, action: @escaping () -> Void) {
        self.text = text
        self.type = type
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.pretendard(.medium, size: 16))
                .foregroundStyle(
                    type == .disabled ? Color.White.opacity(0.6)
                    : type == .secondary ? Color.BlackSteel
                    : Color.white
                )
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 18)
        .background(
            type == .disabled ? Color.BlackPlaceholder
            : type == .secondary ? Color.Cloud
            : Color.BlackMidnight
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .disabled(type == .disabled)
    }
}

#Preview {
    SubmitButtonView(text: "다음", type: .primary) {}
}
