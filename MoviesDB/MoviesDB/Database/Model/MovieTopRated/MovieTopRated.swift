//
//  MovieTopRated.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

class MovieTopRated: Movie {
    
    private var isTopRated: Bool = true
    private var genre_ids = List<Int>()
    
    func getGenreIds() -> Variable<[Int]> {
        return Variable<[Int]>(Array(genre_ids))
    }
    
    override func getGenreNames(completion: @escaping (([String]) -> Void)) {
        var listGenres: [String] = []
        GenreList.allObjects(completion: { (genres) in
            self.genre_ids.forEach({ (idGenre) in
                if let name = genres.filter({ $0.getId().value == idGenre }).first?.getName().value {
                    listGenres.append(name)
                }
            })
            completion(listGenres)
        })
    }
}
