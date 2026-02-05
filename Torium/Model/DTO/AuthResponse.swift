//
//  AuthResponse.swift
//  torium-iOS
//
//  Created by 최진모 on 12/27/25.
//
import Foundation

nonisolated struct AuthResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let user: UserResponseDTO
}

nonisolated struct TokenResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String
}
