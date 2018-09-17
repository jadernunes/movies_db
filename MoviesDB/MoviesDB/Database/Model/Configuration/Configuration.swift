//
//  Configuration.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-15.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

class Configuration: BaseModel, ModelProtocol {
    
    //MARK: - Attributes
    
    @objc private dynamic var id: Int = 0
    @objc private dynamic var base_url: String = ""
    @objc private dynamic var secure_base_url: String = ""
    private var backdrop_sizes = List<String>()
    private var logo_sizes = List<String>()
    private var poster_sizes = List<String>()
    private var profile_sizes = List<String>()
    private var still_sizes = List<String>()
    
    open override static func primaryKey() -> String? {
        return "id"
    }
    
    //MARK: - Custom methods
    
    func getBaseUrl() -> Variable<String> {
        return Variable<String>(base_url)
    }
    
    func getBackdropSizes() -> Variable<[String]> {
        return Variable<[String]>(Array(backdrop_sizes))
    }
    
    func getLogoSizes() -> Variable<[String]> {
        return Variable<[String]>(Array(logo_sizes))
    }
    
    func getPosterSizes() -> Variable<[String]> {
        return Variable<[String]>(Array(poster_sizes))
    }
    
    func getProfileSizes() -> Variable<[String]> {
        return Variable<[String]>(Array(profile_sizes))
    }
    
    func getStillSizes() -> Variable<[String]> {
        return Variable<[String]>(Array(still_sizes))
    }
}

