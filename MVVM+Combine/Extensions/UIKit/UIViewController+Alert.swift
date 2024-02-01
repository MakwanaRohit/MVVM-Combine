//
//  UIViewController+Alert.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 31/01/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
