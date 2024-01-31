//
//  UserViewModel.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 27/01/24.
//

import Foundation
import Combine

protocol UserViewModelProtocol: AnyObject {
    func transform(input: AnyPublisher<UserInput, Never>) -> AnyPublisher<UserOutput, Never>
}

final class UserViewModel: UserViewModelProtocol {
    
    private let output: PassthroughSubject<UserOutput, Never> = .init()
    private var bindings = Set<AnyCancellable>()
    private let userDataLogic: UserDataLogicProtocol

    init(userDataLogic: UserDataLogicProtocol = UserDataLogic()) {
        self.userDataLogic = userDataLogic
    }
    
    func transform(input: AnyPublisher<UserInput, Never>) -> AnyPublisher<UserOutput, Never> {
        input.sink { [weak self] event in
            guard let `self` = self else { return }
            
            switch event {
            case .viewDidLoad:
                self.getUsers()
            }
        }
        .store(in: &bindings)

        return output.eraseToAnyPublisher()
    }
    
    private func getUsers() {
        
        self.output.send(.showLoader(true))
        
        self.userDataLogic.getUserProfile()
            .sink(receiveCompletion: { [weak self] result in
                
                guard let `self` = self else { return }
                
                self.output.send(.showLoader(true))
                
                switch result {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.output.send(.showErrorMessage(error.localizedDescription))
                    self.output.send(.users([]))
                }
            }, receiveValue: {  [weak self] users in
                
                guard let `self` = self else { return }
                
                print(users)
                self.output.send(.users(self.transformUsers(users)))
            })
            .store(in: &bindings)
    }
    
    private func transformUsers(_ users: [UserModel]) -> [UserCellViewModel] {
        users.map { user in
            UserCellViewModel(
                id: user.id,
                name: user.name,
                phone: user.phone,
                email: user.email
            )
        }
    }
}

enum UserInput {
    case viewDidLoad
}

enum UserOutput {
    case showLoader(Bool)
    case users(_ users: [UserCellViewModel])
    case showErrorMessage(_ message: String)
}


