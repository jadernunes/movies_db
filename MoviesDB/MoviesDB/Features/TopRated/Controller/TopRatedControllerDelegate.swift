//
//  TopRatedControllerDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// TopRatedControllerDelegate protocol to request Model to Api
protocol TopRatedControllerDelegate  {
    
    /// Controller initialization
    ///
    /// - Parameter delegate: Optional api protocol reference. You can override it if will be necessary
    init(delegate: TopRatedServiceDelegate)
    
    /// Request top rated movies
    ///
    /// - Parameters:
    ///   - page: number of the next page
    ///   - completion: result of request
    func requestTopRated(page: Int, completion: @escaping TopRatedCompletion)
    
}
