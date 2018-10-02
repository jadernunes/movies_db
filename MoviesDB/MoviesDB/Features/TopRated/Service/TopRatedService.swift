//
//  TopRatedService.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

/// Sub path
///
/// - `default`: path param of TopRated
enum TopRatedURL: String {
    case `default` = "/movie/top_rated"
}

final class TopRatedService: TopRatedServiceDelegate {
    
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
    
    func requestTopRated(page: Int, completion: @escaping TopRatedCompletion){
        
        let params = ["page": page]
        
        self.delegate.get(withUrl: TopRatedURL.default.rawValue, andParameters: params) { (data, errorServer) in
            guard let errorObject = errorServer else {
                do {
                    guard
                        let data = data,
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                        let results = json[KeysJson.results.rawValue] as? [[String: Any]], results.count > 0,
                        let pageReceived = json[KeysJson.page.rawValue] as? Int
                        else {
                            return completion([], page, ErrorMoviesDB(message: R.string.localizable.messageLoadTopRatedFail()))
                    }
                    
                    save(type: MovieTopRated.self, array: results, completion: { (array: [MovieTopRated]) in
                        let result = array.map({ (realmObject) -> MovieTopRatedRepresentable in
                            return MovieTopRatedRepresentable(movieTopRated: realmObject)
                        })
                        
                        DispatchQueue.main.async {
                            completion(result, pageReceived, nil)
                        }
                    })
                } catch {
                    completion([], page, ErrorMoviesDB(message: R.string.localizable.messageLoadDataFail()))
                }
                return
            }
            
            completion([], page, errorObject)
        }
    }
    
}
