//
//  MoviesOpenViewsTests.swift
//  MoviesDBTests
//
//  Created by Jader Nunes on 2018-09-18.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import XCTest

@testable import MoviesDB

class MoviesOpenViewsTests: XCTestCase {
    
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
    
    func testLoadInitalDataFail(){
        let expc = self.expectation(description: #function)
        
        guard let splashScreen = R.storyboard.splashScreen.splashScreenViewController() else {
            expc.fulfill()
            XCTAssertTrue(false, "There is no exist splashScreenViewController: \(#function)")
            return
        }
        
        Utils.visibleViewController()?.present(splashScreen, animated: true, completion: {
            expc.fulfill()
            XCTAssertTrue(splashScreen.hasErrorInitalData(), "The initial config should be nil: \(#function)")
        })
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testIsLoadingCollectionViewCellLoader(){
        guard let cell = R.nib.loadingCollectionViewCell().instantiate(withOwner: nil, options: nil).first as? LoadingCollectionViewCell else {
            XCTAssertTrue(false)
            return
        }
        cell.configure()
        XCTAssertTrue(cell.activityIndicatorLoading.isAnimating)
    }
    
    func testOpenMovieDetailViewController(){
        let expc = self.expectation(description: #function)
        
        guard let viewController = R.storyboard.movie.movieDetailViewController() else {
            expc.fulfill()
            XCTAssertTrue(false)
            return
        }
        
        Utils.visibleViewController()?.present(viewController, animated: true, completion: {
            expc.fulfill()
            XCTAssertTrue(true)
        })
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
    func testOpenListPopularViewController(){
        let expc = self.expectation(description: #function)
        
        guard let viewController = R.storyboard.popular.listPopularViewController() else {
            expc.fulfill()
            XCTAssertTrue(false)
            return
        }
        
        Utils.visibleViewController()?.present(viewController, animated: true, completion: {
            expc.fulfill()
            XCTAssertTrue(true)
        })
        
        waitForExpectations(timeout: apiTimeout, handler: nil)
    }
    
}
