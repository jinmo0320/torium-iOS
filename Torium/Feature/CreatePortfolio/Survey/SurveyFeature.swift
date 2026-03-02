//
//  SurveyFeature.swift
//  Torium
//
//  Created by 최진모 on 2/25/26.
//
import ComposableArchitecture
import Foundation

@Reducer
struct SurveyFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool = false
        
        var questions: [SurveyQuestion] = []
        var index: Int = 0
        var seletedNum: Int? = nil
        var answers: [Int: Int] = [:]
        
        var currentQuestion: SurveyQuestion? {
            if !questions.isEmpty {
                questions[index]
            } else {
                nil
            }
        }
        
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action {
        case loadSurvey
        case loadSurveyResponse(Result<[SurveyQuestion], Error>)
        
        case select(Int)
        case nextTapped
        case prevTapped
        
        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {}
        
        case delegate(NavigaitonDelegate)
    }
    
    enum NavigaitonDelegate {
        case goOut
        case goResult(Int)
    }
    
    @Dependency(\.surveyClient) var surveyClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadSurvey:
                state.isLoading = true
                
                return .run { send in
                    await send(.loadSurveyResponse(Result{ try await surveyClient.get() }))
                }
            
            case .loadSurveyResponse(.success(let questions)):
                state.isLoading = false
                state.questions = questions
                return .none
            
            case .loadSurveyResponse(.failure(let error)):
                state.alert = AlertState {
                    TextState("설문 가져오기 실패")
                } actions: {
                    ButtonState { TextState("확인") }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none
            
            case .select(let num):
                state.seletedNum = num + 1
                return .none
                
            case .nextTapped:
                if let num = state.seletedNum {
                    state.answers[state.index] = num
                }
                
                if state.index < state.questions.endIndex - 1 {
                    state.index += 1
                    state.seletedNum = state.answers[state.index]
                    return .none
                } else {
                    let score = state.answers.values.reduce(0, +)
                    return .send(.delegate(.goResult(score)))
                }
                
            case .prevTapped:
                if state.index > state.questions.startIndex {
                    state.index -= 1
                    state.seletedNum = state.answers[state.index]
                    return .none
                } else {
                    return .none
                }
                
                
            default:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
