//
//  SurveyResultFeature.swift
//  Torium
//
//  Created by 최진모 on 3/2/26.
//

import ComposableArchitecture
import Foundation

@Reducer
struct InvSurveyResultFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool = false
        var score: Int = 0
        
        var blur = 5
        
        @Presents var sheet: SheetFeature.State?
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action {
        case nextTapped
        case nextResponse(Result<Void, Error>)
        case presentSheet
        
        case animateBlur
        
        case sheet(PresentationAction<SheetFeature.Action>)
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {}
    
        case delegate(NavigaitonDelegate)
    }
    
    enum NavigaitonDelegate {
        case goBack
        case goOut
        case goComplete
    }
    
    @Dependency(\.surveyClient) var surveyClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .nextTapped:
                return .run { [score = state.score] send in
                    await send(.nextResponse(Result{ try await surveyClient.submit(score) }))
                }
                
            case .nextResponse(.success):
                return .send(.delegate(.goOut))
            
            case .nextResponse(.failure(let error)):
                state.alert = AlertState {
                    TextState("결과 전송 실패")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none

            case .presentSheet:
                state.sheet = SheetFeature.State()
                return .none
                
            case .animateBlur:
                state.blur = 50
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$sheet, action: \.sheet) {
            SheetFeature()
        }
    }
    
    @Reducer
    struct SheetFeature {
        @ObservableState
        struct State: Equatable {}
        
        enum Action {}
        
        var body: some Reducer<State, Action> {}
    }
}

struct Asset {
    let name: String
    let image: String
    let color: String
    let abstract: String
    let description: String
}

let assets: [Asset] = [
    .init(
        name: "안정형",
        image: "cat/blue",
        color: "#7AA0D5",
        abstract: "\" 무엇보다 원금을 잃지 않는 것이 중요해요! \"",
        description: "안정형은 원금 보존을 최우선으로 생각하는 단단한 수호자에요. 수익보다는 자산을 안전하게 지키는 데 집중하며, 예금이나 적금처럼 손실 위험이 거의 없는 확정 수익형 상품을 선호해요. 짧은 기간 동안 자금을 안정적으로 운용하길 원하며, 시장의 큰 변동에도 흔들리지 않고 소중한 자산을 소중히 품어 지켜내는 스타일입니다."
    ),
    .init(
        name: "안정추구형",
        image: "cat/green",
        color: "#41A75A",
        abstract: "\" 안전이 우선, 하지만 성장은 필요해요! \"",
        description: "안정추구형은 원금 손실은 줄이면서 물가상승률 이상의 수익을 기대하는 신중한 전략가에요. 자산 대부분은 안전하게 관리하되 일부를 채권 등 저위험 상품에 분산하여 투자의 재미를 조금씩 챙기길 원해요. 원금을 지키는 든든함과 꾸준히 자라나는 수익을 동시에 잡으며 미래를 차근차근 준비하는 현명한 투자 스타일입니다."
    ),
    .init(
        name: "위험중립형",
        image: "cat/yellow",
        color: "#E5D75A",
        abstract: "\" 수익과 위험 사이 균형 잡힌 투자를 선호해요 \"",
        description: "위험중립형은 수익과 위험 사이의 완벽한 균형을 찾는 합리적인 밸런서에요. 어느 한쪽으로 치우치지 않는 유연함을 가지고 있으며, 안정적인 채권과 성장성 있는 주식에 자산을 적절히 배분하여 시장 변화에 대처해요. 일시적인 손실은 감내하면서도 꾸준하고 안정적인 성과를 지향하며 중심을 잃지 않고 나아가는 투자자입니다."
    ),
    .init(
        name: "적극투자형",
        image: "cat/orange",
        color: "#FF6A00",
        abstract: "\" 더 높은 수익을 위해, 위험해도 괜찮아요 \"",
        description: "적극투자형은 자산의 가치를 높이기 위해 변동성을 기꺼이 수용하는 열정적인 성장주에요. 주식 등 성장성 높은 자산에 비중을 두어 장기적으로 시장 수익률 이상의 성과를 거두는 것을 목표로 삼아요. 단기적인 하락에 일희일비하지 않고 더 큰 성장을 향해 과감하게 나아가는 추진력이 당신의 가장 큰 무기이자 장점이 되는 스타일입니다."
    ),
    .init(
        name: "공격투자형",
        image: "cat/red",
        color: "#BE3041",
        abstract: "\" 기회는 왔을 때 잡는 것, 수익 극대화 \"",
        description: "공격투자형은 최고의 수익률을 목표로 위험을 기회로 바꾸는 용감한 모험가에요. 원금 손실 가능성을 충분히 인지하면서도 집중 투자나 고위험 상품을 통해 자산 증식을 극대화하는 과감한 선택을 주저하지 않아요. 시장 흐름을 빠르게 읽고 기회가 왔을 때 망설임 없이 뛰어들어 남다른 성과를 거두는 역동적이고 주도적인 투자 스타일입니다."
    )
]

extension InvSurveyResultFeature.State {
    var asset: Asset {
        switch self.score {
        case 10 ..< 16:
            return assets[0]
        case 16 ..< 21:
            return assets[1]
        case 21 ..< 26:
            return assets[2]
        case 26 ..< 31:
            return assets[3]
        default:
            return assets[4]
        }
    }
}
