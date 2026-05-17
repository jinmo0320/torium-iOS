//
//  InvPlanStep1View.swift
//  Torium
//
//  Created by 최진모 on 3/6/26.
//

import SwiftUI
import ComposableArchitecture

struct InvPlanStep1View: View {
    @Bindable var store: StoreOf<InvPlanFeature>
    
    var body: some View {
        Group {
            switch store.branch {
            case .amount:
                AmountView(store: store)
            case .period:
                PeriodView(store: store)
            case .yield:
                YieldView(store: store)
            case .target:
                TargetView(store: store)
            }
        }
        .navbar(back: {}, root: {})
        .background(Color.Background)
    }
    
    struct AmountView: View {
        @Bindable var store: StoreOf<InvPlanFeature>
        
        var body: some View {
            InvPlanLayout("매월 얼마씩 투자할까요?") {
                Input(text: $store.value, placeholder: "월 투자금", unit: "₩")
                EmptyView()
                
                SubmitButtonView(
                    text: "다음",
                    type: .primary
                ) { }
            }
        }
    }
    struct PeriodView: View {
        @Bindable var store: StoreOf<InvPlanFeature>
        
        var body: some View {
            InvPlanLayout("투자를 얼마동안 지속할까요?") {
                Input(text: $store.value, placeholder: "투자 기간", unit: "개월")
                EmptyView()
                
                SubmitButtonView(
                    text: "다음",
                    type: .primary
                ) { }
            }
        }
    }
    struct YieldView: View {
        @Bindable var store: StoreOf<InvPlanFeature>
        
        var body: some View {
            InvPlanLayout("목표로 하는 수익률이 있나요?") {
                Input(text: $store.value, placeholder: "수익률", unit: "%")
                EmptyView()
                
                SubmitButtonView(
                    text: "다음",
                    type: .primary
                ) {  }
            }
        }
    }
    struct TargetView: View {
        @Bindable var store: StoreOf<InvPlanFeature>
        
        var body: some View {
            InvPlanLayout("목표로 하는 금액이 있나요?") {
                Input(text: $store.value, placeholder: "목표 금액", unit: "₩")
                EmptyView()
                
                SubmitButtonView(
                    text: "다음",
                    type: .primary
                ) {}
            }
        }
    }
    
    struct Input: View {
        @Binding var text: String
        let placeholder: String
        let unit: String
        
        var body: some View {
            HStack(spacing: 15) {
                TextField (
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .font(.pretendard(.semibold, size: 18))
                        .foregroundStyle(Color.BlackPlaceholder)
                )
                .padding(.vertical, 16)
                .padding(.horizontal, 25)
                .font(.pretendard(.semibold, size: 18))
                .foregroundStyle(Color.BlackInk)
                .background(Color.BlackSoft)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                
                Text(unit)
                    .font(.pretendard(.semibold, size: 18))
                    .foregroundStyle(Color.BlackInk)
            }
        }
    }
    struct Selector: View {
        let values: [String]
        let tappedIndex: Int?
        let tapped: () -> Void
        
        var body: some View {
            HStack(spacing: 10) {
                ForEach(0..<5, id: \.self) { i in
                    Button {
                        tapped()
                    } label: {
                        if i < values.count {
                            HStack {
                                Spacer()
                                Text(values[i])
                                Spacer()
                            }
                            .padding(.vertical, 16)
                            .font(.pretendard(.semibold, size: 18))
                            .foregroundStyle(tappedIndex == i ? Color.White : Color.BlackPlaceholder)
                            .background(tappedIndex == i ? Color.BlackSteel : Color.BlackSoft)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        } else {
                            HStack {
                                Spacer()
                                Text("A")
                                Spacer()
                            }
                            .padding(.vertical, 16)
                            .font(.pretendard(.semibold, size: 18))
                            .foregroundStyle(Color.BlackPlaceholder)
                            .background(Color.BlackSoft)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .hidden()
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }

}
