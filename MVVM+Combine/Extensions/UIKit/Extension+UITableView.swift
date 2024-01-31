//
//  Extension+UITableView.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 29/01/24.
//

import Foundation
import UIKit

extension UITableView {

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    func register<T: UITableViewCell>(
        _ cell : T.Type
    ) {
        let identifier = cell.reuseIdentifier
        let nib = UINib(nibName: identifier, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func restoreBackgroundView() {
        backgroundView = nil
    }

    func setActivityLoader(
        _ color: UIColor = .gray,
        style: UIActivityIndicatorView.Style = .large
    ) {
        let loader = UIActivityIndicatorView(style: style)
        loader.color = color
        loader.startAnimating()
        backgroundView = loader
    }
}

protocol ReusableView: AnyObject {}

extension ReusableView {

    static func nib(with bundle: Bundle) -> UINib {
        return UINib(nibName: reuseIdentifier, bundle: bundle)
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
