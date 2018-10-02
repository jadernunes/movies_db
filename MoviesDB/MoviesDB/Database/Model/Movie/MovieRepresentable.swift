//
//  MovieRepresentable.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-30.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class MovieRepresentable: NSObject {
    
    //MARK: - Attributes
    
    private var id: Int = 0
    private var voteAverage: Double = 0.0
    private var title: String = ""
    private var posterPath: String = ""
    private var originalLanguage: String = ""
    private var backdropPath: String = ""
    private var adult: Bool = false
    private var overview: String = ""
    private var releaseDate: String = ""
    private var genres = [GenreList]()
    
    //MARK: - Custom methods
    
    init(movie: Movie?) {
        id = movie?.getId() ?? 0
        voteAverage = movie?.getVoteAvarage() ?? 0.0
        title = movie?.getTitle() ?? ""
        posterPath = movie?.getPosterPath() ?? ""
        originalLanguage = movie?.getOriginalLanguage() ?? ""
        backdropPath = movie?.getBackdropPath() ?? ""
        adult = movie?.isAdult() ?? false
        overview = movie?.getOverview() ?? ""
        releaseDate = movie?.getReleaseDate() ?? ""
        genres = movie?.getGenres() ?? []
    }
    
    func getId() -> Variable<Int> {
        return Variable<Int>(id)
    }
    
    func getVoteAvarage() -> Variable<Double> {
        return Variable<Double>(voteAverage)
    }
    
    func getTitle() -> Variable<String> {
        return Variable<String>(title)
    }
    
    func getPosterPath() -> Variable<String> {
        return Variable<String>(posterPath)
    }
    
    func getOriginalLanguage() -> Variable<String> {
        return Variable<String>(originalLanguage)
    }
    
    func getBackdropPath() -> Variable<String?> {
        return Variable<String?>(backdropPath)
    }
    
    func isAdult() -> Variable<Bool> {
        return Variable<Bool>(adult)
    }
    
    func getOverview() -> Variable<String> {
        return Variable<String>(overview)
    }
    
    func getReleaseDate() -> Variable<String> {
        return Variable<String>(releaseDate)
    }
    
    func getGenreNames(completion: @escaping (([String]) -> Void)) {
        var listGenres: [String] = []
        self.genres.forEach({ (genre) in
            let name = genre.getName()
            if  name.count > 0 {
                listGenres.append(name)
            }
        })
        completion(listGenres)
    }
}
