//
//  MovieDetailServiceDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// Representation of data result
typealias MovieDetailCompletion = ((_ movie: MovieRepresentable?, _ error: ErrorMoviesDB?) -> Void)

protocol MovieDetailServiceDelegate {
    
    /// Request popular movies
    ///
    /// - Parameters:
    ///   - idMovie: id of the movie
    ///   - completion: result of request
    func requestMovieDetail(idMovie: Int, completion: @escaping MovieDetailCompletion)
}
