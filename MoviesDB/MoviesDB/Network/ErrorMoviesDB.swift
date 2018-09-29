//
//  ErrorMoviesDB.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-16.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation

struct ErrorMoviesDB {
    
    var message: String = ""
    
    init?(error: Error?) {
        guard let message = error?.localizedDescription else {
            return nil
        }
        self.message = message
    }
    
    init(message: String) {
        self.message = message
    }
    
}
