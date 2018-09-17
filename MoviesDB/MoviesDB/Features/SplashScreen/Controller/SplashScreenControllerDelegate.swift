//
//  SplashScreenControllerDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// SplashScreenControllerDelegate protocol to request Model to Api
protocol SplashScreenControllerDelegate  {
    
    /// The alias to represent the closure of the request
    typealias InitialDataCompletion = ((Bool, ErrorMoviesDB?) -> Void)
    
    /// Controller initialization
    ///
    /// - Parameter delegate: Optional api protocol reference. You can override it if will be necessary
    init(delegateConfiguration: ConfigurationServiceDelegate, delegateGenreList: GenreListServiceDelegate)
    
    /// Request Initial data
    ///
    /// - Parameters:
    ///   - completion: return a completion response
    func requestInitialData(completion: @escaping InitialDataCompletion)
    
}
