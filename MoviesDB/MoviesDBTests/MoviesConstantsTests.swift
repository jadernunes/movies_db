//
//  MoviesConstantsTests.swift
//  MoviesDBTests
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest

@testable import MoviesDB

class MoviesConstantsTests: XCTestCase {
    
    func testExistBaseURL(){
        XCTAssertNotEqual(urlbase, "","Should exist a url base to request data from server")
    }
    
    func testExistApiKey(){
        XCTAssertNotEqual(apiKey, "")
    }
    
    func testBasePrimaryKey(){
        XCTAssertNotEqual(basePrimaryKeyModel, "")
    }
    
    func testKeysJson(){
        var key = KeysJson.statusMessage.rawValue
        XCTAssertGreaterThan(key.count, 0)
        
        key = KeysJson.apiKey.rawValue
        XCTAssertGreaterThan(key.count, 0)
        
        key = KeysJson.urlBase.rawValue
        XCTAssertGreaterThan(key.count, 0)
        
        key = KeysJson.config.rawValue
        XCTAssertGreaterThan(key.count, 0)
        
        key = KeysJson.images.rawValue
        XCTAssertGreaterThan(key.count, 0)
        
        key = KeysJson.results.rawValue
        XCTAssertGreaterThan(key.count, 0)
        
        key = KeysJson.page.rawValue
        XCTAssertGreaterThan(key.count, 0)
        
        key = KeysJson.genres.rawValue
        XCTAssertGreaterThan(key.count, 0)
    }
    
    func testInitErrorMoviesDB(){
        let message = "Fail"
        let error = ErrorMoviesDB(message: message)
        XCTAssertEqual(error.message, message)
    }
}
