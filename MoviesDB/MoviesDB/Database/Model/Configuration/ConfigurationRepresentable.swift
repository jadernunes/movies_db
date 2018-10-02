//
//  ConfigurationRepresentable.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-30.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class ConfigurationRepresentable {
    
    //MARK: - Attributes
    
    private var id: Int = 0
    private var baseUrl: String = ""
    private var backdropSizes = [String]()
    private var posterSizes = [String]()
    
    init(configuration: Configuration?) {
        id = configuration?.getId() ?? 0
        baseUrl = configuration?.getBaseUrl() ?? ""
        backdropSizes = configuration?.getBackdropSizes() ?? []
        posterSizes = configuration?.getPosterSizes() ?? []
    }
    
    //MARK: - Custom methods
    
    func getId() -> Variable<Int> {
        return Variable<Int>(id)
    }
    
    func getBaseUrl() -> Variable<String> {
        return Variable<String>(baseUrl)
    }
    
    func getBackdropSizes() -> Variable<[String]> {
        return Variable<[String]>(backdropSizes)
    }
    
    func getPosterSizes() -> Variable<[String]> {
        return Variable<[String]>(posterSizes)
    }
}
