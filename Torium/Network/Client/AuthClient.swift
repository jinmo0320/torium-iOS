//
//  AuthClient.swift
//  Torium
//
//  Created by 최진모 on 12/29/25.
//

import Alamofire
import ComposableArchitecture
import Foundation

struct AuthClient {
    var login: @Sendable (String, String) async throws -> User
    var logout: @Sendable () async -> Void
    var sendEmail: @Sendable (String) async throws -> Date
    var verifyEmail: @Sendable (String, String) async throws -> Void
    var register: @Sendable (String, String) async throws -> User
    var sendForgot: @Sendable (String) async throws -> Date
    var verifyForgot: @Sendable (String, String) async throws -> Void
    var resetPassword: @Sendable (String, String) async throws -> Void
}

extension AuthClient: DependencyKey {
    static var liveValue: Self {
        return Self(
            login: { email, password in
                let dto: AuthDTO = try await Network.shared
                    .request(
                        AuthRouter.login(email: email, password: password)
                    )
                
                _ = await KeyChainManager.shared.saveToken(type: .accessToken, token: dto.accessToken)
                _ = await KeyChainManager.shared.saveToken(type: .refreshToken, token: dto.accessToken)

                return User(
                    id: dto.user.id,
                    name: dto.user.name,
                    tag: dto.user.tag,
                    email: dto.user.email
                )
            },
            
            logout: {
                _ = await KeyChainManager.shared.deleteToken(type: .accessToken)
                _ = await KeyChainManager.shared.deleteToken(type: .refreshToken)
            },

            sendEmail: { email in
                let dto: EmailDTO = try await Network.shared.request(
                    AuthRouter.sendEmail(email: email)
                )
                return dto.expiredAt
            },

            verifyEmail: { email, code in
                try await Network.shared.request(
                    AuthRouter.verifyEmail(email: email, code: code)
                )
            },

            register: { email, password in
                let dto: AuthDTO = try await Network.shared
                    .request(
                        AuthRouter.register(
                            email: email,
                            password: password
                        )
                    )
                
                _ = await KeyChainManager.shared.saveToken(type: .accessToken, token: dto.accessToken)
                _ = await KeyChainManager.shared.saveToken(type: .refreshToken, token: dto.accessToken)

                return User(
                    id: dto.user.id,
                    name: dto.user.name,
                    tag: dto.user.tag,
                    email: dto.user.email
                )
            },

            sendForgot: { email in
                let dto: EmailDTO = try await Network.shared.request(
                    AuthRouter.sendForgot(email: email)
                )
                return dto.expiredAt
            },

            verifyForgot: { email, code in
                try await Network.shared.request(
                    AuthRouter.verifyForgot(email: email, code: code)
                )
            },

            resetPassword: { email, newPassword in
                try await Network.shared.request(
                    AuthRouter.resetPassword(
                        email: email,
                        newPassword: newPassword
                    )
                )
            }
        )
    }
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
