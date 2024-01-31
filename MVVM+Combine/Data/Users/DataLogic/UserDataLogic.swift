//
//  UserDataLogic.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 29/01/24.
//

import Foundation
import Moya
import CombineMoya
import Combine

protocol UserDataLogicProtocol {
    func getUserProfile() -> AnyPublisher<[UserModel], Error>
}

final class UserDataLogic: UserDataLogicProtocol {
    
    let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func getUserProfile() -> AnyPublisher<[UserModel], Error> {
        self.userService.getUserProfile()
    }
}
