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
    var parameters: Parameters? { get }
}

extension Router {
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let parameters = parameters {
            if method == .get {
                return try URLEncoding.default.encode(request, with: parameters)
            } else {
                return try JSONEncoding.default.encode(
                    request,
                    with: parameters
                )
            }
        }
        
        return request
    }
}
