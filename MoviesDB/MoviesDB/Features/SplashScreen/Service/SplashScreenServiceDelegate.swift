//
//  SplashScreenServiceDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

protocol SplashScreenServiceDelegate {
    
    /// Representation of data result
    typealias ConfigurationCompletion = ((Configuration?, ErrorMoviesDB?) -> Void)
    
    /// Request base configuration for other requests
    ///
    /// - Parameter completion: result of request
    func requestConfiguration(completion: @escaping ConfigurationCompletion)
}
