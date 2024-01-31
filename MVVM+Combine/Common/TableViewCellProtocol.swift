//
//  TableViewCellProtocol.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 29/01/24.
//

import Foundation

protocol TableViewCellProtocol: AnyObject {
    associatedtype ViewModel

    func bindViewModel(_ viewModel: ViewModel)
}
