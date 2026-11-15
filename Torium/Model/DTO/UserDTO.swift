//
//  UserResponse.swift
//  Torium
//
//  Created by 최진모 on 2/4/26.
//
import Foundation

enum UserDTO {
    enum RES {
        struct User: Decodable {
            let user: UserInfo
        }
        
        struct Risk: Decodable {
            let riskType: RiskType
        }
    }
    
    enum REQ {
        struct ChangePassword: Encodable {
            let oldPassword: String
            let newPassword: String
        }
        
        struct ChangeName: Encodable {
            let name: String
            let tag: String
        }
        
        struct ChangeRisk: Encodable {
            let score: Int
        }
    }
}

struct UserInfo: Decodable {
    let id: UUID
    let name: String
    let tag: String
    let email: String
    let riskType: RiskType
    let createdAt: Date
    let updatedAt: Date
}

enum RiskType: String, Codable {
    case STABLE = "STABLE"
    case STABLE_SEEK = "STABLE_SEEK"
    case NEUTRAL = "NEUTRAL"
    case ACTIVE = "ACTIVE"
    case AGGRESSIVE = "AGGRESSIVE";
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .STABLE
    }
}
