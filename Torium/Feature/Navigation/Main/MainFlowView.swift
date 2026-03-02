//
//  MainFlowView.swift
//  Torium
//
//  Created by 최진모 on 2/5/26.
//
import ComposableArchitecture
import SwiftUI
import SwiftUINavigationTransitions
import UIKitNavigationTransitions

struct MainFlowView: View {
    @Bindable var store: StoreOf<MainFlow>

    var body: some View {
        Group {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                MainView(store: store.scope(state: \.main, action: \.main))
            } destination: { path in
                Group {
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
            .navigationTransition(
                store.animation == .up
                    ? .up.animation(.easeIn) : .default.animation(.easeIn),
                interactivity: store.animation == .up ? .disabled : .edgePan
            )
        }
    }
}

extension AnyNavigationTransition {
    static var up: Self {
        .init(Up())
    }
}

struct Up: NavigationTransitionProtocol {
    var body: some NavigationTransitionProtocol {
        MirrorPush {
            OnInsertion {
                Move(edge: .bottom)
            }
            OnRemoval {
                Scale(0.9)
                Opacity()
            }
        }
        PickPop {
            OnPop {
                Move(edge: .bottom)
                Scale(0.9)
            }
        }
    }
}
