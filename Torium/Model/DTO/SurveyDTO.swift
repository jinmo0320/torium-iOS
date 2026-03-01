//
//  SurveyDTO.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//

nonisolated struct SurveyDTO: Decodable {
    let questions: [Question]
    
    nonisolated struct Question: Decodable {
        let title: String
        let answers: [String]
    }
}
