//
//  NetworkManager.swift
//  Torium
//
//  Created by 최진모 on 12/31/25.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let session: Session

    private init() {
        let logger = APIEventLogger()
        self.session = Session(eventMonitors: [logger])
    }

    func request<T: Decodable>(_ router: URLRequestConvertible) async throws
        -> T
    {
        let response = await session.request(router)
            .validate()
            .serializingDecodable(T.self, emptyResponseCodes: [200, 204])
            .response

        switch response.result {
        case .success(let data):
            return data
        case .failure(let error):
            if let data = response.data,
               let decodedError = try? JSONDecoder().decode(ErrorResponseDTO.self, from: data) {
                throw decodedError
            }
            
            if let afError = error.asAFError {
                switch afError {
                case .sessionTaskFailed(let underlyingError):
                    if let urlError = underlyingError as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet:
                            throw ErrorResponseDTO(code: .app(.notConnectedToInternet))
                        case .cannotConnectToHost:
                            throw ErrorResponseDTO(code: .app(.connectionFailed))
                        case .timedOut:
                            throw ErrorResponseDTO(code: .app(.connectionTimedOut))
                        default:
                            throw ErrorResponseDTO(code: .app(.unknown))
                        }
                    }
                default:
                    throw ErrorResponseDTO(code: .app(.unknown))
                }
            }
            throw ErrorResponseDTO(code: .app(.unknown))
        }
    }
}
