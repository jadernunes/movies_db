//
//  BaseModel.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift

let threadDefault = DispatchQueue.main

class BaseModel: Object {
    func getNextId<T: BaseModel>(_ typeObject: T.Type, key: String, completion:@escaping ((CLong) -> Void)) {
        threadDefault.async {
            do {
                let realm = try Realm()
                realm.refresh()
                
                if realm.objects(T.self).count > 0  {
                    let id = realm.objects(T.self).max(ofProperty: key)! + 1
                    completion(id)
                } else {
                    completion(1)
                }
            } catch let err {
                print("Error while getting last id '\(T.self.description())' from realm: \(err)")
                completion(0)
            }
        }
    }
}
