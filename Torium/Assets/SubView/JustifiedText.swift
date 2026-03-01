//
//  JustifiedText.swift
//  Torium
//
//  Created by 최진모 on 3/2/26.
//
import SwiftUI

struct JustifiedText: UIViewRepresentable {
    var text: String

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .justified // UIKit의 양쪽 정렬
        label.lineBreakMode = .byWordWrapping
        
        // 정렬을 완벽하게 맞추기 위한 하이픈 설정 (선택 사항)
        label.allowsDefaultTighteningForTruncation = true
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}
