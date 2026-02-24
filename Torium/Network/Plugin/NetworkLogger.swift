//
//  APIEventLogger.swift
//  Torium
//
//  Created by 최진모 on 12/31/25.
//

import Alamofire
import Foundation

final class NetworkLogger: EventMonitor {
    let queue: DispatchQueue = DispatchQueue(label: "NetworkLogger")
    
    func requestDidFinish(_ request: Request) {
        print("-------------------------------------------------------")
        print("🚀 [NETWORK] Request Started")
        print("- 🔗 URL: \(request.request?.url?.absoluteString ?? "Invalid URL")")
        print("- 🛠 Method: \(request.request?.httpMethod ?? "Unknown")")
        print("- 📡 Headers: \(request.request?.allHTTPHeaderFields ?? [:])")
        
        if let body = request.request?.httpBody,
            let string = String(data: body, encoding: .utf8)
        {
            print("- 📦 Body: \(string)")
        }
    }

    // 2. 응답을 받았을 때 호출 (성공/실패 여부 상관없음)
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        print("-------------------------------------------------------")
        print("✅ [NETWORK] Response Arrived")
        switch response.result {
        case .success:
            if let statusCode = response.response?.statusCode {
                print("- ☎️ Status Code: \(statusCode)")
            } else {
                print("- ☎️ Status Code: NIL")
            }

            guard let data = response.data else {
                print("- 📭 Data is nil")
                return
            }
            // JSON Pretty Print
            if let json = try? JSONSerialization.jsonObject(
                with: data,
                options: []
            ),
                let serialized = try? JSONSerialization.data(
                    withJSONObject: json,
                    options: .prettyPrinted
                ),
                let prettyString = String(data: serialized, encoding: .utf8)
            {
                print("- 📄 Response JSON:\n\(prettyString)")
            } else if let string = String(data: data, encoding: .utf8) {
                print("- 📄 Response String: \(string)")
            }
        case let .failure(error):
            if let statusCode = response.response?.statusCode {
                print("- ☎️ Status Code: \(statusCode)")
            } else {
                print("- ☎️ Status Code: NIL")
            }

            guard let data = response.data else {
                print("- ⚠️ [Error] \(error.localizedDescription)")
                print("-------------------------------------------------------")
                return
            }
            // JSON Pretty Print
            if let json = try? JSONSerialization.jsonObject(
                with: data,
                options: []
            ),
                let serialized = try? JSONSerialization.data(
                    withJSONObject: json,
                    options: .prettyPrinted
                ),
                let prettyString = String(data: serialized, encoding: .utf8)
            {
                print("-⚠️ [Error] Response JSON:\n\(prettyString)")
            } else if let string = String(data: data, encoding: .utf8) {
                print("-⚠️ [Error] Response String: \(string)")
            }
        }

        print("-------------------------------------------------------")
    }
}
