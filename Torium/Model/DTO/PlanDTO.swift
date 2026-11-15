//
//  PlanDTO.swift
//  Torium
//
//  Created by 최진모 on 5/20/26.
//
import Foundation

enum PlanDTO {
    enum RES {
        struct Plan: Decodable {
            let version: Int

            let initialAmount: Int
            let monthlyAmount: Int
            let startDate: Date
            let period: Int
            let expectedReturn: Float
            let targetAmount: Int

            let paymentDay: Int?
            
            let createdAt: Date
            let updatedAt: Date
        }
    }
    
    enum REQ {
        struct Create: Encodable {
            let initialAmount: Int
            let monthlyAmount: Int
            let startDate: Date
            let period: Int
            let expectedReturn: Float
            let targetAmount: Int
        }
        
        struct SetDate: Encodable {
            let paymentDay: Int
        }
    }
}
