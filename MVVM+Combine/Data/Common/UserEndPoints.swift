//
//  UserEndPoints.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 29/01/24.
//

import Foundation
import Moya

enum UserEndPoints {
    case users
}

extension UserEndPoints: TargetType {
    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .users:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .users:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .users:
            return  Data()
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
