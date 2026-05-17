//
//  InvPlanLayout.swift
//  Torium
//
//  Created by 최진모 on 3/7/26.
//

import SwiftUI

struct InvPlanLayout: View {
    let title: String
    let items: [AnyView]
    
    init(_ title: String, @LayoutBuilder items: @escaping () -> [AnyView]) {
        self.title = title
        self.items = items()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: - header title
            Header(title)

            //MARK: - body login fields
            VStack(alignment: .leading, spacing: 20) {
                items[0]
                items[1]
            }
            .padding(0)

            Spacer()

            //MARK: - footer button
            items[2]
                .padding(.top, 10)
                .padding(.bottom, 30)
                .padding(.horizontal, 20)
        }
        .background(Color.clear)
    }
}
