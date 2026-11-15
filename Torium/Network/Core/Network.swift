//
//  NetworkManager.swift
//  Torium
//
//  Created by 최진모 on 12/31/25.
//

import Alamofire
import Foundation

final class Network {
    static let shared = Network()
    private let session: Session
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    private init() {
        self.session = Session(eventMonitors: [NetworkLogger()])
    }

    func request<T: Decodable, R: Router>(_ router: R) async throws -> T
    {
        // Interceptor 설정
        let interceptor = router.requiresAuth ? Authenticator.shared : nil
        
        // Network 요청
        let response = await session.request(router, interceptor: interceptor)
            .validate()
            .serializingData()
            .response
        
        // 응답 처리
        switch response.result {
        case .success(let data):
            do {
                let decoded = try decoder.decode(SUCCESS<T>.self, from: data)
                return decoded.data
            } catch {
                throw NetworkError.decodingFailed
            }
            
        case .failure(let error):
            throw handleError(response: response, error: error, router: router)
        }
    }
    
    func request<R: Router>(_ router: R) async throws -> Void
    {
        // Interceptor 설정
        let interceptor = router.requiresAuth ? Authenticator.shared : nil

        // Network 요청
        let response = await session.request(router, interceptor: interceptor)
            .validate()
            .serializingData()
            .response
        
        // 응답 처리
        switch response.result {
        case .success:
            return
            
        case .failure(let error):
            throw handleError(response: response, error: error, router: router)
        }
    }
    
    private func handleError<R: Router>(response: AFDataResponse<Data>, error: AFError, router: R) -> Error {
        if case .requestRetryFailed(retryError: let underlyingError, originalError: _) = error {
            if case .unauthorized = underlyingError as? AppError {
               return underlyingError
            }
        }

        if let data = response.data,
           let decoded = try? decoder.decode(FAILURE.self, from: data),
           let mappedError = router.errorMap?.mapped(errorCode: decoded.error.code) {
            return mappedError
        }
        
        if case .sessionTaskFailed(let underlyingError) = error,
           let urlError = underlyingError as? URLError {
            switch urlError.code {
            case .notConnectedToInternet: return NetworkError.notConnectedToInternet
            case .cannotConnectToHost: return NetworkError.connectionFailed
            case .timedOut: return NetworkError.connectionTimedOut
            default: break
            }
        }

        return NetworkError.unknown
    }
}
