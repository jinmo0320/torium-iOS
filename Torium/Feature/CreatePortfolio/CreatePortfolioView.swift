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
        VStack(spacing: 10) {
            Text("create portfolio")
            
            Button("1. 투자성향 조사") {
                store.send(.InvestSurveyTapped)
            }
            
            Button("2. 투자 계획 수립") {
                store.send(.InvestPlanTapped)
            }
            
            Button("3. 포트폴리오 구성") {
                store.send(.ChartSetupTapped)
            }
            
            Spacer()
        }
        .navbar(back: { store.send(.delegate(.goBack)) })
    }
}
