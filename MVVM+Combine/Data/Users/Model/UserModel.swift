//
//  UserModel.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 29/01/24.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    
    var formattedAddress: String {
        "\(address.street), \(address.suite), \(address.city) - \(address.zipcode)"
    }
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}
