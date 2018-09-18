//
//  MoviesControllerTests.swift
//  MoviesDBTests
//
//  Created by Jader Nunes on 2018-09-18.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest

@testable import MoviesDB

class MoviesControllerTests: XCTestCase {
    
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
    
    func testCompletionPopularController(){
        let expc = self.expectation(description: #function)
        
        let controller = PopularController()
        controller.requestPopular(page: 1) { (movies, page, error) in
            expc.fulfill()
            XCTAssertGreaterThan(page, 0)
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testCompletionMovieDetailController(){
        let expc = self.expectation(description: #function)
        
        urlbase = urlPathConfig
        let controller = MovieDetailController()
        let viewModel = ListPopularViewModel()
        viewModel.requestPopular(page: 1) {
            XCTAssertGreaterThan(viewModel.movies.value.count, 0)
            if let idMovie = viewModel.movies.value.first?.getId().value {
                controller.requestMovieDetail(idMovie: idMovie) { (moive, error) in
                    expc.fulfill()
                    XCTAssertNotNil(moive)
                }
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
}
