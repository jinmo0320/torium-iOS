//
//  SurveyView.swift
//  Torium
//
//  Created by 최진모 on 2/25/26.
//
import ComposableArchitecture
import SwiftUI

struct SurveyView: View {

    var body: some View {
        VStack(spacing: 0) {
            Header("귀하의 투자 목적은 무엇입니까?")

            ProgressBarView(cur: 3, max: 10)

            VStack(spacing: 28) {
                Question("apple is red", selected: false)
                Question("apple is red", selected: true)
                Question("apple is red", selected: false)
                Question("apple is red", selected: false)
                Spacer()
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 28)

            HStack(spacing: 10) {
                SubmitButtonView(text: "이전", type: .secondary) {

                }
                SubmitButtonView(text: "다음", type: .primary) {

                }
            }
            .padding(.top, 10)
            .padding(.bottom, 30)
            .padding(.horizontal, 20)
        }
        .navbar(root: {})
        .background(Color.Background)
    }

    @ViewBuilder
    func Question(_ text: String, selected: Bool) -> some View {
        HStack(spacing: 10) {
            if selected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.Green)
            } else {
                Image(systemName: "circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(
                        Color.BlackSoft.shadow(
                            .inner(
                                color: .black.opacity(0.05),
                                radius: 5,
                                x: 4,
                                y: 4
                            )
                        )
                    )
            }

            Text(text)
                .font(.pretendard(.medium, size: 20))
                .foregroundStyle(selected ? Color.Green : Color.BlackInk)

            Spacer()
        }
    }
}
