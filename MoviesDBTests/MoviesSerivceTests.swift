//
//  MoviesServiceTests.swift
//  MoviesDBTests
//
//  Created by Jader Nunes on 2018-09-17.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest

@testable import MoviesDB

class MoviesServiceTests: XCTestCase {
    
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
    
    func testPopularServiceFail(){
        let expc = self.expectation(description: #function)
        
        let service = PopularService()
        service.requestPopular(page: 1) { (movies, page, error) in
            expc.fulfill()
            XCTAssertNotNil(error)
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testAppendTopRatedMovies(){
        let expc = self.expectation(description: #function)
        
        urlbase = urlPathConfig
        let viewModel = ListTopRatedViewModel()
        viewModel.requestTopRated(page: 1) {
            expc.fulfill()
            XCTAssertGreaterThan(viewModel.movies.value.count, 0)
        }
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testRequestAndAppendPupularMovies(){
        let expc = self.expectation(description: #function)
        
        urlbase = urlPathConfig
        let viewModel = ListPopularViewModel()
        viewModel.requestPopular(page: 1) {
            expc.fulfill()
            XCTAssertGreaterThan(viewModel.movies.value.count, 0)
        }
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testRequestLocalDataMovieDetailViewModel(){
        let expc = self.expectation(description: #function)
        
        urlbase = urlPathConfig
        let viewModelMovieDetail = MovieDetailViewModel()
        let viewModelListPopular = ListPopularViewModel()
        
        viewModelListPopular.requestPopular(page: 1) {
            XCTAssertGreaterThan(viewModelListPopular.movies.value.count, 0)
            
            if let idMovie = viewModelListPopular.movies.value.first?.getId().value {
                viewModelMovieDetail.requestData(idMovie: idMovie, completion: { (hasLocalData) in
                    expc.fulfill()
                    XCTAssertTrue(hasLocalData)
                })
            } else {
                expc.fulfill()
                XCTAssertTrue(false)
            }
        }
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testRequestThereIsNoLocalDataMovieDetailViewModel(){
        let expc = self.expectation(description: #function)
        
        urlbase = urlPathConfig
        let viewModel = MovieDetailViewModel()
        viewModel.requestData(idMovie: -1, completion: { (hasLocalData) in
            expc.fulfill()
            XCTAssertFalse(hasLocalData)
        })
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
}
