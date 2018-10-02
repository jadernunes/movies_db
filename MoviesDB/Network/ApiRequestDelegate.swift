//
//  ApiRequestDelegate.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

typealias ParametersApiRequest = [String: Any]

protocol ApiRequestDelegate {
    
    /// Representation of data result
    typealias RequestCompletion = ((Data?, ErrorMoviesDB?) -> Void)
    
    /// Base request method
    ///
    /// - Parameters:
    ///   - url: sub path after url base
    ///   - params: json with query params
    ///   - completion: result of request
    func get(withUrl url: String, andParameters params: ParametersApiRequest?, andCompletion completion: @escaping RequestCompletion)
}
