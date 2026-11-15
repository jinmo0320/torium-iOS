//
//  AuthResponse.swift
//  torium-iOS
//
//  Created by 최진모 on 12/27/25.
//
import Foundation

enum AuthDTO {
    enum RES {
        struct Success: Decodable {
            let accessToken: String
            let refreshToken: String
            let user: UserDTO.RES.User
        }
        
        struct SendCode: Decodable {
            let email: String
            let createdAt: Date
            let expiredAt: Date
        }
        
        struct Token: Decodable {
            let accessToken: String
            let refreshToken: String
        }
    }
    
    enum REQ {
        struct Email: Encodable {
            let email: String
        }
        
        struct Sign: Encodable {
            let email: String
            let password: String
        }
        
        struct Verify: Encodable {
            let email: String
            let code: String
        }
        
        struct ResetPassword: Encodable {
            let email: String
            let newPassword: String
        }
        
        struct Refresh: Encodable {
            let refreshToken: String
        }
    }
}

