//
//  AuthInterceptor.swift
//  Torium
//
//  Created by 최진모 on 12/31/25.
//

import Foundation
import Alamofire

final class AuthInterceptor: RequestInterceptor {
    static let shared = AuthInterceptor()
    private init() {}
    
    // header에 토큰 달기
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = KeyChainManager.shared.readToken(type: .accessToken) else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    // api 요청 실패 시
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // 401 에러인지 판별
        print(error)
        guard let afError = error as? AFError, afError.isResponseValidationError else {
            completion(.doNotRetry)
            return
        }

        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        Task {
            do {
                guard let refreshToken = await KeyChainManager.shared.readToken(type: .refreshToken) else {
                    completion(.doNotRetry)
                    return
                }
        
                let dto: TokenDTO = try await Network.shared.request(AuthRouter.refreshToken(refreshToken: refreshToken))
            
                _ = await KeyChainManager.shared.saveToken(type: .accessToken, token: dto.accessToken)
                _ = await KeyChainManager.shared.saveToken(type: .refreshToken, token: dto.accessToken)
                
                completion(.retry)
            } catch(let err) {
                completion(.doNotRetryWithError(err))
            }
        }
    }
}
