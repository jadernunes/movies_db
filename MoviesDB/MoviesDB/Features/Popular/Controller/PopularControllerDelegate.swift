//
//  PopularControllerDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// PopularControllerDelegate protocol to request Model to Api
protocol PopularControllerDelegate  {
    
    /// Controller initialization
    ///
    /// - Parameter delegate: Optional api protocol reference. You can override it if will be necessary
    init(delegate: PopularServiceDelegate)
    
    /// Request Popular movies
    ///
    /// - Parameters:
    ///   - page: number of the next page
    ///   - completion: result of request
    func requestPopular(page: Int, completion: @escaping PopularCompletion)
    
}
