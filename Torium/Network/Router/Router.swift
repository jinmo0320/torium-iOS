//
//  Router.swift
//  MemoWithTags
//
//  Created by 최진모 on 1/4/25.
//

import Alamofire
import Foundation

protocol Router: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: Parameters? { get }
    var body: Encodable? { get }
    var errorMap: ErrorMapper? { get }
    var requiresAuth: Bool { get }
}

extension Router {
    var baseURL: URL { URL(string: NetworkConfiguration.baseURL)! }
    var queryParameters: Parameters? { nil }
    var body: Encodable? { nil }
    var errorMap: ErrorMapper? { nil }
    var requiresAuth: Bool { true }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let queryParameters {
            request = try URLEncoding.default.encode(
                request,
                with: queryParameters
            )
        }

        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        return request
    }
}


