//
//  InputFields.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

struct InputFieldView<Content: View>: View {
    @Binding var text: String
    let placeholder: String
    let secure: Bool
    let alert: Bool
    let inline: () -> Content
    
    init(
        text: Binding<String>,
        placeholder: String,
        secure: Bool = false,
        alert: Bool = false,
        @ViewBuilder inline: @escaping () -> Content = { EmptyView() }
    ) {
        self._text = text // Binding 연결 시 언더바(_) 사용
        self.placeholder = placeholder
        self.secure = secure
        self.alert = alert
        self.inline = inline
    }
    
    var body: some View {
        Group {
            if secure {
                HStack {
                    SecureField (
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .font(.pretendard(.regular, size: 16))
                            .foregroundStyle(Color.BlackPlaceholder)
                    )
                    Spacer()
                    inline()
                }
            } else {
                HStack {
                    TextField (
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .font(.pretendard(.regular, size: 16))
                            .foregroundStyle(Color.BlackPlaceholder)
                    )
                    
                    Spacer()
                    inline()
                }

            }
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 24)
        .font(.pretendard(.regular, size: 16))
        .foregroundStyle(alert ? Color.RedWarning : Color.BlackInk)
        .underline(alert ? true : false)
        .background(Color.BlackSoft)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    InputFieldView(text: $text, placeholder: "안녕") {}
}
