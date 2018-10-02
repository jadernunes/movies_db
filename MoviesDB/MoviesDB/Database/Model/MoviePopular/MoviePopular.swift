//
//  MoviePopular.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class MoviePopular: Movie {
    
    private var isPopular: Bool = true
    private var genre_ids = List<Int>()
    
    func getGenreIds() -> [Int] {
        return Array(genre_ids)
    }
    
    override func getGenreNames(completion: @escaping (([String]) -> Void)) {
        var listGenres: [String] = []
        GenreList.allObjects(completion: { [weak self] (genres: [GenreList]) in
            self?.genre_ids.forEach({ (idGenre) in
                if let name = genres.filter({ $0.getId() == idGenre }).first?.getName() {
                    listGenres.append(name)
                }
            })
            completion(listGenres)
        })
    }
}
