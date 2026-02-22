//
//  ErrorMapper.swift
//  Torium
//
//  Created by 최진모 on 2/19/26.
//
import SwiftUI

@resultBuilder
struct ErrorMapperBuilder {
    static func buildBlock(_ components: (ErrorCode, Error)...) -> [(ErrorCode, Error)] {
        return components
    }
}

struct ErrorMapper {
    let items: [ErrorCode: Error]
    
    init(@ErrorMapperBuilder items: @escaping () -> [(ErrorCode, Error)]) {
        self.items = Dictionary(uniqueKeysWithValues: items())
    }
    
    func mapped(errorCode: ErrorCode) -> Error? {
        return items[errorCode] ?? nil
    }
}

infix operator ~>: DefaultPrecedence
func ~> (lhs: ErrorCode, rhs: Error) -> (ErrorCode, Error) {
    return (lhs, rhs)
}
