//
//  Untitled.swift
//  Torium
//
//  Created by 최진모 on 3/1/26.
//

import SwiftUI

struct ProgressBarView: View {
    let cur: Float
    let max: Float
    
    @State private var maxSize: CGSize = .zero
    @State private var width: CGFloat = .zero

    var body: some View {
        HStack(spacing: 20) {
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .frame(height: 8)
                    .foregroundColor(Color.BlackSoft)
                    .measureSize($maxSize)
                
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: width, height: 8)
                    .foregroundColor(Color.BlackSteel)
                    .onChange(of: maxSize) {
                        width = maxSize.width * CGFloat(cur/max)
                    }
            }

            Text("\(Int(cur)) / \(Int(max))")
                .font(.pretendard(.semibold, size: 14))
                .foregroundStyle(Color.BlackPlaceholder)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 28)
    }
}

#Preview {
    ProgressBarView(cur: 3, max: 10)
}

