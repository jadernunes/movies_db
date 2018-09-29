//
//  Movie.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

class Movie: BaseModel, ModelProtocol {
    
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
    
    func getId() -> Variable<Int> {
        return Variable<Int>(id)
    }
    
    func getVoteAvarage() -> Variable<Double> {
        return Variable<Double>(vote_average)
    }
    
    func getTitle() -> Variable<String> {
        guard let title = title else { return Variable<String>("") }
        return Variable<String>(title)
    }
    
    func getPosterPath() -> Variable<String> {
        guard let poster_path = poster_path else { return Variable<String>("") }
        return Variable<String>(poster_path)
    }
    
    func getOriginalLanguage() -> Variable<String> {
        guard let original_language = original_language else { return Variable<String>("") }
        return Variable<String>(original_language)
    }
    
    func getBackdropPath() -> Variable<String?> {
        guard let backdrop_path = backdrop_path else { return Variable<String?>("") }
        return Variable<String?>(backdrop_path)
    }
    
    func isAdult() -> Variable<Bool> {
        guard let adult = adult else { return Variable<Bool>(true) }
        return Variable<Bool>(adult)
    }
    
    func getOverview() -> Variable<String> {
        guard let overview = overview else { return Variable<String>("") }
        return Variable<String>(overview)
    }
    
    func getReleaseDate() -> Variable<String> {
        guard let release_date = release_date else { return Variable<String>("") }
        return Variable<String>(release_date)
    }
    
    func getGenreNames(completion: @escaping (([String]) -> Void)) {
        var listGenres: [String] = []
        self.genres.forEach({ (genre) in
            let name = genre.getName().value
            if  name.count > 0 {
                listGenres.append(name)
            }
        })
        completion(listGenres)
    }
}
