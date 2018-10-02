//
//  GenreListRepresentable.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-30.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class GenreListRepresentable: RepresentableBase {
    
    //MARK: - Attributes
    
    private var name = ""

    //MARK: - Custom methods
    
    init(genreList: GenreList?) {
        super.init()
        
        id = genreList?.getId() ?? 0
        name = genreList?.getName() ?? ""
    }
    
    func getName() -> Variable<String> {
        return Variable<String>(name)
    }
}
