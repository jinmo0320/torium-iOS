//
//  PlanView.swift
//  Torium
//
//  Created by 최진모 on 3/2/26.
//

import ComposableArchitecture
import SwiftUI

struct InvPlanView: View {
    var store: StoreOf<InvPlanFeature>
    
    var body: some View {
        VStack(spacing: 0) {
            Header("어디서부터 계획해볼까요?")
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Button {
                    } label: {
                        VStack(alignment: .leading, spacing: 10){
                            Text("투자금")
                                .font(.pretendard(.bold, size: 28))
                                .foregroundStyle(Color.Brand)
                            Text("매월 얼마씩?")
                                .font(.pretendard(.semibold, size: 20))
                                .foregroundStyle(Color.BlackPlaceholder)
                            Spacer()
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 20)
                        .aspectRatio(10/11, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .background(Color.BlackSoft)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                    
                    Button {
                    } label: {
                        VStack(alignment: .leading, spacing: 10){
                            Text("투자기간")
                                .font(.pretendard(.bold, size: 28))
                                .foregroundStyle(Color.Brand)
                            Text("몇년 동안?")
                                .font(.pretendard(.semibold, size: 20))
                                .foregroundStyle(Color.BlackPlaceholder)
                            Spacer()
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 20)
                        .aspectRatio(10/11, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .background(Color.BlackSoft)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                }

                HStack(spacing: 20) {
                    Button {
                    } label: {
                        VStack(alignment: .leading, spacing: 10){
                            Text("목표 금액")
                                .font(.pretendard(.bold, size: 28))
                                .foregroundStyle(Color.Brand)
                            Text("총 얼마를?")
                                .font(.pretendard(.semibold, size: 20))
                                .foregroundStyle(Color.BlackPlaceholder)
                            Spacer()
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 20)
                        .aspectRatio(10/11, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .background(Color.BlackSoft)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                    
                    Button {
                    } label: {
                        VStack(alignment: .leading, spacing: 10){
                            Text("수익률")
                                .font(.pretendard(.bold, size: 28))
                                .foregroundStyle(Color.Brand)
                            Text("원금의 몇 %?")
                                .font(.pretendard(.semibold, size: 20))
                                .foregroundStyle(Color.BlackPlaceholder)
                            Spacer()
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 20)
                        .aspectRatio(10/11, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .background(Color.BlackSoft)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)

            Spacer()
        }
        .navbar(root: { store.send(.delegate(.goOut)) })
    }
}
