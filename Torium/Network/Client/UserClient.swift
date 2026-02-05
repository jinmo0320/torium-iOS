//
//  UserClient.swift
//  Torium
//
//  Created by 최진모 on 2/4/26.
//

import Alamofire
import ComposableArchitecture
import Foundation

struct UserClient {
    var me: @Sendable () async throws -> User
    var changePassword: @Sendable (_ oldPassword: String, _ newPassword: String) async throws -> Void
}

extension UserClient: DependencyKey {
    static var liveValue: Self {
        return Self(
            me: {
                do {
                    let dto: UserResponseDTO = try await NetworkManager.shared.request(UserRouter.me)
                    
                    return User(
                        id: dto.id,
                        name: dto.name,
                        tag: dto.tag,
                        email: dto.email
                    )
                } catch {
                    throw UserError(from: error as! ErrorResponseDTO)
                }
            },
            
            changePassword: { oldPassword, newPassword in
                do {
                    let _: Empty = try await NetworkManager.shared.request(
                        UserRouter.changePassword(
                            oldPassword: oldPassword,
                            newPassword: newPassword
                        )
                    )
                    
                } catch {
                    throw ChangePasswordError(from: error as! ErrorResponseDTO)
                }
            }
        )
    }
}

extension DependencyValues {
    var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}
