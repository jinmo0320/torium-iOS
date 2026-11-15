//
//  AnyEncodable.swift
//  Torium
//
//  Created by 최진모 on 5/25/26.
//


struct AnyEncodable: Encodable {
    private let encode: (Encoder) throws -> Void

    init<T: Encodable>(_ value: T) {
        self.encode = value.encode
    }

    func encode(to encoder: Encoder) throws {
        try encode(encoder)
    }
}

private func encoded<T: Encodable>(_ value: T) -> AnyEncodable {
    AnyEncodable(value)
}
