//
//  MoyaProvider+Default.swift
//  MVVM+Combine
//
//  Created by rohitmakwana on 31/01/24.
//

import Foundation
import Moya
import Alamofire

extension MoyaProvider {
    
    public static func defaultProvider() -> MoyaProvider {
        return MoyaProvider(session: defaultSession(), plugins: defaultPlugins())
    }
    
    static private func defaultPlugins() -> [PluginType] {
        [
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        ]
    }
    
    static private func defaultSession() -> Alamofire.Session {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        
        return Alamofire.Session(configuration: configuration)
    }
}
