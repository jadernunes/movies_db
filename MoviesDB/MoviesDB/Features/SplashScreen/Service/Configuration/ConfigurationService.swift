//
//  ConfigurationService.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// Sub path
///
/// - `default`: path param of Configuration
enum ConfigurationURL: String {
    case `default` = "/configuration"
}

final class ConfigurationService: ConfigurationServiceDelegate {
    
    //MARK: - Variables
    
    /// Api protocol reference
    private let delegate: ApiRequestDelegate
    
    //MARK: - Custom methods
    
    /// Initialization
    ///
    /// - Parameter delegate: Optional api protocol reference. You can override it if will be necessary
    init(delegate: ApiRequestDelegate = ApiRequest()) {
        self.delegate = delegate
    }
    
    func requestConfiguration(completion: @escaping ConfigurationCompletion){
        self.delegate.get(withUrl: ConfigurationURL.default.rawValue, andParameters: nil) { (data, errorServer) in
            guard let errorObject = errorServer else {
                do {
                    guard
                        let data = data,
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                        let configurationJson = json[KeysJson.images.rawValue] as? [String: Any]
                        else {
                            return completion(nil, ErrorMoviesDB(message: R.string.localizable.messageLoadImagesFail()))
                    }
                    
                    Configuration.save(data: configurationJson, completion: { (object: Configuration?) in
                        let represent = ConfigurationRepresentable(configuration: object)
                        DispatchQueue.main.async {
                            completion(represent,nil)
                        }
                    })
                } catch {
                    completion(nil, ErrorMoviesDB(message: R.string.localizable.messageLoadDataFail()))
                }
                return
            }
            
            completion(nil, errorObject)
        }
    }
    
}
