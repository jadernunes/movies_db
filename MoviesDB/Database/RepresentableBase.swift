//
//  RepresentableBase.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-10-02.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import RxSwift

class RepresentableBase: NSObject {
    
    //MARK: - Attributes
    
    var id: Int = 0
    
    init(id: Int? = 0) {
        self.id = id ?? 0
    }
    
    //MARK: - Custom methods
    
    func getId() -> Variable<Int> {
        return Variable<Int>(id)
    }
}
