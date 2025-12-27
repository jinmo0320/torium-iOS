//
//  AuthRepository.swift
//  torium-iOS
//
//  Created by 최진모 on 12/27/25.
//

protocol AuthRepository {
    func login(email: String, password: String) async throws -> AuthResponseDTO
    func sendEmail(email: String) async throws
    func verifyEmail(email: String, code: String) async throws
    func register(email: String, password: String) async throws -> AuthResponseDTO
    func sendForgot(email: String) async throws
    func verifyForgot(email: String, code: String) async throws
    func resetPassword(email: String, oldPassword: String, newPassword: String) async throws
}
