//
//  APIError.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 31/01/24.
//

import Foundation

enum APIError: Error, Equatable {

    case invalidJSONFormat
    case customerError(code: String, message: String)
    case unknown
    
    var errorMessage: String {
        switch self {
        case .customerError(_, let message):
            return message
            
        case .invalidJSONFormat:
            return "Invalid JSON Format"
            
        case .unknown:
            return "Unknown Error"
        }
    }
    
    var errorCode: String {
        switch self {
        case .customerError(let code, _):
            return code
        default:
            return "Error"
        }
    }
}
