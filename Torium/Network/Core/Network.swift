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

    func request<T: Decodable>(_ router: URLRequestConvertible) async throws
        -> T
    {
        // Interceptor 설정
        let interceptor = (router as? Router)?.requiresAuth == true ? AuthInterceptor.shared : nil
        
        // Network 요청
        let response = await session.request(router, interceptor: interceptor)
            .serializingDecodable(SUCCESS<T>.self, decoder: decoder)
            .response
        
        // 응답 처리
        switch response.result {
        case .success(let decoded):
            return decoded.data
            
        case .failure(let error):
            if let data = response.data,
               let decoded = try? decoder.decode(FAILURE.self, from: data),
               let baseRouter = router as? Router,
               let mappedError = baseRouter.errorMap?.mapped(errorCode: decoded.error.code) {
                throw mappedError
            }
            
            if case .sessionTaskFailed(let underlyingError) = error,
               let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet: throw NetworkError.notConnectedToInternet
                case .cannotConnectToHost: throw NetworkError.connectionFailed
                case .timedOut: throw NetworkError.connectionTimedOut
                default: break
                }
            }

            throw NetworkError.unknown
        }
    }
    
    func request(_ router: URLRequestConvertible) async throws
        -> Void
    {
        // Interceptor 설정
        let interceptor = (router as? Router)?.requiresAuth == true ? AuthInterceptor.shared : nil

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
            if let data = response.data,
               let decoded = try? decoder.decode(FAILURE.self, from: data),
               let baseRouter = router as? Router,
               let mappedError = baseRouter.errorMap?.mapped(errorCode: decoded.error.code) {
                throw mappedError
            }
            
            if case .sessionTaskFailed(let underlyingError) = error,
               let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet: throw NetworkError.notConnectedToInternet
                case .cannotConnectToHost: throw NetworkError.connectionFailed
                case .timedOut: throw NetworkError.connectionTimedOut
                default: break
                }
            }

            throw NetworkError.unknown
        }
    }
}
