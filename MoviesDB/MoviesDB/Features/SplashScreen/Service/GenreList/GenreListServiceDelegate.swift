//
//  GenreListServiceDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

protocol GenreListServiceDelegate {
    
    /// Representation of data result
    typealias GenreListCompletion = ((_ genres: [GenreList], _ error: ErrorMoviesDB?) -> Void)
    
    /// Request genre list
    ///
    /// - Parameter completion: result of request
    func requestGenreList(completion: @escaping GenreListCompletion)
}
