//
//  GenreList.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

class GenreList: BaseModel, ModelProtocol {
    
    //MARK: - Attributes
    
    @objc private dynamic var id: Int = 0
    @objc private dynamic var name: String? = ""
    
    open override static func primaryKey() -> String? {
        return "id"
    }
    
    //MARK: - Custom methods
    
    func getId() -> Variable<Int> {
        return Variable<Int>(id)
    }
    
    func getName() -> Variable<String> {
        guard let name = name else { return Variable<String>("") }
        return Variable<String>(name)
    }
}
