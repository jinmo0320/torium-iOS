//
//  SurveyClient.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//

import Alamofire
import ComposableArchitecture
import Foundation

struct SurveyClient {
    var get: @Sendable () async throws -> [SurveyQuestion]
    var submit: @Sendable (Int) async throws -> Void
    var dump: @Sendable () async throws -> Void
}

extension SurveyClient: DependencyKey {
    static var liveValue: Self {
        return Self(
            get: {
                let dto: SurveyDTO = try await Network.shared.request(SurveyRouter.get)
                return dto.questions.map { SurveyQuestion(title: $0.title, answers: $0.answers) }
            },
            
            submit: { score in
                try await Network.shared.request(SurveyRouter.submit(score: score))
            },
            
            dump: {
                try await Network.shared.request(SurveyRouter.dump)
            }
        )
    }
}

extension DependencyValues {
    var surveyClient: SurveyClient {
        get { self[SurveyClient.self] }
        set { self[SurveyClient.self] = newValue }
    }
}
