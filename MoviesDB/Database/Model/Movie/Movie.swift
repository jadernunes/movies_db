//
//  Movie.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Movie: Object {
    
    //MARK: - Attributes
    
    @objc private dynamic var id: Int = 0
    @objc private dynamic var vote_average: Double = 0.0
    @objc private dynamic var title: String? = ""
    @objc private dynamic var poster_path: String? = ""
    @objc private dynamic var original_language: String? = ""
    @objc private dynamic var backdrop_path: String? = ""
    private var adult: Bool? = false
    @objc private dynamic var overview: String? = ""
    @objc private dynamic var release_date: String? = ""
    private var genres = List<GenreList>()
    
    open override static func primaryKey() -> String? {
        return basePrimaryKeyModel
    }
    
    //MARK: - Custom methods
    
    func getId() -> Int {
        return id
    }
    
    func getVoteAvarage() -> Double {
        return vote_average
    }
    
    func getTitle() -> String {
        return title ?? ""
    }
    
    func getPosterPath() -> String {
        return poster_path ?? ""
    }
    
    func getOriginalLanguage() -> String {
        return original_language ?? ""
    }
    
    func getBackdropPath() -> String? {
        return backdrop_path
    }
    
    func isAdult() -> Bool {
        return adult ?? false
    }
    
    func getOverview() -> String {
        return overview ?? ""
    }
    
    func getReleaseDate() -> String {
        return release_date ?? ""
    }
    
    func getGenres() -> [GenreList] {
        return Array(genres)
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
