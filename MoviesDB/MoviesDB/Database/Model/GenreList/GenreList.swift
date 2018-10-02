//
//  GenreList.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class GenreList: Object, ModelProtocol {
    
    //MARK: - Attributes
    
    @objc private dynamic var id: Int = 0
    @objc private dynamic var name: String? = ""
    
    open override static func primaryKey() -> String? {
        return basePrimaryKeyModel
    }
    
    //MARK: - Custom methods
    
    func getId() -> Int {
        return id
    }
    
    func getName() -> String {
        return name ?? ""
    }
}
