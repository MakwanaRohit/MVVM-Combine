//
//  UsersViewController.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 27/01/24.
//

import UIKit
import Combine

final class UsersViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private let input : PassthroughSubject<UserInput, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    private let viewmodel: UserViewModelProtocol = UserViewModel()
    private(set) var users = [UserCellViewModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

// MARK: - Configure Screen
extension UsersViewController {
    
    private func configuration() {
        
        configureTableView()
        
        bindViewModel()
        
        input.send(.viewDidLoad)
    }
    
    private func configureTableView() {
        
        tableView.register(UserTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - Bind ViewModel
extension UsersViewController {
    
    private func bindViewModel() {
        
        let output = viewmodel.transform(input: input.eraseToAnyPublisher())
        
        output.receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                
                guard let `self` = self else { return }
                
                switch event {
                    
                case .showLoader(let showLoader):
                    if showLoader {
                        self.tableView.setActivityLoader()
                    } 
                    else {
                        self.tableView.restoreBackgroundView()
                    }
                    
                case .showErrorMessage(let message):
                    self.showAlert(message: message)
                    
                case .users(let users) :
                    self.users = users
                }
            }
            .store(in: &cancellables)
    }
}
