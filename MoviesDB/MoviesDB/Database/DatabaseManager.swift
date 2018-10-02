//
//  DatabaseManager.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift

let threadRealm = DispatchQueue(label: "com.jader.MoviesDB.realm")
let realmConfiguration: Realm.Configuration = {
    var config = Realm.Configuration(objectTypes: [ConfigurationDB.self, GenreList.self, Movie.self, MovieTopRated.self, MoviePopular.self])
    return config
}()

func save<T: Object>(type: T.Type, array: [[String: Any]], completion: @escaping (([T]) -> Void)){
    threadRealm.async {
        var objects: [T] = []
        
        for item in array {
            do {
                let realm = try Realm(configuration: realmConfiguration)
                realm.beginWrite()
                
                let object: T = realm.create(type, value: item, update: true)
                objects.append(object)
                
                try realm.commitWrite()
            } catch let err {
                print("Error while writing '\(T.self.description())' to realm: \(err)")
            }
        }
        
        completion(objects)
    }
}

func save<T: Object>(type: T.Type, data: [String: Any], completion: @escaping ((T?) -> Void)){
    threadRealm.async {
        var object: T?
        do {
            let realm = try Realm(configuration: realmConfiguration)
            try realm.write {
                object = realm.create(type, value: data, update: true)
            }
        } catch let err {
            print("Error while writing '\(T.self.description())' to realm: \(err)")
            completion(nil)
        }
        
        completion(object)
    }
}

func allObjects<T: Object>(type: T.Type, completion: @escaping (([T]) -> Void)){
    threadRealm.async {
        do {
            let realm = try Realm(configuration: realmConfiguration)
            realm.refresh()
            let listObjects: [T] = realm.objects(type).map{ $0 }
            completion(listObjects)
        } catch let err {
            print("Error while getting all '\(T.self.description())' from realm: \(err)")
            completion([])
        }
    }
}

func allObjects<T: Object>(type: T.Type, filter: String, completion:@escaping (([T]) -> Void)){
    threadRealm.async {
        do {
            let realm = try Realm(configuration: realmConfiguration)
            realm.refresh()
            let listObjects: [T] = realm.objects(type).filter(filter).map{ $0 }
            completion(listObjects)
        } catch let err {
            print("Error while getting '\(T.self.description())' by \(filter)' from realm: \(err)")
            completion([])
        }
    }
}

func update<T: Object>(object: T, value: Any?, key: String, completion:@escaping ((Bool) -> Void)){
    threadRealm.async {
        do {
            let realm = try Realm(configuration: realmConfiguration)
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
