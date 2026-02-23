//
//  AuthResponse.swift
//  torium-iOS
//
//  Created by 최진모 on 12/27/25.
//
import Foundation

nonisolated struct AuthDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let user: UserDTO.Info
}

nonisolated struct TokenDTO: Codable {
    let accessToken: String
    let refreshToken: String
}

nonisolated struct EmailDTO: Codable {
    let createdAt: Date
    let expiredAt: Date
}
