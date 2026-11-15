//
//  ItemDTO.swift
//  Torium
//
//  Created by 최진모 on 5/20/26.
//

enum ItemDTO {
    enum RES {
        struct Item: Decodable {
            let id: Int
            let categoryId: Int
            let name: String
            let description: String?
            let minReturn: Float
            let maxReturn: Float
        }
    }
    
    enum REQ {
        struct Create: Encodable {
            let categoryId: Int
            let name: String
            let description: String?
            let minReturn: Float
            let maxReturn: Float
        }
        
        struct Update: Encodable {
            let itemId: Int
            let categoryId: Int?
            let name: String?
            let description: String?
            let minReturn: Float?
            let maxReturn: Float?
        }
        
        struct Available: Encodable {
            let portfolioId: Int
            let categoryId: Int
        }
    }
}
