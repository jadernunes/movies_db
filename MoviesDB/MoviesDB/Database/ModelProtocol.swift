//
//  ModelProtocol.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Base Model protocol
protocol ModelProtocol {
    static func save<T: BaseModel>(array: [[String: Any]], completion: @escaping (([T]) -> Void))
    static func save<T: BaseModel>(data: [String: Any], completion: @escaping ((T?) -> Void))
    static func allObjects<T: BaseModel>(completion: @escaping (([T]) -> Void))
    static func allObjects<T: BaseModel>(filter: String, completion:@escaping (([T]) -> Void))
}


// MARK: - To became optional implementation
extension ModelProtocol {
    static func save<T: BaseModel>(array: [[String: Any]], completion: @escaping (([T]) -> Void)){}
    static func save<T: BaseModel>(data: [String: Any], completion: @escaping ((T?) -> Void)){}
    static func allObjects<T: BaseModel>(completion: @escaping (([T]) -> Void)){}
    static func allObjects<T: BaseModel>(filter: String, completion:@escaping (([T]) -> Void)){}
}
