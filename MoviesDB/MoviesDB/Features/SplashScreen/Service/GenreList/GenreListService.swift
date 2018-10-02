//
//  GenreListService.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// Sub path
///
/// - `default`: path param of genre list
enum GenreListURL: String {
    case `default` = "/genre/movie/list"
}

final class GenreListService: GenreListServiceDelegate {
    
    //MARK: - Variables
    
    /// Api protocol reference
    private let delegate: ApiRequestDelegate
    
    //MARK: - Custom methods
    
    /// Initialization
    ///
    /// - Parameter delegate: Optional api protocol reference. You can override it if will be necessary
    init(delegate: ApiRequestDelegate = ApiRequest()) {
        self.delegate = delegate
    }
    
    func requestGenreList(completion: @escaping GenreListCompletion){
        self.delegate.get(withUrl: GenreListURL.default.rawValue, andParameters: nil) { (data, errorServer) in
            guard let errorObject = errorServer else {
                do {
                    guard
                        let data = data,
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                        let arrayGenre = json[KeysJson.genres.rawValue] as? [[String: Any]]
                        else {
                            return completion([], ErrorMoviesDB(message: R.string.localizable.messageLoadGenreListFail()))
                    }
                    
                    GenreList.save(array: arrayGenre, completion: { (genres: [GenreList]) in
                        let result = genres.map({ (realmObject) -> GenreListRepresentable in
                            return GenreListRepresentable(genreList: realmObject)
                        })
                        DispatchQueue.main.async {
                            completion(result, nil)
                        }
                    })
                } catch {
                    completion([], ErrorMoviesDB(message: R.string.localizable.messageLoadDataFail()))
                }
                return
            }
            
            completion([], errorObject)
        }
    }
    
}
