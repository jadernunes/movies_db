//
//  MovieDetailViewModel.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    
    //MARK: - Variables
    
    /// Controller protocol reference
    private let delegate: MovieDetailControllerDelegate
    
    /// Control the request loading status. If TRUE will start the loading and FALSE stop that
    var isLoading: Variable<Bool> = Variable<Bool>(true)
    
    /// Path of backdrop image
    var backdropPath: Variable<String> = Variable<String>("")
    
    /// Path of poster image
    var posterPath: Variable<String> = Variable<String>("")
    
    /// name of the movie
    var name: Variable<String> = Variable<String>("")
    
    /// List final of genres
    var genre: Variable<String> = Variable<String>("")
    
    /// Date of the movie will be available
    var releaseDate: Variable<String> = Variable<String>("")
    
    /// Vote average of the movie
    var voteAverage: Variable<String> = Variable<String>("")
    
    /// Overview of movie story
    var overview: Variable<String> = Variable<String>("")
    
    /// Error when request a movie detail
    var error: Variable<ErrorMoviesDB?> = Variable<ErrorMoviesDB?>(nil)
    
    //MARK: - Life cycle
    
    /// Initialize the ViewModel with a delegate if it'll be necessary
    ///
    /// - Parameter delegate: Optional Controller protocol reference. You can override it if will be necessary
    init(delegate: MovieDetailControllerDelegate = MovieDetailController()) {
        self.delegate = delegate
    }
    
    //MARK: - Custom methods
    
    /// Request new updated data to View Model and then it'll update
    func requestData(idMovie: Int){
        self.isLoading.value = true
        
        self.delegate.requestMovieDetail(idMovie: idMovie) { [weak self] (movie, errorCustom) in
            self?.isLoading.value = false
            self?.error.value = errorCustom
            guard let movie = movie else { return }
            
            self?.backdropPath.value = movie.getBackdropPath().value ?? ""
            self?.posterPath.value = movie.getPosterPath().value
            self?.name.value = movie.getTitle().value
            self?.releaseDate.value = movie.getReleaseDate().value.dateToShow()
            self?.voteAverage.value = movie.getVoteAvarage().value.description
            self?.overview.value = movie.getOverview().value
            self?.configureListGenre(movie: movie)
        }
    }
    
    /// Configure list of genre
    ///
    /// - Parameter movie: object movie
    private func configureListGenre(movie: Movie){
        movie.getGenreNames { (genres) in
            var listGenre = ""
            for (index, name) in genres.enumerated() {
                if index == genres.count-1 {
                    listGenre += "\(name)"
                } else {
                    listGenre += "\(name), "
                }
            }
            self.genre.value = listGenre
        }
    }
    
}
