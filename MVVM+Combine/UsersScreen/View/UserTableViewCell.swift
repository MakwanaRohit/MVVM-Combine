//
//  UserTableViewCell.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 29/01/24.
//

import UIKit

final class UserTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    typealias ViewModel = UserCellViewModel
    
    // MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    
    // MARK: - Bind ViewModel
    func bindViewModel(_ viewModel: UserCellViewModel) {
        nameLabel.text = "Name: \(viewModel.name)"
        emailLabel.text = "Email: \(viewModel.email)"
        phoneLabel.text = "Phone: \(viewModel.phone)"
    }
}
