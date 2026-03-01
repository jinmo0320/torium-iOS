//
//  MainFlowView.swift
//  Torium
//
//  Created by 최진모 on 2/5/26.
//
import ComposableArchitecture
import SwiftUI

struct MainFlowView: View {
    @Bindable var store: StoreOf<MainFlow>

    var body: some View {
        Group {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                MainView(store: store.scope(state: \.main, action: \.main))
            } destination: { path in
                switch path.case {
                case .createPortfolio(let s):
                    CreatePortfolioView(store: s)
                case .createPortfolioInvestSurvey(let s):
                    SurveyView(store: s)
                case .createPortfolioInvestSurveyResult(let s):
                    SurveyResultView(store: s)
                    
                default: EmptyView()
                }
            }
        }
    }
}
