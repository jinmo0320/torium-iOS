//
//  SurveyResultView.swift
//  Torium
//
//  Created by 최진모 on 3/2/26.
//

import ComposableArchitecture
import SwiftUI

struct SurveyResultView: View {
    @Bindable var store: StoreOf<SurveyResultFeature>

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 62) {
                Text("투자 성향 테스트 결과")
                    .font(.pretendard(.medium, size: 17))
                    .foregroundStyle(Color.BlackPlaceholder)
                
                Image(store.asset.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 130)
                    .shadow(color: Color(hex: store.asset.color), radius: CGFloat(store.blur))
                    .onAppear {
                        store.send(.animateBlur, animation: .easeInOut(duration: 4).repeatForever())
                    }
                
                VStack(spacing: 15){
                    Text(store.asset.name)
                        .font(.pretendard(.medium, size: 24))
                        .foregroundStyle(Color.BlackInk)
                    
                    Text(store.asset.abstract)
                        .font(.pretendard(.medium, size: 15))
                        .foregroundStyle(Color.BlackSteel)
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text(store.asset.description)
                            .font(.pretendard(.regular, size: 12))
                            .foregroundStyle(Color.BlackSteel)
                            .lineHeight(.exact(points: 18))
                        
                        Text("다른 유형 살펴보기")
                            .font(.pretendard(.regular, size: 12))
                            .foregroundStyle(Color.BlackPlaceholder)
                            .onTapGesture {
                                store.send(.presentSheet)
                            }
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .background(Color.BlackSoft)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.vertical, 10)
                }
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            
            Spacer()
            
            SubmitButtonView(text: "완료", type: .primary) {
                store.send(.nextTapped)
            }
            .padding(.top, 10)
            .padding(.bottom, 30)
            .padding(.horizontal, 20)
        }
        .navbar(
            back: {
                store.send(.delegate(.goBack))
            },
            root: {
                store.send(.delegate(.goOut))
            }
        )
        .background(Color.Background)
        .sheet(item: $store.scope(state: \.sheet, action: \.sheet)) { s in
            SheetView(store: s)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
    
    
    struct SheetView: View {
        let store: StoreOf<SurveyResultFeature.SheetFeature>
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(assets.indices, id: \.self) { i in
                    HStack(spacing: 30) {
                        Image(assets[i].image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .shadow(color: Color(hex: assets[i].color), radius: 50)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(assets[i].name)
                                .font(.pretendard(.medium, size: 15))
                                .foregroundStyle(Color.BlackInk)
                            
                            Text(assets[i].abstract)
                                .font(.pretendard(.medium, size: 12))
                                .foregroundStyle(Color.BlackSteel)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 35)
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    SurveyResultView(store: Store(initialState: SurveyResultFeature.State(score: 10)) {
        SurveyResultFeature()
    })
}
