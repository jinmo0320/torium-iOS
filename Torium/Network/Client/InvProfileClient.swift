//
//  InvProfileClient.swift
//  Torium
//
//  Created by 최진모 on 3/8/26.
//

import Alamofire
import ComposableArchitecture
import Foundation

struct InvProfileClient {
}

extension InvProfileClient: DependencyKey {
    static var liveValue: Self {
        return Self(
        )
    }
}

extension DependencyValues {
    var invProfileClient: InvProfileClient {
        get { self[InvProfileClient.self] }
        set { self[InvProfileClient.self] = newValue }
    }
}
