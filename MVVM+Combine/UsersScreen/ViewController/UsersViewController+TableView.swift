//
//  UsersViewController+TableView.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 31/01/24.
//

import UIKit

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UserTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.bindViewModel(users[indexPath.row])
        return cell
    }
}
