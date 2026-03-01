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
    
    @State private var isPwdVisible: Bool = false
    
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
                    if !isPwdVisible {
                        SecureField (
                            "",
                            text: $text,
                            prompt: Text(placeholder)
                                .font(.pretendard(.regular, size: 16))
                                .foregroundStyle(Color.BlackPlaceholder)
                                .underline(false)
                        )
                    } else {
                        TextField (
                            "",
                            text: $text,
                            prompt: Text(placeholder)
                                .font(.pretendard(.regular, size: 16))
                                .foregroundStyle(Color.BlackPlaceholder)
                                .underline(false)
                        )
                    }

                    Spacer()
                    
                    if !isPwdVisible {
                        Button {
                            isPwdVisible = true
                        } label: {
                            Image(systemName: "eye.slash")
                                .font(.pretendard(.semibold, size: 12))
                                .foregroundStyle(Color.BlackSteel)
                        }
                    } else {
                        Button {
                            isPwdVisible = false
                        } label: {
                            Image(systemName: "eye")
                                .font(.pretendard(.semibold, size: 12))
                                .foregroundStyle(Color.BlackSteel)
                        }
                    }
                    
                    inline()
                        .underline(false)
                }
            } else {
                HStack {
                    TextField (
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .font(.pretendard(.regular, size: 16))
                            .foregroundStyle(Color.BlackPlaceholder)
                            .underline(false)
                    )
                    
                    Spacer()
                    
                    if !text.isEmpty {
                        Button {
                            text = ""
                        } label: {
                            Image(systemName: "xmark")
                                .font(.pretendard(.semibold, size: 12))
                                .foregroundStyle(Color.BlackSteel)
                        }
                    }
                    
                    inline()
                        .underline(false)
                }

            }
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 24)
        .font(.pretendard(.regular, size: 16))
        .foregroundStyle(alert ? Color.RedSoft: Color.BlackInk)
        .underline(alert)
        .id(alert)
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
