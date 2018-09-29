//
//  PopularServiceDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// Representation of data result
typealias PopularCompletion = ((_ movies: [MoviePopular], _ page: Int, _ error: ErrorMoviesDB?) -> Void)

protocol PopularServiceDelegate {
    
    /// Request popular movies
    ///
    /// - Parameters:
    ///   - page: number of the next page
    ///   - completion: result of request
    func requestPopular(page: Int, completion: @escaping PopularCompletion)
}
