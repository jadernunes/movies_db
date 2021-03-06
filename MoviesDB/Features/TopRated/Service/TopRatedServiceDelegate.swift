//
//  TopRatedServiceDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// Representation of data result
typealias TopRatedCompletion = ((_ movies: [MovieTopRatedRepresentable], _ page: Int, _ error: ErrorMoviesDB?) -> Void)

protocol TopRatedServiceDelegate {
    
    /// Request top rated movies
    ///
    /// - Parameters:
    ///   - page: number of the next page
    ///   - completion: result of request
    func requestTopRated(page: Int, completion: @escaping TopRatedCompletion)
}
