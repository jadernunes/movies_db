//
//  MovieDetailControllerDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// PopularControllerDelegate protocol to request Model to Api
protocol MovieDetailControllerDelegate  {
    
    /// Controller movie detail
    ///
    /// - Parameter delegate: Optional api protocol reference. You can override it if will be necessary
    init(delegate: MovieDetailServiceDelegate)
    
    /// Request Popular movies
    ///
    /// - Parameters:
    ///   - idMovie: id of the movie
    ///   - completion: result of request
    func requestMovieDetail(idMovie: Int, completion: @escaping MovieDetailCompletion)
}

