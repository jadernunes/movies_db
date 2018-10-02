//
//  ConfigurationDB.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class ConfigurationDB: Object, ModelProtocol {
    
    //MARK: - Attributes
    
    @objc private dynamic var id: Int = 0
    @objc private dynamic var base_url: String = ""
    private var backdrop_sizes = List<String>()
    private var poster_sizes = List<String>()
    
    open override static func primaryKey() -> String? {
        return basePrimaryKeyModel
    }
    
    //MARK: - Custom methods
    
    func getId() -> Int {
        return id
    }
    
    func getBaseUrl() -> String {
        return base_url
    }
    
    func getBackdropSizes() -> [String] {
        return Array(backdrop_sizes)
    }
    
    func getPosterSizes() -> [String] {
        return Array(poster_sizes)
    }
}

