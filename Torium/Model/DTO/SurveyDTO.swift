//
//  SurveyDTO.swift
//  Torium
//
//  Created by 최진모 on 2/26/26.
//

enum SurveyDTO {
    enum RES {
        struct Survey: Decodable {
            let questions: [Question]
        }
    }
}

struct Question: Decodable {
    let title: String
    let answers: [String]
}
