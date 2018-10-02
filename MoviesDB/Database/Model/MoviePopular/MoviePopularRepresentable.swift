//
//  MoviePopularRepresentable.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-30.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class MoviePopularRepresentable: MovieRepresentable {
    
    private var genre_ids = [Int]()
    
    init(moviePopular: MoviePopular?) {
        self.genre_ids = moviePopular?.getGenreIds() ?? []
        super.init(movie: moviePopular)
    }
    
    override func getGenreNames(completion: @escaping (([String]) -> Void)) {
        var listGenres: [String] = []
        allObjects(type: GenreList.self, completion: { (genres: [GenreList]) in
            self.genre_ids.forEach({ (idGenre) in
                if let name = genres.filter({ $0.getId() == idGenre }).first?.getName() {
                    listGenres.append(name)
                }
            })
            completion(listGenres)
        })
    }
}
