//
//  File.swift
//  Torium
//
//  Created by 최진모 on 5/20/26.
//

import Foundation

enum PortfolioDTO {
    enum RES {
        struct Portfolio: Decodable {
            let id: Int
            let name: String
            let minReturn: Float
            let maxReturn: Float
            let status: PortfolioStatus
            let categories: [CategoryInfo]
            let createdAt: Date
            let updatedAt: Date
        }
        
        struct Preset: Decodable {
            let code: String
            let name: String
            let description: String?
            let targetReturnPercent: Int
            let minReturn: Float
            let maxReturn: Float
            let categories: [CategoryInfo]
        }
    }
    
    enum REQ {
        struct Create: Encodable {
            let presetCode: String
        }
        
        struct Set: Encodable {
            let items: [ItemSetInfo]
        }
    }
}

struct CategoryInfo: Decodable {
    let id: Int
    let code: String
    let name: String
    let description: String?
    let portion: Float
    let minReturn: Float
    let maxReturn: Float
    let items: [ItemInfo]
}

struct ItemInfo: Decodable {
    let id: Int
    let categoryId: Int
    let name: String
    let description: String?
    let minReturn: Float
    let maxReturn: Float
    let portion: Float
    let alias: String?
    let aliasDescription: String?
}

struct ItemSetInfo: Encodable {
    let itemId: Int
    let portion: Float
    let alias: String?
    let aliasDescription: String?
}

enum PortfolioStatus: String, Codable {
    case PENDING = "PENDING"
    case STABLE = "STABLE"
    case OVER_ALLOCATED = "OVER_ALLOCATED"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .PENDING
    }
}
