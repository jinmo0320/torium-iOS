//
//  SurveyView.swift
//  Torium
//
//  Created by 최진모 on 2/25/26.
//
import ComposableArchitecture
import SwiftUI

struct SurveyView: View {
    var store: StoreOf<SurveyFeature>
        
    var body: some View {
        VStack(spacing: 0) {
            if store.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                HStack {
                    Text(store.currentQuestion?.title ?? "")
                    Spacer()
                }
                .font(.pretendard(.semibold, size: 20))
                .foregroundStyle(Color.BlackInk)
                .padding(.vertical, 22)
                .padding(.horizontal, 24)

                ProgressBarView(
                    cur: Float(store.index + 1),
                    max: 10
                )

                VStack(spacing: 28) {
                    if let questions = store.currentQuestion {
                        ForEach(questions.answers.indices, id: \.self) { i in
                            Question(questions.answers[i], selected: (i+1) == store.seletedNum)
                                .onTapGesture {
                                    store.send(.select(i))
                                }
                        }
                    }
                
                    Spacer()
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 28)

                HStack(spacing: 10) {
                    SubmitButtonView(text: "이전", type: store.index > 0 ? .secondary : .disabled) {
                        store.send(.prevTapped)
                    }
                    
                    SubmitButtonView(text: "다음", type: store.seletedNum != nil ? .primary : .disabled) {
                        store.send(.nextTapped)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 30)
                .padding(.horizontal, 20)
            }
        }
        .navbar(root: { store.send(.delegate(.goOut)) })
        .background(Color.Background)
        .onAppear {
            if store.questions.isEmpty {
                store.send(.loadSurvey)
            }
        }
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
                .font(.pretendard(.medium, size: 18))
                .foregroundStyle(selected ? Color.Green : Color.BlackInk)

            Spacer()
        }
    }
}
