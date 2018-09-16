//
//  DatabaseManager.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - Save objects

func saveObject<T: BaseModel>(_ typeObject: T.Type, content: [String: Any], completion:@escaping ((T?) -> Void)) {
    threadDefault.async {
        var object: T?
        do {
            let realm = try Realm()
            try realm.write {
                object = realm.create(T.self, value: content, update: true)
            }
        } catch let err {
            print("Error while writing '\(T.self.description())' to realm: \(err)")
            completion(nil)
        }
        
        completion(object)
    }
}

func saveObjects<T: BaseModel>(_ typeObject: T.Type, array: [[String: Any]], completion:@escaping (([T]) -> Void)) {
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

//MARK: - Get objects

func getObjects<T: BaseModel>(_ typeObject: T.Type, completion:@escaping (([T]) -> Void)) {
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

func getObjects<T: BaseModel>(_ typeObject: T.Type, filter: String, completion:@escaping (([T]) -> Void)) {
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

//MARK: - Update objects

func updateObject<T: BaseModel>(object: T, value: Any?, key: String, completion:@escaping ((Bool) -> Void)) {
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
