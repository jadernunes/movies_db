//
//  MoviesRouterTests.swift
//  MoviesDBTests
//
//  Created by Jader Nunes on 2018-09-18.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest

@testable import MoviesDB

class MoviesRouterTests: XCTestCase {
    
    var urlPathConfig = ""
    
    override func setUp() {
        super.setUp()
        
        urlPathConfig = urlbase
        urlbase = "..."
    }
    
    override func tearDown() {
        urlbase = urlPathConfig
        
        super.tearDown()
    }
    
    func testRouterPopular(){
        let expc = self.expectation(description: #function)
        
        urlbase = urlPathConfig
        let viewModelListPopular = ListPopularViewModel()
        
        viewModelListPopular.requestPopular(page: 1) {
            XCTAssertGreaterThan(viewModelListPopular.movies.value.count, 0)
            
            if let idMovie = viewModelListPopular.movies.value.first?.getId().value {
                RouterPopular().navigate(screen: .movieDetail, idMovie: idMovie){
                    let isMovieDetail = Utils.visibleViewController() is MovieDetailViewController
                    expc.fulfill()
                    XCTAssertTrue(isMovieDetail)
                }
            } else {
                expc.fulfill()
                XCTAssertTrue(false)
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testRouterTopRated(){
        let expc = self.expectation(description: #function)
        
        urlbase = urlPathConfig
        let viewModelListPopular = ListPopularViewModel()
        
        viewModelListPopular.requestPopular(page: 1) {
            XCTAssertGreaterThan(viewModelListPopular.movies.value.count, 0)
            
            if let idMovie = viewModelListPopular.movies.value.first?.getId().value {
                RouterTopRated().navigate(screen: .movieDetail, idMovie: idMovie){
                    let isMovieDetail = Utils.visibleViewController() is MovieDetailViewController
                    expc.fulfill()
                    XCTAssertTrue(isMovieDetail)
                }
            } else {
                expc.fulfill()
                XCTAssertTrue(false)
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
}
