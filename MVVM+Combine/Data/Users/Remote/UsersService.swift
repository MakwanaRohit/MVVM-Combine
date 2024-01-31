//
//  UsersService.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 29/01/24.
//

import Foundation
import Moya
import CombineMoya
import Combine

protocol UserServiceProtocol {
    func getUserProfile() -> AnyPublisher<[UserModel], Error>
}

final class UserService: UserServiceProtocol {
    let provider: MoyaProvider<UserEndPoints>
    
    init(provider: MoyaProvider<UserEndPoints> = .defaultProvider()) {
        self.provider = provider
    }

    func getUserProfile() -> AnyPublisher<[UserModel], Error> {
        return provider.requestPublisher(.users)
            .tryMap { result in
                guard let response = result.response, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .catch { _ in Fail(error: APIError.invalidJSONFormat).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}
