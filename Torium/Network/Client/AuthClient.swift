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
    var login:
        @Sendable (_ email: String, _ password: String) async throws -> User
    var sendEmail: @Sendable (_ email: String) async throws -> Void
    var verifyEmail:
        @Sendable (_ email: String, _ code: String) async throws -> Void
    var register:
        @Sendable (_ email: String, _ password: String) async throws -> User
    var sendForgot: @Sendable (_ email: String) async throws -> Void
    var verifyForgot:
        @Sendable (_ email: String, _ code: String) async throws -> Void
    var resetPassword:
        @Sendable (_ email: String, _ newPassword: String) async throws -> Void
}

extension AuthClient: DependencyKey {
    static var liveValue: Self {
        return Self(
            login: { email, password in
                do {
                    let dto: AuthResponseDTO = try await NetworkManager.shared
                        .request(
                            AuthRouter.login(email: email, password: password)
                        )

                    return User(
                        id: dto.user.id,
                        name: dto.user.name,
                        tag: dto.user.tag,
                        email: dto.user.email
                    )
                } catch {
                    throw LoginError(from: error as! ErrorResponseDTO)
                }
            },

            sendEmail: { email in
                do {
                    let _: Empty = try await NetworkManager.shared.request(
                        AuthRouter.sendEmail(email: email)
                    )
                } catch {
                    throw RegisterEmailError(from: error as! ErrorResponseDTO)
                }
            },

            verifyEmail: { email, code in
                do {
                    let _: Empty = try await NetworkManager.shared.request(
                        AuthRouter.verifyEmail(email: email, code: code)
                    )
                } catch {
                    throw RegisterVerifyError(from: error as! ErrorResponseDTO)
                }
            },

            register: { email, password in
                do {
                    let dto: AuthResponseDTO = try await NetworkManager.shared
                        .request(
                            AuthRouter.register(
                                email: email,
                                password: password
                            )
                        )

                    return User(
                        id: dto.user.id,
                        name: dto.user.name,
                        tag: dto.user.tag,
                        email: dto.user.email
                    )
                } catch {
                    throw RegisterPasswordError(from: error as! ErrorResponseDTO)
                }
            },

            sendForgot: { email in
                do {
                    let _: Empty = try await NetworkManager.shared.request(
                        AuthRouter.sendForgot(email: email)
                    )
                } catch {
                    throw ForgotEmailError(from: error as! ErrorResponseDTO)
                }
            },

            verifyForgot: { email, code in
                do {
                    let _: Empty = try await NetworkManager.shared.request(
                        AuthRouter.verifyForgot(email: email, code: code)
                    )
                } catch {
                    throw ForgotVerifyError(from: error as! ErrorResponseDTO)
                }
            },

            resetPassword: { email, newPassword in
                do {
                    let _: Empty = try await NetworkManager.shared.request(
                        AuthRouter.resetPassword(
                            email: email,
                            newPassword: newPassword
                        )
                    )
                } catch {
                    throw ForgotPasswordError(from: error as! ErrorResponseDTO)
                }
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
