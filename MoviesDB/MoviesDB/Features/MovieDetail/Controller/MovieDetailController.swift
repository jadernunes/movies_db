//
//  MovieDetailController.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

final class MovieDetailController: MovieDetailControllerDelegate {
    
    /*
     We are using a controller to call one or more requests if necessary and mount all data to return it together to ViewModel
     */
    
    //MARK: - Variables
    
    /// Api protocol reference
    private let delegate: MovieDetailServiceDelegate
    
    //MARK: - Life cycle
    
    required init(delegate: MovieDetailServiceDelegate = MovieDetailService()) {
        self.delegate = delegate
    }
    
    //MARK: - Custom methods
    
    func requestMovieDetail(idMovie: Int, completion: @escaping MovieDetailCompletion){
        delegate.requestMovieDetail(idMovie: idMovie, completion: completion)
    }
}
