//
//  MovieDetailService.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// Sub path
///
/// - `default`: path param of Movie
enum MovieURL: String {
    case `default` = "/movie"
}

final class MovieDetailService: MovieDetailServiceDelegate {
    
    //MARK: - Variables
    
    /// Api protocol reference
    private let delegate: ApiRequestDelegate
    
    //MARK: - Custom methods
    
    /// Initialization
    ///
    /// - Parameter delegate: Optional api protocol reference. You can override it if will be necessary
    init(delegate: ApiRequestDelegate = ApiRequest()) {
        self.delegate = delegate
    }
    
    func requestMovieDetail(idMovie: Int, completion: @escaping MovieDetailCompletion){
        
        let urlMovieDetail = "\(MovieURL.default.rawValue)/\(idMovie)"
        
        self.delegate.get(withUrl: urlMovieDetail, andParameters: nil) { (data, errorServer) in
            guard let errorObject = errorServer else {
                do {
                    guard
                        let data = data,
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                        else {
                            return completion(nil, ErrorMoviesDB(message: R.string.localizable.messageLoadMovieDetailFail()))
                    }
                    
                    Movie.save(data: json, completion: { (movie: Movie?) in
                        let represent = MovieRepresentable(movie: movie)
                        completion(represent, nil)
                    })
                } catch {
                    completion(nil, ErrorMoviesDB(message: R.string.localizable.messageLoadDataFail()))
                }
                return
            }
            
            completion(nil, errorObject)
        }
    }
    
}
