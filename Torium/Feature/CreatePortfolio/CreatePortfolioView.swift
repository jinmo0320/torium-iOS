//
//  StepView.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//
import ComposableArchitecture
import SwiftUI

struct CreatePortfolioView: View {
    var store: StoreOf<CreatePortfolioFeature>
    
    var body: some View {
        VStack(spacing: 0) {
            Header("새 포트폴리오 만들기")
            
            VStack {
                Button {
                    store.send(.InvestSurveyTapped)
                } label: {
                    HStack(spacing: 16){
                        Text("1")
                            .font(.pretendard(.semibold, size: 32))
                            .foregroundStyle(Color.BlackPlaceholder)
                        Text("투자 성향 조사하기")
                            .font(.pretendard(.semibold, size: 16))
                            .foregroundStyle(Color.BlackPlaceholder)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 22)
                    .background(Color.BlackSoft)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                
                Button {
                    store.send(.InvestPlanTapped)
                } label: {
                    HStack(spacing: 16){
                        Text("2")
                            .font(.pretendard(.semibold, size: 32))
                            .foregroundStyle(Color.BlackPlaceholder)
                        Text("투자 계획 세우기")
                            .font(.pretendard(.semibold, size: 16))
                            .foregroundStyle(Color.BlackPlaceholder)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 22)
                    .background(Color.BlackSoft)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                
                Button {
                    store.send(.ChartSetupTapped)
                } label: {
                    HStack(spacing: 16){
                        Text("3")
                            .font(.pretendard(.semibold, size: 32))
                            .foregroundStyle(Color.BlackPlaceholder)
                        Text("포트폴리오 구성하기")
                            .font(.pretendard(.semibold, size: 16))
                            .foregroundStyle(Color.BlackPlaceholder)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 22)
                    .background(Color.BlackSoft)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)

            Spacer()
        }
        .navbar(back: { store.send(.delegate(.goBack)) })
    }
}
