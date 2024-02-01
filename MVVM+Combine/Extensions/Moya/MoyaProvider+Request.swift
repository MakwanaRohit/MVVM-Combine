//
//  MoyaProvider+Request.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 01/02/24.
//

import Foundation
import Moya
import Combine

extension MoyaProvider {
        
    func makeRequest<T: Codable>(target: Target) -> AnyPublisher<T, Error> {
        
        return requestPublisher(target)
            .tryMap { result in
                guard let response = result.response, response.statusCode == 200 else {
                    throw  APIError.customerError(code: URLError.badServerResponse, message: "Bad Server Response")
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: APIError.invalidJSONFormat).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}
