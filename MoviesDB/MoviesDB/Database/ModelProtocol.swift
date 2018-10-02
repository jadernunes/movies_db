//
//  ModelProtocol.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift

let threadDefault = DispatchQueue.main

// MARK: - Base Model protocol
protocol ModelProtocol {
    static func save<T: Object>(array: [[String: Any]], completion: @escaping (([T]) -> Void))
    static func save<T: Object>(data: [String: Any], completion: @escaping ((T?) -> Void))
    static func allObjects<T: Object>(completion: @escaping (([T]) -> Void))
    static func allObjects<T: Object>(filter: String, completion:@escaping (([T]) -> Void))
    static func update<T: Object>(object: T, value: Any?, key: String, completion:@escaping ((Bool) -> Void))
}


// MARK: - To became optional implementation
extension ModelProtocol {
    
    static func save<T: Object>(array: [[String: Any]], completion: @escaping (([T]) -> Void)){
        threadDefault.async {
            var objects: [T] = []
            
            for item in array {
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    
                    let object: T = realm.create(T.self, value: item, update: true)
                    objects.append(object)
                    
                    try realm.commitWrite()
                } catch let err {
                    print("Error while writing '\(T.self.description())' to realm: \(err)")
                }
            }
            
            completion(objects)
        }
    }
    
    static func save<T: Object>(data: [String: Any], completion: @escaping ((T?) -> Void)){
        threadDefault.async {
            var object: T?
            do {
                let realm = try Realm()
                try realm.write {
                    object = realm.create(T.self, value: data, update: true)
                }
            } catch let err {
                print("Error while writing '\(T.self.description())' to realm: \(err)")
                completion(nil)
            }
            
            completion(object)
        }
    }
    
    static func allObjects<T: Object>(completion: @escaping (([T]) -> Void)){
        threadDefault.async {
            do {
                let realm = try Realm()
                realm.refresh()
                let listObjects: [T] = realm.objects(T.self).map{ $0 }
                completion(listObjects)
            } catch let err {
                print("Error while getting all '\(T.self.description())' from realm: \(err)")
                completion([])
            }
        }
    }
    
    static func allObjects<T: Object>(filter: String, completion:@escaping (([T]) -> Void)){
        threadDefault.async {
            do {
                let realm = try Realm()
                realm.refresh()
                let listObjects: [T] = realm.objects(T.self).filter(filter).map{ $0 }
                completion(listObjects)
            } catch let err {
                print("Error while getting '\(T.self.description())' by \(filter)' from realm: \(err)")
                completion([])
            }
        }
    }
    
    static func update<T: Object>(object: T, value: Any?, key: String, completion:@escaping ((Bool) -> Void)){
        threadDefault.async {
            do {
                let realm = try Realm()
                try realm.write {
                    object.setValue(value, forKey: key)
                }
            } catch let err {
                print("Error while updating \(T.self.debugDescription) key '\(key)' with value '\(value.debugDescription)' to realm: \(err.localizedDescription)")
                completion(false)
            }
            
            completion(true)
        }
    }
}
