//
//  AuthLayout.swift
//  Torium
//
//  Created by 최진모 on 2/15/26.
//
import SwiftUI

@resultBuilder
struct AuthLayoutBuilder {
    static func buildBlock(_ components: [AnyView]...) -> [AnyView] {
        return components.flatMap { $0 }
    }

    // 각 요소를 AnyView 배열로 변환하는 기본 단위
    static func buildExpression(_ expression: some View) -> [AnyView] {
        return [AnyView(expression)]
    }

    // if 문만 있을 때
    static func buildOptional(_ component: [AnyView]?) -> [AnyView] {
        return component ?? [AnyView(EmptyView())]
    }

    // if-else 문 처리
    static func buildEither(first component: [AnyView]) -> [AnyView] {
        return component
    }

    static func buildEither(second component: [AnyView]) -> [AnyView] {
        return component
    }
}

struct AuthLayout: View {
    let items: [AnyView]
    
    init(@AuthLayoutBuilder items: @escaping () -> [AnyView]) {
        self.items = items()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: - header title
            items[0]

            //MARK: - body login fields
            VStack(alignment: .leading, spacing: 16) {
                items[1]
                items[2]

                Group {
                    items[3]
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.Brand)
                    
                    items[4]
                        .font(.pretendard(.regular, size: 16))
                        .foregroundStyle(Color.RedWarning)
                }
                .padding(.top, 15)
                .padding(.horizontal, 10)
            }
            .padding(20)

            Spacer()

            //MARK: - footer button
            items[5]
                .padding(.top, 10)
                .padding(.bottom, 25)
                .padding(.horizontal, 20)
        }
        .background(Color.Background)
    }
}
