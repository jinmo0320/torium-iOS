//
//  CategoryDTO.swift
//  Torium
//
//  Created by 최진모 on 5/20/26.
//

enum CategoryDTO {
    enum RES {
        struct Category: Decodable {
            let id: Int
            let code: String
            let name: String
            let description: String?
        }
    }
    
    enum REQ {
        struct Create: Encodable {
            let name: String
            let description: String?
        }
        
        struct Update: Encodable {
            let categoryId: Int
            let name: String?
            let description: String?
        }
        
        struct Available: Encodable {
            let portfolioId: Int
        }
    }
}
