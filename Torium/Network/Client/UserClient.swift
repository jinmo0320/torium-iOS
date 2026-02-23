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
    var changePassword: @Sendable (String, String) async throws -> Void
}

extension UserClient: DependencyKey {
    static var liveValue: Self {
        return Self(
            me: {
                try await Network.shared.request(UserRouter.me)
                let dto: UserDTO = try await Network.shared.request(UserRouter.me)
                return User(
                    id: dto.user.id,
                    name: dto.user.name,
                    tag: dto.user.tag,
                    email: dto.user.email
                )
            },
            
            changePassword: { oldPassword, newPassword in
                let _: Empty = try await Network.shared.request(
                    UserRouter.changePassword(
                        oldPassword: oldPassword,
                        newPassword: newPassword
                    )
                )
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
