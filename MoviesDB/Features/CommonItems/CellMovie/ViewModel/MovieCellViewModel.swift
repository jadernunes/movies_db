//
//  MovieCellViewModel.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieCellViewModel {
    
    //MARK: - Variables
    
    var title: Variable<String> = Variable<String>("")
    var genre: Variable<String> = Variable<String>("")
    var date: Variable<String> = Variable<String>("")
    var voteAvarage: Variable<String> = Variable<String>("")
    var urlPoster: Variable<String> = Variable<String>("")
    
    /// Contains movie data
    var movie: MovieRepresentable? {
        didSet {
            guard let movie = movie else { return }
            
            self.title.value = movie.getTitle().value
            self.date.value = movie.getReleaseDate().value.dateToShow()
            self.urlPoster.value = movie.getPosterPath().value
            self.voteAvarage.value = "\(movie.getVoteAvarage().value)"
            
            movie.getGenreNames { [weak self] (genres) in
                guard
                    let `self` = self,
                    let genre = genres.first
                    else { return }
                let genreInfo = genre.count > 1 ? "\(genre) + \(genres.count - 1)" : genre
                self.genre.value = genreInfo
            }
        }
    }
}
