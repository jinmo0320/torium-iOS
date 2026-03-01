//
//  SurveyResultView.swift
//  Torium
//
//  Created by 최진모 on 3/2/26.
//

import ComposableArchitecture
import SwiftUI

struct SurveyResultView: View {
    var store: StoreOf<SurveyResultFeature>

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
                    .shadow(color: Color(hex: store.asset.color), radius: 50)
                
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
                print(store.score)
            }
            .padding(.top, 10)
            .padding(.bottom, 30)
            .padding(.horizontal, 20)
        }
        .navbar(back: {}, root: {})
        .background(Color.Background)
    }
}

#Preview {
    SurveyResultView(store: Store(initialState: SurveyResultFeature.State(score: 10)) {
        SurveyResultFeature()
    })
}
