//
//  MovieTopRatedRepresentable.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-30.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class MovieTopRatedRepresentable: MovieRepresentable {
    
    private var genre_ids = [Int]()
    
    init(movieTopRated: MovieTopRated?) {
        self.genre_ids = movieTopRated?.getGenreIds() ?? []
        super.init(movie: movieTopRated)
    }
    
    override func getGenreNames(completion: @escaping (([String]) -> Void)) {
        var listGenres: [String] = []
        GenreList.allObjects(completion: { (genres: [GenreList]) in
                self.genre_ids.forEach({ (idGenre) in
                    if let name = genres.filter({ $0.getId() == idGenre }).first?.getName() {
                        listGenres.append(name)
                    }
                })
                completion(listGenres)
        })
    }
}
