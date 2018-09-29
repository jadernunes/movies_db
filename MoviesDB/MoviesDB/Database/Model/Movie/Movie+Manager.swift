//
//  Movie+Manager.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

extension Movie {
    
    static func save<T: Movie>(array: [[String : Any]], completion: @escaping (([T]) -> Void)) {
        saveObjects(T.self, array: array, completion: completion)
    }
    
    static func save<T: Movie>(data: [String : Any], completion: @escaping ((T?) -> Void)) {
        saveObject(T.self, content: data, completion: completion)
    }
    
    static func allObjects<T: Movie>(completion: @escaping (([T]) -> Void)) {
        getObjects(T.self, completion: completion)
    }
    
    static func allObjects<T: Movie>(filter: String, completion:@escaping (([T]) -> Void)){
        getObjects(T.self, filter: filter, completion: completion)
    }
}
