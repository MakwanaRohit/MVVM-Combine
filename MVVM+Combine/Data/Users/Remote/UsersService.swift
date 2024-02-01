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
        return provider.makeRequest(target: .users)
    }
}
