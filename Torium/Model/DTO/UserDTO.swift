//
//  UserResponse.swift
//  Torium
//
//  Created by 최진모 on 2/4/26.
//
import Foundation

nonisolated struct UserDTO: Decodable {
    let id: UUID
    let name: String
    let tag: String
    let email: String
}
