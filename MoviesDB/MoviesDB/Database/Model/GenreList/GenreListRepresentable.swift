//
//  GenreListRepresentable.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-30.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class GenreListRepresentable {
    
    //MARK: - Attributes
    
    private var id = 0
    private var name = ""

    //MARK: - Custom methods
    
    init(genreList: GenreList?) {
        id = genreList?.getId() ?? 0
        name = genreList?.getName() ?? ""
    }
    
    func getId() -> Variable<Int> {
        return Variable<Int>(id)
    }
    
    func getName() -> Variable<String> {
        return Variable<String>(name)
    }
}
