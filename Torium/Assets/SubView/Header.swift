//
//  Header.swift
//  Torium
//
//  Created by 최진모 on 2/15/26.
//
import SwiftUI

struct Header: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.pretendard(.semibold, size: 24))
                .foregroundStyle(Color.BlackInk)
            Spacer()
        }
        .padding(.vertical, 22)
        .padding(.horizontal, 24)
    }
}
