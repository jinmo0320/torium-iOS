//
//  InputFields.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct InputFieldView: View {
    @Binding var text: String
    let placeholder: String
    let showAlert: Bool
    let secure: Bool
    let disabled: Bool

    init(
        text: Binding<String>,
        placeholder: String,
        showAlert: Bool = false,
        secure: Bool = false,
        disabled: Bool = false
    ) {
        self._text = text // Binding 연결 시 언더바(_) 사용
        self.placeholder = placeholder
        self.showAlert = showAlert
        self.secure = secure
        self.disabled = disabled
    }
    
    var body: some View {
        Group {
            if secure {
                SecureField (
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.labelPlaceholder)
                )
            } else {
                TextField (
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.labelPlaceholder)
                )
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 24)
        .font(.pretendard(.regular, size: 16))
        .foregroundStyle(
            disabled ? Color.labelPlaceholder :
            showAlert ? Color.labelRed :
            Color.labelPrimary
        )
        .background(disabled ? Color(hex: "#EDEDED") : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(showAlert ? Color.labelRed : Color.borderPrimary, lineWidth: 1)
        )
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .disabled(disabled)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    InputFieldView(text: $text, placeholder: "안녕", showAlert: false, secure: false, disabled: true)
}
